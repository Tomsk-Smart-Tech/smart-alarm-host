#include "mqttclient.h"
#include <QTimeZone>
#include "general_func.h"

QJsonArray alarms_to_json(QVariantList &alarms)
{
    QJsonArray jsonArray;

    for (const QVariant &item : alarms)
    {
        QVariantMap map = item.toMap();
        QJsonObject obj;

        obj["id"] = map["id"].toInt();
        obj["time"] = map["time"].toString();
        obj["isHaptic"] = map["isHaptic"].toString();
        obj["label"] = map["label"].toString();
        obj["musicUri"] = map["musicUri"].toString();
        obj["isEnabled"] = map["isEnabled"].toBool();
        obj["delay"]=map["delay"].toString();
        obj["delete_after"]=map["delete_after"].toBool();
        obj["song"]=map["song"].toString();
        QVariantList repeatDaysList = map["repeatDays"].toList();
        QJsonArray repeatDaysJson;
        for (const QVariant &day : repeatDaysList)
        {
            repeatDaysJson.append(day.toBool());
        }
        obj["repeatDays"] = repeatDaysJson;

        jsonArray.append(obj);
    }

    return jsonArray;
}




QJsonArray events_to_json(QVariantList &events)
{
    QJsonArray jsonArray;

    for (const QVariant &item : events)
    {
        QVariantMap map = item.toMap();
        QJsonObject obj;
        obj["endTime"]=map["endTime"].toLongLong();
        obj["startTime"]=map["startTime"].toLongLong();
        obj["starttime_timestamp"]=map["starttime_timestamp"].toLongLong();
        obj["title"]=map["title"].toString();
        obj["starttime"]=map["starttime"].toString();
        obj["endtime"]=map["endtime"].toString();
        obj["id"]=map["id"].toInt();
        obj["allday"]=map["allDay"].toBool();
        obj["calendarname"]=map["calendarname"].toString();
        obj["desc"]=map["desc"].toString();
        obj["location"]=map["location"].toString();
        obj["rrule"]=map["rrule"].toString();
        jsonArray.append(obj);
    }

    return jsonArray;
}


QVariantList read_json_events(QJsonArray jsonArray)
{
    QVariantList newEvents;

    for (const QJsonValue &value : jsonArray)
    {
        QVariantMap map;
        QJsonObject obj = value.toObject();

        qint64 startTime = obj["startTime"].toVariant().toLongLong();
        qint64 endTime = obj["endTime"].toVariant().toLongLong();
        QDateTime startDate = QDateTime::fromMSecsSinceEpoch(startTime);
        QDateTime endDate = QDateTime::fromMSecsSinceEpoch(endTime);
        // // Извлечение года, месяца и дня
        // int startYear = startDate.date().year();
        // int startMonth = startDate.date().month();
        // int startDay = startDate.date().day();
        // int endYear = endDate.date().year();
        // int endMonth = endDate.date().month();
        // int endDay = endDate.date().day();
        // QString start=QString::number(startDay)+"."+QString::number(startMonth)+"."+QString::number(startYear);
        // QString end=QString::number(endDay)+"."+QString::number(endMonth)+"."+QString::number(endYear);

        QString start = startDate.toString("dd.MM.yyyy"); // dd - день с нулем, MM - месяц с нулем, yyyy - год
        QString end = endDate.toString("dd.MM.yyyy");

        map["starttime_timestamp"]=obj["startTime"].toVariant().toLongLong();
        map["title"] = obj["title"].toString();
        map["starttime"]=start;
        map["endtime"]=end;
        map["endTime"]=endTime;
        map["id"]=obj["id"].toInt();
        map["allday"]=obj["allDay"].toBool();
        map["calendarname"]=obj["calendarDisplayName"].toString();
        map["desc"]=obj["description"].toString();
        map["location"]=obj["location"].toString();
        map["rrule"]=obj["rrule"].toString();

        newEvents.append(map);
    }
    return newEvents;
}


QVariantList read_json_alarms(QJsonArray jsonArray)
{
    QString defaultsong=read_user_json("current_song");
    QString defaultdelay=read_user_json("standart_delay");
    QVariantList newAlarms;
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

        if(obj.contains("song"))
        {
            map["song"]=obj["song"].toString();
            map["delay"] = obj["delay"].toString();
            map["delete_after"] = obj["delete_after"].toBool();
        }
        else
        {
            map["song"]=defaultsong;
            map["delay"] = defaultdelay;
            map["delete_after"] = false;
        }

        QJsonArray repeatArray = obj["repeatDays"].toArray();
        QVariantList repeatDays;
        for (const QJsonValue &repeatVal : repeatArray)
        {
            //qDebug()<<"repeatval="<<repeatVal.toBool();
            repeatDays.append(repeatVal.toBool());
        }
        map["repeatDays"] = repeatDays;

        newAlarms.append(map);
    }
    return newAlarms;
}



