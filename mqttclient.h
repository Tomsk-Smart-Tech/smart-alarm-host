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
    std::string client_id = "kirill";
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
public:
    explicit MqttClient(QObject *parent = nullptr);
    ~MqttClient();
    int connectionStatus() const { return m_connectionStatus; }
    Q_INVOKABLE QVariantList get_events() const {return m_events;}
    Q_INVOKABLE QVariantList get_alarms() const {return m_alarms;}

signals:
    void messageReceived();
    void connectionStatusChanged();
    void eventschanged();
    void alarmschanged();

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
    QVariantList m_alarms;
    std::thread iocThread;
};

#endif // MQTTCLIENT_H
