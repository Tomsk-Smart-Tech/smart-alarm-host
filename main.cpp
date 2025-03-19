#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQuickControls2/QQuickStyle>
#include <QQmlContext>
#include <QtQml>

#include "weather.h"
#include "mqttclient.h"
#include "linuxterminal.h"
#include "dht22sensor.h"
#include "spotify.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    qmlRegisterSingletonType(QUrl("file:../../GlobalTime.qml"), "GlobalTime", 1, 0, "GlobalTime");

    QDir currentDir = QDir::currentPath();
    currentDir.cdUp();
    currentDir.cdUp();
    QString mainqml = "file:///"+currentDir.filePath("main.qml");
    const QUrl url(mainqml);

    // QtWebEngineQuick::initialize();
    QQuickStyle::setStyle("Basic");


    Weather weather;
    engine.rootContext()->setContextProperty("weatherr", &weather);
    MqttClient client;
    engine.rootContext()->setContextProperty("mqttclient",&client);
    LinuxTerminal linuxterminal;
    engine.rootContext()->setContextProperty("terminal",&linuxterminal);
    Dht22sensor dht22;
    engine.rootContext()->setContextProperty("dht22",&dht22);
    Spotify spotify;
    engine.rootContext()->setContextProperty("spotify",&spotify);

    engine.rootContext()->setContextProperty("jsonFilePath", QUrl::fromLocalFile(currentDir.filePath("russian_cities.json")));
    engine.rootContext()->setContextProperty("icons_path", QUrl::fromLocalFile(currentDir.filePath("weather_iconkit")));
    engine.rootContext()->setContextProperty("songsPath","/home/nikita/Downloads");
    //absolute ways
    //const QUrl url(QStringLiteral("/home/nikita/fromgit/smart-alarm-host/main.qml"));
    //const QUrl url(QStringLiteral("qrc:/raspberry_smart_alarm/main.qml"));
    //const QUrl url(QStringLiteral("file:///C:/Users/kiril/Documents/raspberry_smart_alarm/main.qml"));

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
