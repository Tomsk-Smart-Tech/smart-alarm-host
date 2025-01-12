#ifndef WEATHER_H
#define WEATHER_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QDebug>
#include <QVariant>
#include <QVariantList>
#include <QVariantMap>
#include <QFile>
#include <QDir>
#include <QCoreApplication>



class Weather:public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString city READ get_city NOTIFY city_changed)
    Q_PROPERTY(QString latitude READ get_latitude NOTIFY coordinates_changed)
    Q_PROPERTY(QString longitude READ get_longitude NOTIFY coordinates_changed)
    Q_PROPERTY(quint64 unixtime READ get_time NOTIFY data_changed)
    Q_PROPERTY(QVariantMap cur_weather READ get_cur_forecast NOTIFY h_weather_changed)
    Q_PROPERTY(QVariantList h_weather READ get_h_forecast NOTIFY h_weather_changed)
    Q_PROPERTY(QVariantList d_weather READ get_d_forecast NOTIFY h_weather_changed)



public:
    Weather();

    QString get_city() const { return m_city; }
    QString get_latitude() const { return m_latitude; }
    QString get_longitude() const { return m_longitude; }
    quint64 get_time() const {return cur_time;}
    QVariantList get_h_forecast() const {return h_forecast;}
    QVariantList get_d_forecast() const {return d_forecast;}
    QVariantMap get_cur_forecast() const {return cur_forecast;}


    Q_INVOKABLE void set_city(const QString &value);
    Q_INVOKABLE void request_position();
    Q_INVOKABLE void request_data();
    Q_INVOKABLE void request_weather();


signals:
    void city_changed();
    void coordinates_changed();
    void data_changed();
    void h_weather_changed();

private slots:
    void handleReply_pos();
    void handleReply_time();
    void handleReply_weather();
    void handleReply_days();

private:
    QNetworkAccessManager *n_manager;
    QString m_city;
    QString m_latitude;
    QString m_longitude;
    quint64 cur_time;
    QVariantMap cur_forecast;
    QVariantList h_forecast;
    QVariantList d_forecast;
};

#endif // WEATHER_H
