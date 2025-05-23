#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQuickControls2/QQuickStyle>
#include <QQmlContext>
#include <QtQml>

#include "user.h"
#include "weather.h"
#include "mqttclient.h"
#include "linuxterminal.h"
#include "audioplayer.h"
#include "sensors.h"
#include "spotify.h"

int main(int argc, char *argv[])
{
    qputenv("QML_XHR_ALLOW_FILE_READ", "1");

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    // qDebug() << "--- Resource Listing Start ---";
    // QDirIterator it(":", QDirIterator::Subdirectories); // Итератор по qrc:/
    // while (it.hasNext()) {
    //     qDebug() << it.next(); // Выводим найденные пути ресурсов
    // }
    // qDebug() << "--- Resource Listing End ---";

    //qmlRegisterSingletonType(QUrl("file:../../qml/GlobalTime.qml"), "GlobalTime", 1, 0, "GlobalTime");
    qmlRegisterSingletonType(QUrl("qrc:/smart-alarm-host/qml/GlobalTime.qml"), "GlobalTime", 1, 0, "GlobalTime");
    qmlRegisterSingletonType(QUrl("qrc:/smart-alarm-host/qml/Themes.qml"), "Themes", 1, 0, "Themes");
    QDir currentDir = QDir::currentPath();
    currentDir.cdUp();
    currentDir.cdUp();
    QString mainqml = "file:///"+currentDir.filePath("qml/main.qml");
    const QUrl url(mainqml);

    // QtWebEngineQuick::initialize();
    QQuickStyle::setStyle("Basic");

    User user;
    engine.rootContext()->setContextProperty("user",&user);
    Weather weather;
    engine.rootContext()->setContextProperty("weatherr", &weather);
    MqttClient client;
    engine.rootContext()->setContextProperty("mqttclient",&client);
    LinuxTerminal linuxterminal;
    engine.rootContext()->setContextProperty("terminal",&linuxterminal);
    AudioPlayer player;
    player.initialize();
    player.setVolume(user.get_volume());
    engine.rootContext()->setContextProperty("audioplayer",&player);
    Sensors sensors;
    engine.rootContext()->setContextProperty("sensorss",&sensors);
    Spotify spotify;
    engine.rootContext()->setContextProperty("spotify",&spotify);
    QObject::connect(&client, &MqttClient::spotifycode_received,
            &spotify, &Spotify::handleSpotifyCode);

    engine.rootContext()->setContextProperty("jsonFilePath", QUrl::fromLocalFile(currentDir.filePath("russian_cities.json")));
    engine.rootContext()->setContextProperty("icons_path", QUrl::fromLocalFile(currentDir.filePath("weather_iconkit")));
    engine.rootContext()->setContextProperty("songsPath",currentDir.filePath("user_storage/ringtones"));
    engine.rootContext()->setContextProperty("photosPath",currentDir.filePath("user_storage/wallpapers"));

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);


    return app.exec();
}
