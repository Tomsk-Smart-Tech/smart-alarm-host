#ifndef SPOTIFY_H
#define SPOTIFY_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QUrlQuery>
#include <QJsonDocument>
#include <QJsonObject>

class Spotify : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int volume READ get_volume NOTIFY volume_changed)
public:
    explicit Spotify(QObject *parent = nullptr);

    Q_INVOKABLE void change_track_status();
    Q_INVOKABLE void get_access_token();
    Q_INVOKABLE void play_track();
    Q_INVOKABLE void pause_track();
    Q_INVOKABLE void next_track();
    Q_INVOKABLE void prev_track();
    void get_current_track();
    Q_INVOKABLE QVariant current_track_info(const QString &key);
    Q_INVOKABLE void set_volume(int value);
    Q_INVOKABLE int get_volume(){return volume;}

signals:
    void accessTokenUpdated();
    void volume_changed();


private slots:
    void handleTokenReply();

private:
    QNetworkAccessManager *n_manager;
    QString refresh_token;
    QString access_token;
    QString clientID;
    QString clientSecret;
    QVariantMap current_track;
    int volume;
};

#endif // SPOTIFY_H
