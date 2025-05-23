#include "audioplayer.h"
#include <QDebug>
#include <QtMath> // Для qBound


AudioPlayer::AudioPlayer(QObject *parent) : QObject(parent)
{

}

AudioPlayer::~AudioPlayer()
{
    cleanupSDL();
}

bool AudioPlayer::initialize()
{
    if (m_isInitialized) {
        qDebug() << "SDL_mixer already initialized.";
        return true; // Уже инициализирован
    }

    // 1. Инициализируем аудио-подсистему SDL
    // SDL_INIT_AUDIO достаточно для SDL_mixer
    if (SDL_Init(SDL_INIT_AUDIO) < 0) {
        QString errorMsg = QString("SDL could not initialize! SDL Error: %1").arg(SDL_GetError());
        qCritical() << errorMsg; // Используем qCritical для серьезных ошибок инициализации
        emit errorOccurred(errorMsg);
        return false;
    }
    qDebug() << "SDL Audio subsystem initialized.";

    // 2. Инициализируем SDL_mixer
    // Загружаем поддержку MP3 и OGG форматов (можно добавить и другие: MIX_INIT_FLAC, MIX_INIT_MOD)
    int flags = MIX_INIT_MP3 | MIX_INIT_OGG;
    int initted = Mix_Init(flags);
    if ((initted & flags) != flags) {
        QString errorMsg = QString("Mix_Init: Failed to init required ogg and mp3 support! SDL_mixer Error: %1").arg(Mix_GetError());
        qCritical() << errorMsg;
        emit errorOccurred(errorMsg);
        SDL_Quit(); // Откатываем SDL_Init
        return false;
    }
    qDebug() << "SDL_mixer MP3/OGG support initialized.";

    // 3. Открываем аудио устройство
    // Частота (44100 Гц), формат (16-бит знаковый), каналы (2=стерео), размер чанка (влияет на задержку)
    if (Mix_OpenAudio(44100, MIX_DEFAULT_FORMAT, 2, 2048) < 0) {
        QString errorMsg = QString("SDL_mixer could not open audio device! SDL_mixer Error: %1").arg(Mix_GetError());
        qCritical() << errorMsg;
        emit errorOccurred(errorMsg);
        Mix_Quit(); // Откатываем Mix_Init
        SDL_Quit(); // Откатываем SDL_Init
        return false;
    }
    qDebug() << "SDL_mixer audio device opened.";

    m_isInitialized = true;
    return true;
}

void AudioPlayer::start(const QString &filePath)
{
    if (!m_isInitialized) {
        qWarning() << "AudioPlayer not initialized. Call initialize() first.";
        emit errorOccurred("Player not initialized");
        return;
    }
    if (filePath.isEmpty()) {
        qWarning() << "AudioPlayer::start - Empty file path provided.";
        emit errorOccurred("Empty file path");
        return;
    }

    // 1. Остановить и освободить предыдущую музыку, если она была
    stop(); // stop() уже обновляет флаги и испускает сигнал, если нужно

    qDebug() << "Loading music file:" << filePath;
    m_currentFilePath = filePath;

    // Конвертируем QString в const char* для SDL_mixer
    // Используем toUtf8() для корректной обработки путей не-ASCII на Linux
    QByteArray pathBytes = filePath.toUtf8();
    const char *path = pathBytes.constData();

    // 2. Загрузить новый музыкальный файл
    m_music = Mix_LoadMUS(path);
    if (!m_music) {
        QString errorMsg = QString("Failed to load music '%1': %2").arg(filePath,Mix_GetError());
        qWarning() << errorMsg;
        emit errorOccurred(errorMsg);
        // Убедимся, что флаги в порядке, хотя stop() уже должен был их сбросить
        m_isPlaying = false;
        m_isPaused = false;
        return;
    }
    qDebug() << "Music loaded successfully.";

    Mix_SetMusicPosition(5.0);

    // 3. Начать воспроизведение (-1 для бесконечного цикла)
    if (Mix_PlayMusic(m_music, -1) == -1) {
        QString errorMsg = QString("Failed to play music: %1").arg(Mix_GetError());
        qWarning() << errorMsg;
        emit errorOccurred(errorMsg);
        Mix_FreeMusic(m_music); // Освобождаем память
        m_music = nullptr;
        m_isPlaying = false;
        m_isPaused = false;
        return;
    }

    qDebug() << "Music playback started.";
    m_isPlaying = true;
    m_isPaused = false; // По умолчанию не на паузе
    emit song_toggle_state_changed();
    emit song_status_changed();
}