void save_data(QJsonDocument json,QString data_type)
{
    QDir currentDir = QDir::currentPath();
    currentDir.cdUp();
    currentDir.cdUp();
    QString userfile;
    if(data_type=="events")
        userfile = currentDir.filePath("events.json");
    else if(data_type=="alarms")
        userfile = currentDir.filePath("alarms.json");
    QFile file(userfile);
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text | QIODevice::Truncate))
    {
        qDebug() << "Failed to open file for read " << file.errorString();
    }
    file.write(json.toJson());
    file.close();
}

std::vector<QVariantList> setup_data()
{
    std::vector<QVariantList> alldata;
    QDir currentDir = QDir::currentPath();
    currentDir.cdUp();
    currentDir.cdUp();


    QString user_eventsfile_path= currentDir.filePath("events.json");
    QFile eventsfile(user_eventsfile_path);
    if (!eventsfile.open(QIODevice::ReadWrite | QIODevice::Text))
    {
        qDebug() << "Failed to open file for read and write:" << eventsfile.errorString();
    }
    QByteArray fileData1 = eventsfile.readAll();
    eventsfile.close();
    QJsonDocument jsonDoc1(QJsonDocument::fromJson(fileData1));
    QJsonArray jsonArray1 = jsonDoc1.array();
    alldata.push_back(read_json_events(jsonArray1));



    QString user_alarmsfile_path= currentDir.filePath("alarms.json");
    QFile alarmsfile(user_alarmsfile_path);
    if (!alarmsfile.open(QIODevice::ReadWrite | QIODevice::Text))
    {
        qDebug() << "Failed to open file for read and write:" << alarmsfile.errorString();
    }
    QByteArray fileData2 = alarmsfile.readAll();
    alarmsfile.close();
    QJsonDocument jsonDoc2(QJsonDocument::fromJson(fileData2));
    QJsonArray jsonArray2 = jsonDoc2.array();
    alldata.push_back(read_json_alarms(jsonArray2));

    return alldata;

}



