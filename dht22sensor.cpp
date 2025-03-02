#include "dht22sensor.h"

Dht22sensor::Dht22sensor(QObject *parent): QObject(parent)
{
    process=new QProcess(this);
    process->setProgram("python3");
    process->setArguments(QStringList()<<"/home/avopadla/dht22env/dht22sensor.py");
    process->setProcessChannelMode(QProcess::MergedChannels);

    connect(process,&QProcess::readyReadStandardOutput,this,&Dht22sensor::read_sensor);
    process->start();
}

void Dht22sensor::read_sensor()
{
    QString data = process->readAllStandardOutput().trimmed();
    QStringList values = data.split(" ");
    if (values.size() == 2) {
        m_temp = values[0];
        m_humidity = values[1];
        emit data_changed();

    }
}
