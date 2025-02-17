

#include "clientmqtt.h"

ClientMqtt::ClientMqtt(QObject *parent)
    : QObject(parent), client(nullptr), m_connectionStatus(0)
{
    const QString serverAddress = "ssl://6a41760a26ec43f2b0e532601ce780e1.s1.eu.hivemq.cloud:8883";
    const QString clientId = "paho_cpp_async_consume";
    const QString topic = "my/test/topic";

    connectToBroker(serverAddress, clientId, topic);
}

ClientMqtt::~ClientMqtt()
{
    if (client) {
        client->stop_consuming();
        client->disconnect()->wait();
        delete client;
    }
}

QString ClientMqtt::message() const
{
    return m_message;
}

void ClientMqtt::connectToBroker(const QString &serverAddress, const QString &clientId, const QString &topic)
{
    std::string server = serverAddress.toStdString();
    std::string id = clientId.toStdString();
    std::string topicStr = topic.toStdString();

    const std::string username ="nikita";
    const std::string password ="Flowers123";

    client = new mqtt::async_client(server, id);
    QString path ="/home/nikita/qtquickmqtt/hivemq_cert.pem";
    QByteArray certData;
    QFile file(path);
    if (file.open(QIODevice::ReadOnly))
    {
        certData = file.readAll();  // Читаем содержимое файла
    }
    std::string certDataStdStr = certData.toStdString();

    auto sslOptions = mqtt::ssl_options_builder()
                          .trust_store("") // Путь к скачанному сертификату
                          .finalize();

    auto connOpts = mqtt::connect_options_builder().clean_session(false).user_name(username).password(password).ssl(sslOptions).finalize();

    try {
        client->start_consuming();
        client->connect(connOpts)->wait();
        client->subscribe(topicStr, 1)->wait();

        setConnectionStatus(1);

        std::thread([this]() {
            while (true) {
                auto msg = client->consume_message();
                if (!msg) break;
                onMessageReceived(msg->get_topic(), msg->to_string());
            }
        }).detach();
    } catch (const mqtt::exception &exc) {
        setConnectionStatus(0);
        qWarning() << "MQTT Error:" << exc.what();
    }
}

void ClientMqtt::onMessageReceived(const std::string &topic, const std::string &payload)
{
    m_events.clear();
    QString message = QString::fromStdString(payload);
    setMessage(message);
    QJsonDocument jsonDoc = QJsonDocument::fromJson(message.toUtf8());

    if (jsonDoc.isArray())
    {
        QJsonArray jsonArray = jsonDoc.array();

        for (const QJsonValue &value : jsonArray)
        {
            QVariantMap map;
            QJsonObject obj = value.toObject();

            qint64 startTime = obj["startTime"].toVariant().toLongLong();
            qint64 endTime = obj["endTime"].toVariant().toLongLong();
            QDateTime startDate = QDateTime::fromSecsSinceEpoch(startTime/1000);
            QDateTime endDate = QDateTime::fromSecsSinceEpoch(endTime/1000);
            // Извлечение года, месяца и дня
            int startYear = startDate.date().year();
            int startMonth = startDate.date().month();
            int startDay = startDate.date().day();
            int endYear = endDate.date().year();
            int endMonth = endDate.date().month();
            int endDay = endDate.date().day();
            QString start=QString::number(startDay)+"."+QString::number(startMonth)+"."+QString::number(startYear);
            QString end=QString::number(endDay)+"."+QString::number(endMonth)+"."+QString::number(endYear);

            map["title"] = obj["title"].toString();
            map["starttime"]=start;
            map["endtime"]=end;
            map["organizer"]=obj["organizer"].toString();
            map["id"]=obj["id"].toInt();
            map["allday"]=obj["allDay"].toBool();
            map["calendarname"]=obj["calendarDisplayName"].toString();
            map["desc"]=obj["description"].toString();
            map["location"]=obj["location"].toString();

            m_events.append(map);
            qDebug()<<obj["title"].toString();
        }
        emit eventschanged();
        //QString result="title: " + title+'\n'+"startTime: "+start+'\n'+"endTime: "+end;
        // Вывод статуса в сообщение
        //setMessage(result);
    }
    else
    {
        qWarning() << "Invalid JSON received:" << message;
        setMessage("Invalid JSON: " + message);
    }
}

void ClientMqtt::setMessage(const QString &message)
{
    if (m_message == message)
        return;
    m_message = message;
    emit messageReceived();
}

void ClientMqtt::setConnectionStatus(const int status)
{
    if (m_connectionStatus == status)
        return;
    m_connectionStatus = status;
    emit connectionStatusChanged();
}
