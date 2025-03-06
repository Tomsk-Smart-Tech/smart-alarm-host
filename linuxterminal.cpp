#include "linuxterminal.h"

LinuxTerminal::LinuxTerminal(QObject *parent)
    : QObject{parent}
{
    scanNets();
}

// void LinuxTerminal::scanNets()
// {

//     m_nets.clear();
//     QProcess process;
//     process.start("bash", QStringList() << "-c" << "nmcli -f SSID,SIGNAL,SECURITY device wifi | grep -v '^--'");
//     process.waitForFinished();
//     QString output = process.readAllStandardOutput();

//     QSet<QString> seenNames;
//     QStringList lines = output.split('\n', Qt::SkipEmptyParts);

//     for (const QString& line : lines)
//     {
//         QString netName = line.left(18).trimmed();
//         if (!seenNames.contains(netName))
//         {
//             seenNames.insert(netName);
//             QVariantMap net;
//             net["name"]=netName;
//             int signal=line.mid(line.size()-20,3).trimmed().toInt();
//             if(signal>66)
//             {
//                 net["signal"]="3";
//             }
//             else if(signal<33)
//             {
//                 net["signal"]="1";
//             }
//             else
//             {
//                 net["signal"]="2";
//             }
//             QString security = line.mid(line.size()-12,4);
//             if(security=="--")
//             {
//                 net["security"]=false;
//             }
//             else
//             {
//                 net["security"]=true;
//             }
//             m_nets.append(net);
//             //qDebug()<<net["name"]<<net["signal"]<<net["security"];
//         }
//     }
//     m_nets.removeAt(0);
//     emit nets_changed();
// }


void LinuxTerminal::scanNets()
{
    // Запуск всей логики в фоновом потоке
    QThreadPool::globalInstance()->start([this]() {
        QProcess process;
        process.start("bash", QStringList() << "-c" << "nmcli -f SSID,SIGNAL,SECURITY device wifi | grep -v '^--'");
        process.waitForFinished();
        QString output = process.readAllStandardOutput();

        QVariantList nets;
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
                int signal=line.mid(line.size()-20,3).trimmed().toInt();
                if(signal>66)
                {
                    net["signal"]="3";
                }
                else if(signal<33)
                {
                    net["signal"]="1";
                }
                else
                {
                    net["signal"]="2";
                }
                QString security = line.mid(line.size()-12,4);
                if(security=="--")
                {
                    net["security"]=false;
                }
                else
                {
                    net["security"]=true;
                }
                nets.append(net);
                qDebug()<<net["name"]<<net["signal"]<<net["security"];
            }
        }

        if (!nets.isEmpty()) {
            nets.removeAt(0); // Убираем первую строку
        }

        // Обновление данных в основном потоке
        QMetaObject::invokeMethod(this, [this, nets]() {
            m_nets.clear();
            m_nets = nets;
            emit nets_changed();
        }, Qt::QueuedConnection);
    });
}
