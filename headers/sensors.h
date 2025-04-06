#ifndef SENSORS_H
#define SENSORS_H

#include <QObject>
#include <QProcess>

class Sensors : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString temp READ get_temp NOTIFY data_changed)
    Q_PROPERTY(QString humidity READ get_humidity NOTIFY data_changed)
    Q_PROPERTY(QString voc_index READ get_voc NOTIFY data_changed)
public:
    explicit Sensors(QObject *parent = nullptr);

    QString get_temp() {return m_temp;}
    QString get_humidity() {return m_humidity;}
    QString get_voc(){return m_voc_index;}

signals:
    void data_changed();

private slots:
    void read_sensor();

private:
    QProcess *process;
    QString m_temp="NaN";
    QString m_humidity="NaN";
    QString m_voc_index="NaN";
};

#endif // SENSORS_H