void AudioPlayer::stop()
{
    if (!m_isInitialized) return; // Ничего не делаем, если не инициализировано

    bool wasPlaying = m_isPlaying; // Запоминаем, играл ли он до этого

    if (m_music) { // Проверяем, была ли музыка загружена
        qDebug() << "Stopping music playback...";
        Mix_HaltMusic(); // Останавливает воспроизведение немедленно
        Mix_FreeMusic(m_music); // Освобождает ресурсы, связанные с этой музыкой
        m_music = nullptr;
        qDebug() << "Music stopped and freed.";
    }

    // Обновляем флаги в любом случае, чтобы быть уверенными
    m_isPlaying = false;
    m_isPaused = false;
    m_currentFilePath.clear();
    // Испускаем сигнал только если состояние действительно изменилось
    if (wasPlaying) {
        emit song_status_changed();
        emit song_toggle_state_changed();
    }
}

void AudioPlayer::togglePause()
{
    if (!m_isPlaying || !m_isInitialized) {
        // Нельзя поставить на паузу или возобновить то, что не играет
        qWarning() << "Cannot toggle pause: Player is not playing.";
        return;
    }

    if (Mix_PausedMusic()) {
        // Если было на паузе - возобновляем
        qDebug() << "Resuming music...";
        Mix_ResumeMusic();
        m_isPaused = false;
    } else {
        // Если играло - ставим на паузу
        qDebug() << "Pausing music...";
        Mix_PauseMusic();
        m_isPaused = true;
    }
    qDebug()<<"song activated? "<<m_isPlaying;
    qDebug()<<"song playing?"<<m_isPaused;
    emit song_toggle_state_changed();

}

void AudioPlayer::setVolume(int percentage)
{
    if (!m_isInitialized) {
        qWarning() << "Cannot set volume: Player not initialized.";
        return;
    }

    percentage = qBound(0, percentage, 100); // Ограничиваем 0-100

    // Конвертируем процент в диапазон SDL_mixer (0 - MIX_MAX_VOLUME, обычно 128)
    // Используем деление на 100.0 для точности с плавающей точкой
    int sdlVolume = qRound(percentage * MIX_MAX_VOLUME / 100.0);

    qDebug() << "Setting music volume to" << sdlVolume << "(" << percentage << "%)";
    Mix_VolumeMusic(sdlVolume); // Устанавливает громкость для канала музыки
}

bool AudioPlayer::isPlaying() const
{
    // Проверяем наш флаг. Можно добавить проверку Mix_PlayingMusic() для надежности,
    // но флаг должен быть синхронизирован.
    return m_isPlaying;
}

bool AudioPlayer::isPaused() const
{
    // Актуально, только если m_isPlaying == true
    return m_isPlaying && m_isPaused;
}

bool AudioPlayer::isInitialized() const
{
    return m_isInitialized;
}


// --- Приватные методы ---

void AudioPlayer::cleanupSDL()
{
    if (!m_isInitialized) {
        return; // Нечего очищать
    }
    qDebug() << "Cleaning up SDL_mixer and SDL Audio...";
    stop(); // Убедимся, что музыка остановлена и освобождена

    Mix_CloseAudio(); // Закрываем аудио устройство
    Mix_Quit();       // Завершаем работу с подсистемами Mix_Init
    SDL_Quit();       // Завершаем работу с подсистемами SDL_Init

    m_isInitialized = false;
    qDebug() << "SDL Cleanup complete.";
}
