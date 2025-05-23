#ifndef MQTTCLIENT_H
#define MQTTCLIENT_H

#include <QObject>

#include <QDateTime>
#include <QJsonDocument>
#include <QJsonObject>
#include <QFile>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonValue>
#include <QVariant>
#include <QVariantList>
#include <QVariantMap>
#include <boost/asio/use_awaitable.hpp>
#include <QFile>
#include <QDir>
#include <QTimer>

#include <boost/mqtt5/logger.hpp>
#include <boost/mqtt5/mqtt_client.hpp>
#include <boost/mqtt5/reason_codes.hpp>
#include <boost/mqtt5/types.hpp>
#include <boost/mqtt5/ssl.hpp> // OpenSSL traits

#include <boost/asio/as_tuple.hpp>
#include <boost/asio/co_spawn.hpp>
#include <boost/asio/deferred.hpp>

#include <boost/asio/detached.hpp>
#include <boost/asio/io_context.hpp>
#include <boost/asio/ip/tcp.hpp>
#include <boost/asio/ssl.hpp>
#include <boost/asio/signal_set.hpp>

#include <thread>

#include <iostream>
#include <string>


struct config {
    std::string brokers = "6a41760a26ec43f2b0e532601ce780e1.s1.eu.hivemq.cloud";
    uint16_t port = 8883;
    std::string client_id = "meme";
    std::string username = "nikita";
    std::string password = "Flowers123";
};

constexpr auto use_nothrow_awaitable = boost::asio::as_tuple(boost::asio::deferred);
namespace boost::mqtt5 {

template <typename StreamBase>
struct tls_handshake_type<boost::asio::ssl::stream<StreamBase>> {
    static constexpr auto client = boost::asio::ssl::stream_base::client;
};

template <typename StreamBase>
void assign_tls_sni(
    const authority_path& ap,
    boost::asio::ssl::context& /* ctx */,
    boost::asio::ssl::stream<StreamBase>& stream
    ) {
    SSL_set_tlsext_host_name(stream.native_handle(), ap.host.c_str());
}

} // end namespace boost::mqtt5




class MqttClient : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int connectionStatus READ connectionStatus NOTIFY connectionStatusChanged)
    Q_PROPERTY(QVariantList events READ get_events NOTIFY eventschanged)
    Q_PROPERTY(QVariantList alarms READ get_alarms NOTIFY alarmschanged)
    Q_PROPERTY(QVariantList events_onDay READ get_events_onDay NOTIFY events_onDaychanged)
    Q_PROPERTY(int alarm_delay READ get_alarm_delay NOTIFY alarm_delay_changed )
public:
    explicit MqttClient(QObject *parent = nullptr);
    ~MqttClient();

    //Q_INVOKABLE void get_spotify_code();
    int connectionStatus() const { return m_connectionStatus; }
    Q_INVOKABLE QVariantList get_events() const {return m_events;}
    Q_INVOKABLE QVariantList get_alarms() const {return m_alarms;}
    Q_INVOKABLE QVariantList get_events_onDay() const {return m_events_onDay;}

    Q_INVOKABLE QString  find_first_alarm(int cur_day,const QVariant cur_time);
    Q_INVOKABLE void alarm_start(int id); //функция основная для срабатываня будильника

    Q_INVOKABLE void get_events_onDay(qint64 timestamp);
    Q_INVOKABLE int check_eventOnDay(qint64 timestamp);

    Q_INVOKABLE void publish_sensor_data(QString temp, QString hum, QString voc);
    Q_INVOKABLE void publish_alarms();

    Q_INVOKABLE void update_alarm_status(int id,bool status); //для мини будильника
    Q_INVOKABLE void delete_alarm(int id);
    Q_INVOKABLE void change_alarm(int id,int alarm_min,int alarm_hours,QString alarm_song,bool delete_after,QVariantList selectedDays);
    Q_INVOKABLE void create_alarm(int additional,int alarm_min,int alarm_hours,QString alarm_song,bool delete_after,QVariantList selectedDays,QString label,bool is_temp);
    Q_INVOKABLE void from_events_to_alarms(qint64 timestamp,int days,QString alarm_time,QString alarm_song);
    Q_INVOKABLE void delete_past_events(qint64 cur_time);

    Q_INVOKABLE void set_alarm_delay(int value);
    Q_INVOKABLE int get_alarm_delay(){return alarm_delay;};

signals:
    void messageReceived();
    void connectionStatusChanged();
    void eventschanged();
    void alarmschanged();
    void events_onDaychanged();
    void alarm_delay_changed();
    void spotifycode_received(const QString &data);

private slots:
    void setConnectionStatus(int status);
    void setEvents(const QVariantList &newEvents);
    void setAlarms(const QVariantList &newAlarms);

private:
    config cfg;
    boost::asio::io_context ioc;
    boost::asio::ssl::context context;

    boost::mqtt5::mqtt_client<
        boost::asio::ssl::stream<boost::asio::ip::tcp::socket>,
        boost::asio::ssl::context,
        boost::mqtt5::logger
        > client;


    int m_connectionStatus;
    QVariantList m_events;
    QVariantList m_events_onDay;
    QVariantList m_alarms;
    int alarm_delay;
    std::thread iocThread;
};

#endif // MQTTCLIENT_H
