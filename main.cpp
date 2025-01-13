#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQuickControls2/QQuickStyle>
#include <QQmlContext>
#include "weather.h"
#include "clientmqtt.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    QDir currentDir = QDir::currentPath();
    currentDir.cdUp();
    currentDir.cdUp();
    QString mainqml = "file:///"+currentDir.filePath("main.qml");
    const QUrl url(mainqml);

    Weather weather;
    engine.rootContext()->setContextProperty("weatherr", &weather);
    ClientMqtt client;
    engine.rootContext()->setContextProperty("mqttclient",&client);
    engine.rootContext()->setContextProperty("jsonFilePath", QUrl::fromLocalFile(currentDir.filePath("russian_cities.json")));
    engine.rootContext()->setContextProperty("icons_path", QUrl::fromLocalFile(currentDir.filePath("weather_iconkit")));
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
