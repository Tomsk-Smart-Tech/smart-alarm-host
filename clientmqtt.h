
// #ifndef CLIENTMQTT_H
// #define CLIENTMQTT_H

// #include <QObject>
// #include <QString>
// #include <QDebug>
// #include <thread>
// #include <QDateTime>
// #include <QJsonDocument>
// #include <QJsonObject>
// #include <mqtt/async_client.h>
// #include <QFile>
// #include <QJsonArray>
// #include <QJsonDocument>
// #include <QJsonObject>
// #include <QJsonValue>

// class ClientMqtt : public QObject
// {
//     Q_OBJECT
//     Q_PROPERTY(QString message READ message NOTIFY messageReceived)
//     Q_PROPERTY(QString connectionStatus READ connectionStatus NOTIFY connectionStatusChanged)

// public:
//     explicit ClientMqtt(QObject *parent = nullptr);
//     ~ClientMqtt();
//     QString message() const;
//     QString connectionStatus() const { return m_connectionStatus; }

//     void connectToBroker(const QString &serverAddress, const QString &clientId, const QString &topic);

// signals:
//     void messageReceived();
//     void connectionStatusChanged();

// private:
//     void onMessageReceived(const std::string &topic, const std::string &payload);
//     void setMessage(const QString &message);
//     void setConnectionStatus(const QString &status);

//     mqtt::async_client *client;
//     QString m_message;
//     QString m_connectionStatus;
// };

// #endif // CLIENTMQTT_H
