#ifndef SPOTIFY_H
#define SPOTIFY_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QUrlQuery>
#include <QJsonDocument>
#include <QJsonObject>
#include <QTimer>

class Spotify : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int volume READ get_volume NOTIFY volume_changed)
    Q_PROPERTY(QVariantMap current READ get_cur_track NOTIFY cur_track_changed)
    Q_PROPERTY(QVariantList playlists_list READ get_playlists NOTIFY playlists_changed )
    Q_PROPERTY(QVariantList tracks READ get_tracks NOTIFY tracks_changed)
public:
    explicit Spotify(QObject *parent = nullptr);

    Q_INVOKABLE void change_track_status();
    Q_INVOKABLE void get_access_token();
    Q_INVOKABLE void play_track();
    Q_INVOKABLE void pause_track();
    Q_INVOKABLE void next_track();
    Q_INVOKABLE void prev_track();
    Q_INVOKABLE void get_current_track();
    Q_INVOKABLE void scan_playlists();
    Q_INVOKABLE void scan_playlist_tracks(const QString playlistID);
    Q_INVOKABLE void set_track(const QString playlistID);
    Q_INVOKABLE QVariant current_track_info(const QString &key);
    Q_INVOKABLE void set_volume(int value);
    Q_INVOKABLE int get_volume(){return volume;}
    Q_INVOKABLE QVariantMap get_cur_track(){return current_track;}
    Q_INVOKABLE QVariantList get_playlists(){return playlists;}
    Q_INVOKABLE QVariantList get_tracks(){return tracks;}
    Q_INVOKABLE void change_shuffle(bool state);
    Q_INVOKABLE void change_repeat_mode(QString state);


signals:
    void accessTokenUpdated();
    void volume_changed();
    void cur_track_changed();
    void playlists_changed();
    void tracks_changed();

private slots:
    void handleTokenReply();
public slots:
    void handleSpotifyCode(const QString &data);

private:
    QNetworkAccessManager *n_manager;
    QString refresh_token;
    QString access_token;
    QString clientID;
    QString clientSecret;
    QVariantMap current_track;
    QVariantList playlists;
    QVariantList tracks;
    int volume;
};

#endif // SPOTIFY_H
