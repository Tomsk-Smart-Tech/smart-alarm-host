#ifndef AUDIOPLAYER_H
#define AUDIOPLAYER_H

#include <QObject>
#include <QString>

// Подключаем заголовки SDL
#include <SDL2/SDL.h>
#include <SDL2/SDL_mixer.h>



class AudioPlayer : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool is_paused READ isPaused NOTIFY song_toggle_state_changed )
    Q_PROPERTY(bool is_song_active READ isPlaying NOTIFY song_status_changed )

public:
    explicit AudioPlayer(QObject *parent = nullptr);
    ~AudioPlayer();

    // Инициализация (вызывать один раз перед использованием)
    // Возвращает true в случае успеха, false при ошибке.
    Q_INVOKABLE bool initialize();

    // Основные команды управления
    Q_INVOKABLE void start(const QString &filePath); // Q_INVOKABLE если нужно вызывать из QML
    Q_INVOKABLE void stop();
    Q_INVOKABLE void togglePause();
    Q_INVOKABLE void setVolume(int percentage); // 0-100

    // Методы для получения состояния (опционально)
    Q_INVOKABLE bool isPlaying() const;
    Q_INVOKABLE bool isPaused() const;
    Q_INVOKABLE bool isInitialized() const; // Проверка инициализации

signals:
    // Сигналы остались те же
    void errorOccurred(const QString &errorString);
    void song_toggle_state_changed();
    void song_status_changed();

private:
    // Внутренние функции не нужны как слоты для QProcess
    void cleanupSDL(); // Функция для очистки ресурсов SDL

    // Указатель на загруженную музыку
    Mix_Music *m_music = nullptr;

    // Флаги состояния
    bool m_isInitialized = false; // Флаг успешной инициализации
    bool m_isPlaying = false;     // В данный момент активно воспроизведение (может быть на паузе)
    bool m_isPaused = false;      // В данный момент на паузе (актуально только если m_isPlaying == true)

    // Сохраняем путь для информации или перезапуска (опционально)
    QString m_currentFilePath;
};

#endif // AUDIOPLAYER_H


