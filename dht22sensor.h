#ifndef DHT22SENSOR_H
#define DHT22SENSOR_H

#include <QObject>
#include <QProcess>

class Dht22sensor: public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString temp READ get_temp NOTIFY data_changed)
    Q_PROPERTY(QString humidity READ get_humidity NOTIFY data_changed)

public:
    explicit Dht22sensor(QObject *parent = nullptr);

    QString get_temp() {return m_temp;}
    QString get_humidity() {return m_humidity;}

signals:
    void data_changed();


private slots:
    void read_sensor();

private:
    QProcess *process;
    QString m_temp="NaN";
    QString m_humidity="NaN";
};

#endif // DHT22SENSOR_H
