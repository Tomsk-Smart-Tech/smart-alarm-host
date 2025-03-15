#ifndef LINUXTERMINAL_H
#define LINUXTERMINAL_H

#include <QObject>
#include <QVariantList>
#include <QVariantMap>
#include <QProcess>
#include <QDebug>
#include <QtConcurrent>

class LinuxTerminal : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QVariantList nets READ get_nets NOTIFY nets_changed)
    Q_PROPERTY(QVariantList songs READ get_songs NOTIFY songs_changed)
    Q_PROPERTY(QString cur_song READ get_cur_song NOTIFY cur_song_changed)

public:
    explicit LinuxTerminal(QObject *parent = nullptr);

    QVariantList get_nets() const {return m_nets;}
    QVariantList get_songs() const {return m_songs;}
    QString get_cur_song() const {return m_cur_song;}

    Q_INVOKABLE void scanNets();
    Q_INVOKABLE void scanSongs(QString path);
    Q_INVOKABLE void set_song(QString path);
signals:
    void nets_changed();
    void songs_changed();
    void cur_song_changed();

private:
    QVariantList m_nets;
    QVariantList m_songs;
    QString m_cur_song;
    int cur_volume;
};

#endif // LINUXTERMINAL_H