boost::asio::awaitable<bool> subscribe(auto& client, MqttClient* parent) {
    // Список топиков для подписки
    std::vector<boost::mqtt5::subscribe_topic> sub_topics = {
        { "mqtt/test", { boost::mqtt5::qos_e::exactly_once,
                            boost::mqtt5::no_local_e::yes,
                            boost::mqtt5::retain_as_published_e::retain,
                            boost::mqtt5::retain_handling_e::send } },
        { "mqtt/events", { boost::mqtt5::qos_e::at_least_once,
                            boost::mqtt5::no_local_e::yes,
                            boost::mqtt5::retain_as_published_e::retain,
                            boost::mqtt5::retain_handling_e::send } },
        { "mqtt/alarms", { boost::mqtt5::qos_e::at_most_once,
                            boost::mqtt5::no_local_e::yes,
                            boost::mqtt5::retain_as_published_e::retain,
                            boost::mqtt5::retain_handling_e::send } },
        { "mqtt/sensors", { boost::mqtt5::qos_e::at_most_once,
                         boost::mqtt5::no_local_e::yes,
                         boost::mqtt5::retain_as_published_e::retain,
                         boost::mqtt5::retain_handling_e::send } },
        { "mqtt/spotifyAuth", { boost::mqtt5::qos_e::at_most_once,
                          boost::mqtt5::no_local_e::yes,
                          boost::mqtt5::retain_as_published_e::retain,
                          boost::mqtt5::retain_handling_e::send } },
        { "mqtt/check", { boost::mqtt5::qos_e::at_most_once,
                              boost::mqtt5::no_local_e::yes,
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

            QJsonDocument jsonDoc = QJsonDocument::fromJson(message.toUtf8());
            //save_data(jsonDoc,"events");

            QJsonArray jsonArray = jsonDoc.array();

            newEvents=read_json_events(jsonArray);

            QJsonDocument jsonDoc2(jsonArray);
            save_data(jsonDoc2,"events");

            QMetaObject::invokeMethod(parent, "setEvents", Qt::QueuedConnection, Q_ARG(QVariantList, newEvents));

            std::cout << "Received message from the Broker" << std::endl;
            std::cout << "\t topic: " << topic << std::endl;
            std::cout << "\t payload: " << payload << std::endl;
        }
        else if(topic=="mqtt/alarms")
        {
            QVariantList newAlarms;
            QString message = QString::fromStdString(payload);

            QJsonDocument jsonDoc = QJsonDocument::fromJson(message.toUtf8());
            save_data(jsonDoc,"alarms");

            QJsonArray jsonArray = jsonDoc.array();

            newAlarms=read_json_alarms(jsonArray);

            QMetaObject::invokeMethod(parent, "setAlarms", Qt::QueuedConnection, Q_ARG(QVariantList, newAlarms));

            std::cout << "Received message from the Broker" << std::endl;
            std::cout << "\t topic: " << topic << std::endl;
            std::cout << "\t payload: " << payload << std::endl;
        }
        else if(topic=="mqtt/spotifyAuth")
        {
            QString data = QString::fromStdString(payload);
            QMetaObject::invokeMethod(parent, "spotifycode_received",
                                      Qt::QueuedConnection,
                                      Q_ARG(QString, data));
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
    std::vector<QVariantList> all_data=setup_data();

    setEvents(all_data[0]);
    setAlarms(all_data[1]);
    alarm_delay=read_user_json("standart_delay").toInt();

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

Q_INVOKABLE void MqttClient::alarm_start(int id)
{
    for (int i = 0; i < m_alarms.size(); ++i)
    {
        QVariantMap alarm = m_alarms[i].toMap();
        if (alarm["id"].toInt() == id)
        {
            if(alarm["delete_after"].toBool()==true)
            {
                m_alarms.removeAt(i);
            }
            else
            {
                if(alarm["repeatDays"].toList().contains(true))
                {
                    alarm["isEnabled"]=true;
                }
                else
                {
                    alarm["isEnabled"]=false;
                }
                m_alarms[i] = alarm;
            }
            break;
        }
    }

    emit alarmschanged();
    QJsonArray jsonArray=alarms_to_json(m_alarms);
    QJsonDocument jsonDoc(jsonArray);
    save_data(jsonDoc,"alarms");
    publish_alarms();
}




Q_INVOKABLE QString MqttClient::find_first_alarm(int cur_day,const QVariant cur_time)
{
    int id=-1; //id будильника с минимальным временем
    int min_min=10000;
    int min_hours=1000;
    int min_res=100000000;
    QTime cur_qtime = cur_time.toDateTime().time(); //время из qml
    for(int i=0;i<m_alarms.size();i++)
    {
        QVariantMap map = m_alarms[i].toMap();
        QString time=map["time"].toString();
        QTime time_formatted=QTime::fromString(time,"hh:mm");
        if (map["isEnabled"].toBool()==true)
        {
            QVariantList selectedDays=map["repeatDays"].toList();
            if(selectedDays.contains(true)) //если будильник с повторениями
            {
                int whatday=-1;
                if(selectedDays[cur_day]==true && time_formatted>cur_qtime) //если день срабатывания-сегодня и время еще не наступило
                {
                    //qDebug()<<"min_res до "<<min_res;
                    int res=time_formatted.hour()*60+time_formatted.minute();

                    if(res<min_res)
                    {
                        //qDebug()<<"res="<<res;
                        id=map["id"].toInt();
                        min_hours=time_formatted.hour();
                        min_min=time_formatted.minute();
                        min_res=res;
                    }
                }
                else if(selectedDays[cur_day]==true && time_formatted<cur_qtime) //если день срабатывания-сегодня и время уже прошло
                {
                    int res=(time_formatted.hour()+24*7)*60+time_formatted.minute();
                    if(res<min_res)
                    {
                        id=map["id"].toInt();
                        min_hours=(time_formatted.hour()+24*7);
                        min_min=time_formatted.minute();
                        min_res=res;
                    }
                }
                for(int i=cur_day;i<selectedDays.size();i++) // ищем ближайщий день справа
                {
                    if(selectedDays[i]==true)
                    {
                        whatday=i;
                        break;
                    }
                }
                if(whatday>cur_day) //
                {
                    int additional=(whatday-cur_day)*24;
                    int res=(time_formatted.hour()+additional)*60+time_formatted.minute();
                    if(res<min_res)
                    {
                        id=map["id"].toInt();
                        min_hours=(time_formatted.hour()+additional);
                        min_min=time_formatted.minute();
                        min_res=res;
                    }
                }
                for(int i=cur_day;i>=0;i--)// ищем ближайщий день слева
                {
                    if(selectedDays[i]==true)
                    {
                        whatday=i;
                    }
                }
                if(whatday!=-1 && whatday<cur_day)
                {
                    // qDebug()<<"и слева я тоже зашел";
                    // qDebug()<<"whatday="<<whatday;
                    // qDebug()<<"cur_day="<<cur_day;
                    int additional=(selectedDays.size()-cur_day+whatday)*24;
                    //qDebug()<<"add="<<additional;
                    int res=(time_formatted.hour()+additional)*60+time_formatted.minute();
                    //qDebug()<<res<<"  id:"<<map["id"].toInt();
                    //qDebug()<<"min_res до изменения="<<min_res;
                    if(res<min_res)
                    {
                        //qDebug()<<"обновил значение до"<<res;
                        id=map["id"].toInt();
                        min_hours=(time_formatted.hour()+additional);
                        min_min=time_formatted.minute();
                        min_res=res;
                    }
                }

            }
            else // если будильник без повторений
            {
                int res=time_formatted.hour()*60+time_formatted.minute();
                //qDebug()<<"без повторений res="<<res;
                if(res<min_res)
                {

                    id=map["id"].toInt();
                    min_hours=time_formatted.hour();
                    min_min=time_formatted.minute();
                    min_res=res;
                    //qDebug()<<"обновил значение без повторений до "<<min_res;
                }
            }
        }
    }

    if(id==-1)
    {
        QString res="";
        return res;
    }
    //qDebug()<<QString::number(min_hours)<<":"<<QString::number(min_min)<<"  id="<<id;
    QString result=QString::number(min_hours)+":"+QString::number(min_min)+":"+QString::number(id);
    //qDebug()<<"find_firs_alarm (без учета cur_time):"<<result;
    return result;

}




Q_INVOKABLE void MqttClient::get_events_onDay(qint64 timestamp)
{
    m_events_onDay.clear();
    QTimeZone timeZone = QTimeZone::utc();
    qint64 startday=timestamp;
    QDateTime Datestartday = QDateTime::fromMSecsSinceEpoch(timestamp, timeZone);

    // Теперь можем прибавить 1 день
    QDateTime newDateTime = Datestartday.addDays(1);
    qint64 endday = newDateTime.toMSecsSinceEpoch();

    for(const QVariant& item : m_events)
    {
        QVariantMap map = item.toMap();
        qint64 start_event=map["starttime_timestamp"].toLongLong();
        if(start_event>=startday && start_event<=endday)
        {
            m_events_onDay.append(map);
        }
        if(start_event>endday)
        {
            break;
        }
    }
    qDebug()<<"найдено событий в этот день: "<<m_events_onDay.size()<<"  причем в m_events: "<<m_events.size();
    emit events_onDaychanged();
}


Q_INVOKABLE int MqttClient::check_eventOnDay(qint64 timestamp)
{
    int result=0;

    QTimeZone timeZone = QTimeZone::utc();
    qint64 startday=timestamp;
    QDateTime Datestartday = QDateTime::fromMSecsSinceEpoch(timestamp, timeZone);

    // Теперь можем прибавить 1 день
    QDateTime newDateTime = Datestartday.addDays(1);
    qint64 endday = newDateTime.toMSecsSinceEpoch();
    for(const QVariant& item : m_events)
    {
        QVariantMap map = item.toMap();
        qint64 start_event=map["starttime_timestamp"].toLongLong();
        if(start_event>=startday && start_event<=endday)
        {
            result=1;
            break;
        }
    }

    return result;
}


Q_INVOKABLE void MqttClient::publish_sensor_data(QString temp,QString hum,QString voc)
{
    std::string data=(temp+" "+hum+" "+voc).toStdString();;
    client.async_publish<boost::mqtt5::qos_e::at_most_once> (
        "mqtt/sensors", data,
        boost::mqtt5::retain_e::no,
        boost::mqtt5::publish_props{},
        [this](boost::system::error_code ec) {
            if (ec) {
                std::cerr << "Publish error: " << ec.message() << std::endl;
            }
        }
        );
    //qDebug()<<"отправлено: "<<temp<<" "<<hum;
}


Q_INVOKABLE void MqttClient::publish_alarms()
{
    QJsonArray jsonArray=alarms_to_json(m_alarms);
    QJsonDocument jsonDoc(jsonArray);
    std::string jsonString = jsonDoc.toJson(QJsonDocument::Compact).toStdString();
    client.async_publish<boost::mqtt5::qos_e::at_most_once> (
        "mqtt/check", jsonString,
        boost::mqtt5::retain_e::no,
        boost::mqtt5::publish_props{},
        [this](boost::system::error_code ec) {
            if (ec) {
                std::cerr << "Publish error: " << ec.message() << std::endl;
            }
        }
        );
    //qDebug()<<"отправлено: "<<jsonString;
}

Q_INVOKABLE void MqttClient::update_alarm_status(int id,bool status)
{
    for (int i = 0; i < m_alarms.size(); ++i)
    {
        QVariantMap map = m_alarms[i].toMap();
        if (id == map["id"].toInt())
        {
            map["isEnabled"] = status;
            m_alarms[i] = map;
            break;
        }
    }

    QJsonArray jsonArray=alarms_to_json(m_alarms);
    QJsonDocument jsonDoc(jsonArray);
    save_data(jsonDoc,"alarms");
    publish_alarms();
}


Q_INVOKABLE void MqttClient::delete_alarm(int id)
{
    for (int i = 0; i < m_alarms.size(); ++i)
    {
        if (m_alarms[i].toMap()["id"].toInt() == id) {
            m_alarms.removeAt(i);
            break;
        }
    }
    emit alarmschanged();
    QJsonArray jsonArray=alarms_to_json(m_alarms);
    QJsonDocument jsonDoc(jsonArray);
    save_data(jsonDoc,"alarms");
    publish_alarms();

}

Q_INVOKABLE void MqttClient::change_alarm(int id,int alarm_min,int alarm_hours,QString alarm_song,bool delete_after,QVariantList selectedDays)
{
    // qDebug()<<"id: "<<id;
    // qDebug()<<"alarm_min"<<alarm_min;
    // qDebug()<<alarm_hours;
    // qDebug()<<alarm_song;
    // qDebug()<<delete_after;
    // qDebug()<<"selecteddayssize="<<selectedDays.size();

    QVariantMap new_map;
    QString new_time=(alarm_hours<10 ? "0"+QString::number(alarm_hours) : QString::number(alarm_hours))+":"+(alarm_min<10 ? "0"+QString::number(alarm_min) : QString::number(alarm_min));
    for (int i = 0; i < m_alarms.size(); ++i)
    {
        QVariantMap map = m_alarms[i].toMap();
        if (id == map["id"].toInt())
        {
            map["time"] = new_time;
            map["song"]=alarm_song;
            map["delete_after"]=delete_after;
            map["repeatDays"]=selectedDays;
            new_map=map;
            m_alarms.removeAt(i);
            break;
        }
    }

    QTime new_time_formatted=QTime::fromString(new_time,"hh:mm");


    if(m_alarms.isEmpty())
    {
        m_alarms.push_back(new_map);
    }
    else
    {
        for (int i = 0; i < m_alarms.size(); ++i)
        {
            QVariantMap map = m_alarms[i].toMap();
            QString time=map["time"].toString();
            QTime time_formatted=QTime::fromString(time,"hh:mm");
            if (new_time_formatted<time_formatted)
            {
                m_alarms.insert(i,new_map);
                break;
            }
            if(i==m_alarms.size()-1)
            {
                m_alarms.insert(i+1,new_map);
                break;
            }
        }
    }
    emit alarmschanged();
    QJsonArray jsonArray=alarms_to_json(m_alarms);
    QJsonDocument jsonDoc(jsonArray);
    save_data(jsonDoc,"alarms");
    publish_alarms();
    qDebug()<<"alarm changed and saved";
}

Q_INVOKABLE void MqttClient::create_alarm(int additional,int alarm_min,int alarm_hours,QString alarm_song,bool delete_after,QVariantList selectedDays,QString label,bool is_temp)
{
    QVariantMap new_map;
    QString new_time_withoutAdd=(alarm_hours<10 ? "0"+QString::number(alarm_hours) : QString::number(alarm_hours))+":"+(alarm_min<10 ? "0"+QString::number(alarm_min) : QString::number(alarm_min));
    QTime time_formatted_withoutAdd=QTime::fromString(new_time_withoutAdd,"hh:mm");
    QTime time_formatted_withAdd=time_formatted_withoutAdd.addSecs(additional*60);
    QString new_time=time_formatted_withAdd.toString("hh:mm");
    int id=-1000;
    if(m_alarms.size()==0)
    {
        id=0;
    }
    else
    {
        for (int i = 0; i < m_alarms.size(); ++i)
        {
            QVariantMap map = m_alarms[i].toMap();
            if(id<map["id"].toInt())
            {
                id=map["id"].toInt();
            }
        }
    }

    id+=1;
    new_map["id"]=id;
    new_map["time"]=new_time;
    new_map["song"]=alarm_song;
    new_map["delete_after"]=delete_after;
    new_map["repeatDays"]=selectedDays;

    new_map["label"]=label;
    new_map["delay"]=read_user_json("standart_delay").toInt();

    if(is_temp==true)
    {
        new_map["isEnabled"]=true;
    }
    else
    {
        new_map["isEnabled"]=delete_after;
    }
    QTime new_time_formatted=QTime::fromString(new_time,"hh:mm");

    if(m_alarms.isEmpty())
    {
        m_alarms.push_back(new_map);
    }
    else
    {
        for (int i = 0; i < m_alarms.size(); ++i)
        {
            QVariantMap map = m_alarms[i].toMap();
            QString time=map["time"].toString();
            QTime time_formatted=QTime::fromString(time,"hh:mm");
            if (new_time_formatted<time_formatted)
            {
                m_alarms.insert(i,new_map);
                break;
            }
            if(i==m_alarms.size()-1)
            {
                m_alarms.insert(i+1,new_map);
                break;
            }
        }
    }
    emit alarmschanged();
    QJsonArray jsonArray=alarms_to_json(m_alarms);
    QJsonDocument jsonDoc(jsonArray);
    save_data(jsonDoc,"alarms");
    publish_alarms();
}

Q_INVOKABLE void MqttClient::from_events_to_alarms(qint64 timestamp,int days,QString alarm_time,QString alarm_song)
{
    int additional=0;

    QTimeZone timeZone = QTimeZone::utc();
    qint64 cur_time=timestamp;
    QDateTime cur_date = QDateTime::fromMSecsSinceEpoch(timestamp, timeZone);

    // Теперь можем прибавить 1 день
    QDateTime newDateTime = cur_date.addDays(days);
    qint64 limittime = newDateTime.toMSecsSinceEpoch();
    for(const QVariant& item : m_events)
    {
        QVariantMap map = item.toMap();
        qint64 start_event=map["starttime_timestamp"].toLongLong();
        if(start_event>=cur_time && start_event<=limittime)
        {
            QTime time = QTime::fromString(alarm_time, "hh:mm");
            int alarm_hours=time.hour();
            int alarm_min=time.minute();

            QDate start_date=cur_date.date();
            QDate end_date=(QDateTime::fromMSecsSinceEpoch(start_event)).date();
            int days_diff = start_date.daysTo(end_date);
            QString status;
            switch(days_diff)
            {
                case 0:
                    status = "Сегодня: ";
                    break;
                case 1:
                    status = "Завтра: ";
                    break;
                case 2:
                    status = "Послезавтра: ";
                    break;
                case 3:
                case 4:
                    status = "Через " + QString::number(days_diff) + " дня: ";
                    break;
                case 5:
                case 6:
                case 7:
                    status = "Через " + QString::number(days_diff) + " дней: ";
                    break;
                default:
                    status = "Позже: ";
                    break;
            }

            QString label=status+map["title"].toString();

            create_alarm(additional,alarm_min,alarm_hours,alarm_song,true,{false,false,false,false,false,false,false},label,false);
            additional+=1;
        }
    }

}


Q_INVOKABLE void MqttClient::delete_past_events(qint64 cur_time)
{

    for (int i = 0; i < m_events.size(); ++i)
    {
        QVariantMap map =m_events[i].toMap();
        qint64 end_event=map["endTime"].toLongLong();
        if(cur_time>end_event)
        {
            m_events.removeAt(i);
            qDebug()<<"УДАЛИЛ СОБЫТИЕ"<<map["title"];
            qDebug()<<"cur_time: "<<cur_time;
            qDebug()<<"event end time:"<<end_event;
            qDebug()<<"но starttime_timestamp"<<map["starttime_timestamp"];
            --i;
        }
    }
    emit eventschanged();
    emit events_onDaychanged();
    QJsonArray jsonArray=events_to_json(m_events);
    QJsonDocument jsonDoc(jsonArray);
    save_data(jsonDoc,"events");
}

Q_INVOKABLE void MqttClient::set_alarm_delay(int value)
{
    alarm_delay=value;
    emit alarm_delay_changed();
    write_user_json("standart_delay",QString::number(alarm_delay));
}
