#include "linuxterminal.h"
#include "general_func.h"

LinuxTerminal::LinuxTerminal(QObject *parent)
    : QObject{parent}
{
    m_cur_song=read_user_json("current_song");
}


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


        QMetaObject::invokeMethod(this, [this, nets]() {
            m_nets.clear();
            m_nets = nets;
            emit nets_changed();
        }, Qt::QueuedConnection);
    });
}



Q_INVOKABLE void LinuxTerminal::scanSongs(QString path)
{
    m_songs.clear();
    QDirIterator it(path, QStringList() << "*.mp3", QDir::Files, QDirIterator::Subdirectories);
    while (it.hasNext()) {
        QVariantMap map;
        QString filePath = it.next();
        qDebug()<<filePath;
        QString fileName = QFileInfo(filePath).fileName();
        map["songPath"] = filePath;
        map["songName"] = fileName;
        m_songs.append(map);
    }

    emit songs_changed();
}

Q_INVOKABLE void LinuxTerminal::set_song(QString path)
{
    if(m_cur_song!=path)
    {
        m_cur_song=path;
        write_user_json("current_song",path);
        emit cur_song_changed();
    }
}
