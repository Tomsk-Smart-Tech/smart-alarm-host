#include "sensors.h"

Sensors::Sensors(QObject *parent): QObject(parent)
{
    process=new QProcess(this);
    process->setProgram("python3");
    process->setArguments(QStringList()<<"/home/avopadla/dht22env/dht22sensor.py");
    process->setProcessChannelMode(QProcess::MergedChannels);

    connect(process,&QProcess::readyReadStandardOutput,this,&Sensors::read_sensor);
    process->start();
}

void Sensors::read_sensor()
{
    QString data = process->readAllStandardOutput().trimmed();
    QStringList values = data.split(" ");
    if (values.size() == 3) {
        m_temp = values[0];
        m_humidity = values[1];
        m_voc_index = values[2];
        emit data_changed();

    }
}
