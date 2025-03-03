#include "linuxterminal.h"

LinuxTerminal::LinuxTerminal(QObject *parent)
    : QObject{parent}
{
    scanNets();
}

void LinuxTerminal::scanNets()
{
    m_nets.clear();
    QProcess process;
    process.start("bash", QStringList() << "-c" << "nmcli -f SSID,SIGNAL,SECURITY device wifi | grep -v '^--'");
    process.waitForFinished();
    QString output = process.readAllStandardOutput();

    QSet<QString> seenNames;
    QStringList lines = output.split('\n', Qt::SkipEmptyParts);

    for (const QString& line : lines)
    {
        QString netName = line.left(18).trimmed();
        if (!seenNames.contains(netName))
        {
            seenNames.insert(netName);
            QVariantMap net;
            net["name"]=netName;
            net["signal"]=line.mid(line.size()-20,3).trimmed();
            net["security"]=line.mid(line.size()-12,4);
            m_nets.append(net);

            //qDebug()<<net["name"]<<net["signal"]<<net["security"];
        }
    }
    m_nets.removeAt(0);
    emit nets_changed();
}


// void LinuxTerminal::scanNets()
// {
//     // Запуск всей логики в фоновом потоке
//     QtConcurrent::run([this]() {
//         QProcess process;
//         process.start("bash", QStringList() << "-c" << "nmcli -f SSID,SIGNAL,BARS,SECURITY device wifi | grep -v '^--'");
//         process.waitForFinished();
//         QString output = process.readAllStandardOutput();

//         QVariantList nets;
//         QSet<QString> seenNames;
//         QStringList lines = output.split('\n', Qt::SkipEmptyParts);

//         for (const QString& line : lines)
//         {
//             QString netName = line.left(23).trimmed();
//             if (!seenNames.contains(netName))
//             {
//                 seenNames.insert(netName);
//                 QVariantMap net;
//                 net["name"] = netName;
//                 net["signal"] = line.mid(23, 3).trimmed();
//                 net["security"] = line.mid(37, 4);
//                 nets.append(net);
//                 qDebug() << net["name"] << net["signal"] << net["security"];
//             }
//         }

//         if (!nets.isEmpty()) {
//             nets.removeAt(0); // Убираем первую строку
//         }

//         // Обновление данных в основном потоке
//         QMetaObject::invokeMethod(this, [this, nets]() {
//             m_nets = nets;
//             emit nets_changed();
//         }, Qt::QueuedConnection);
//     });
// }
