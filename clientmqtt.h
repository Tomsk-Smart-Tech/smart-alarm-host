
#ifndef CLIENTMQTT_H
#define CLIENTMQTT_H

#include <QObject>
#include <QString>
#include <QDebug>
#include <thread>
#include <QDateTime>
#include <QJsonDocument>
#include <QJsonObject>
#include <mqtt/async_client.h>
#include <QFile>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonValue>
#include <QVariant>
#include <QVariantList>
#include <QVariantMap>

class ClientMqtt : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString message READ message NOTIFY messageReceived)
    Q_PROPERTY(int connectionStatus READ connectionStatus NOTIFY connectionStatusChanged)
    Q_PROPERTY(QVariantList events READ get_events NOTIFY eventschanged)

public:
    explicit ClientMqtt(QObject *parent = nullptr);
    ~ClientMqtt();
    QString message() const;
    int connectionStatus() const { return m_connectionStatus; }
    Q_INVOKABLE QVariantList get_events() const {return m_events;}
    void connectToBroker(const QString &serverAddress, const QString &clientId, const QString &topic);

signals:
    void messageReceived();
    void connectionStatusChanged();
    void eventschanged();

private slots:


private:
    void onMessageReceived(const std::string &topic, const std::string &payload);
    void setMessage(const QString &message);
    void setConnectionStatus(int status);

    mqtt::async_client *client;
    QString m_message;
    int m_connectionStatus;
    QVariantList m_events;

};

#endif // CLIENTMQTT_H
