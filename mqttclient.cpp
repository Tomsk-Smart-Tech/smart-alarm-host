#include "mqttclient.h"


boost::asio::awaitable<bool> subscribe(auto& client, MqttClient* parent) {
    // Список топиков для подписки
    std::vector<boost::mqtt5::subscribe_topic> sub_topics = {
        { "mqtt/test", { boost::mqtt5::qos_e::exactly_once,
                            boost::mqtt5::no_local_e::no,
                            boost::mqtt5::retain_as_published_e::retain,
                            boost::mqtt5::retain_handling_e::send } },
        { "mqtt/events", { boost::mqtt5::qos_e::at_least_once,
                            boost::mqtt5::no_local_e::no,
                            boost::mqtt5::retain_as_published_e::retain,
                            boost::mqtt5::retain_handling_e::send } },
        { "mqtt/alarms", { boost::mqtt5::qos_e::at_most_once,
                            boost::mqtt5::no_local_e::no,
                            boost::mqtt5::retain_as_published_e::retain,
                            boost::mqtt5::retain_handling_e::send } }
    };
    // Subscribe to a single Topic.
    auto&& [ec, sub_codes, sub_props] = co_await client.async_subscribe(
        sub_topics, boost::mqtt5::subscribe_props {}, use_nothrow_awaitable
        );
    // Note: you can subscribe to multiple Topics in one mqtt_client::async_subscribe call.

    // An error can occur as a result of:
    //  a) wrong subscribe parameters
    //  b) mqtt_client::cancel is called while the Client is in the process of subscribing
    if (ec)
    {
        std::cout << "Subscribe error occurred: " << ec.message() << std::endl;
        QMetaObject::invokeMethod(parent, "setConnectionStatus", Qt::QueuedConnection, Q_ARG(int, 0));
    }
    else
    {
        std::cout << "Result of subscribe request: " << sub_codes[0].message() << std::endl;
        QMetaObject::invokeMethod(parent, "setConnectionStatus", Qt::QueuedConnection, Q_ARG(int, 1));
    }

    co_return !ec && !sub_codes[0]; // True if the subscription was successfully established.
}

boost::asio::awaitable<void> subscribe_and_receive(const config& cfg, auto& client,MqttClient* parent)
{
    // Configure the Client.
    // It is mandatory to call brokers() and async_run() to configure the Brokers to connect to and start the Client.
    client.brokers(cfg.brokers, cfg.port) // Broker that we want to connect to.
        .credentials(cfg.client_id,cfg.username, cfg.password) // Set the Client Identifier. (optional)
        .async_run(boost::asio::detached); // Start the client.

    // Before attempting to receive an Application Message from the Topic we just subscribed to,
    // it is advisable to verify that the subscription succeeded.
    // It is not recommended to call mqtt_client::async_receive if you do not have any
    // subscription established as the corresponding handler will never be invoked.
    if (!(co_await subscribe(client,parent)))
    {
        co_return;
    }


    for (;;) {
        // Receive an Appplication Message from the subscribed Topic(s).
        auto&& [ec, topic, payload, publish_props] = co_await client.async_receive(use_nothrow_awaitable);
        if(topic=="mqtt/events")
        {
            QVariantList newEvents;
            QString message = QString::fromStdString(payload);
            //setMessage(message);
            QJsonDocument jsonDoc = QJsonDocument::fromJson(message.toUtf8());
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

                newEvents.append(map);
                qDebug()<<obj["title"].toString();
            }
            QMetaObject::invokeMethod(parent, "setEvents", Qt::QueuedConnection, Q_ARG(QVariantList, newEvents));

            std::cout << "Received message from the Broker" << std::endl;
            std::cout << "\t topic: " << topic << std::endl;
            std::cout << "\t payload: " << payload << std::endl;
        }
        else if(topic=="mqtt/alarms")
        {
            QVariantList newAlarms;
            QString message = QString::fromStdString(payload);
            //setMessage(message);
            QJsonDocument jsonDoc = QJsonDocument::fromJson(message.toUtf8());
            QJsonArray jsonArray = jsonDoc.array();
            for (const QJsonValue &value : jsonArray)
            {
                QVariantMap map;
                QJsonObject obj = value.toObject();

                map["id"] = obj["id"].toInt();
                map["time"]=obj["time"].toString();
                map["isHaptic"]=obj["isHaptic"].toString();
                map["label"]=obj["label"].toString();
                map["musicUri"]=obj["musicUri"].toString();
                map["isEnabled"]=obj["isEnabled"].toBool();

                newAlarms.append(map);
                qDebug()<<obj["id"]<<"  "<<obj["time"].toString();
            }
            QMetaObject::invokeMethod(parent, "setAlarms", Qt::QueuedConnection, Q_ARG(QVariantList, newAlarms));

            std::cout << "Received message from the Broker" << std::endl;
            std::cout << "\t topic: " << topic << std::endl;
            std::cout << "\t payload: " << payload << std::endl;
        }
        if (ec == boost::mqtt5::client::error::session_expired) {
            // The Client has reconnected, and the prior session has expired.
            // As a result, any previous subscriptions have been lost and must be reinstated.
            if (co_await subscribe(client,parent))
                continue;
            else
            {
                QMetaObject::invokeMethod(parent, "setConnectionStatus", Qt::QueuedConnection, Q_ARG(int,0));
                break;
            }

        }
        else if (ec)
        {
            QMetaObject::invokeMethod(parent, "setConnectionStatus", Qt::QueuedConnection, Q_ARG(int,0));
            break;
        }


    }

    co_return;
}


MqttClient::MqttClient(QObject *parent):
    QObject(parent),ioc(),context(boost::asio::ssl::context::tls_client),client(ioc, std::move(context), boost::mqtt5::logger(boost::mqtt5::log_level::info))
{

    co_spawn(
        ioc,
        subscribe_and_receive(cfg, client,this),
        [](std::exception_ptr e) {
            if (e)
            {
                std::rethrow_exception(e);

            }
        }
        );


    //ioc.run();
    iocThread = std::thread([this]() { ioc.run(); });
}

MqttClient::~MqttClient()
{
    client.cancel();
    ioc.stop();
    if (iocThread.joinable())
        iocThread.join();
}


void MqttClient::setConnectionStatus(const int status)
{

    m_connectionStatus = status;
    emit connectionStatusChanged();
}


void MqttClient::setEvents(const QVariantList &newEvents) {
    m_events.clear();
    emit eventschanged();
    m_events = newEvents;
    emit eventschanged();
}

void MqttClient::setAlarms(const QVariantList &newAlarms) {
    m_alarms.clear();
    emit alarmschanged();
    m_alarms = newAlarms;
    emit alarmschanged();
}
