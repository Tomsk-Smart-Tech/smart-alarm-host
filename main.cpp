#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQuickControls2/QQuickStyle>
#include <QQmlContext>
#include "weather.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    Weather weather;
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("weatherr", &weather);
    QDir currentDir = QDir::currentPath();
    currentDir.cdUp();
    currentDir.cdUp();
    QString mainqml = currentDir.filePath("main.qml");
    const QUrl url(mainqml);

    // const QUrl url(QStringLiteral("/home/nikita/fromgit/smart-alarm-host/main.qml"));
    //const QUrl url(QStringLiteral("qrc:/raspberry_smart_alarm/main.qml"));

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
