#include "linuxterminal.h"

LinuxTerminal::LinuxTerminal(QObject *parent)
    : QObject{parent}
{}

void LinuxTerminal::scanNets()
{
    m_nets.clear();
    QProcess process;
    process.start("bash", QStringList() << "-c" << "nmcli -f SSID,SIGNAL,BARS,SECURITY device wifi | grep -v '^--'");
    process.waitForFinished();
    QString output = process.readAllStandardOutput();

    QSet<QString> seenNames;
    QStringList lines = output.split('\n', Qt::SkipEmptyParts);

    for (const QString& line : lines)
    {
        QString netName = line.left(23).trimmed();
        if (!seenNames.contains(netName))
        {
            seenNames.insert(netName);
            QVariantMap net;
            net["name"]=netName;
            net["signal"]=line.mid(23,3).trimmed();
            net["security"]=line.mid(37,4);
            m_nets.append(net);
            qDebug()<<net["name"]<<net["signal"]<<net["security"];
        }
    }
    m_nets.removeAt(0);
    emit nets_changed();
}
