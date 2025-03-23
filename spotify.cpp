#include "spotify.h"
#include "general_func.h"


Spotify::Spotify(QObject *parent)
    : QObject{parent}
{
    n_manager = new QNetworkAccessManager(this);

    access_token=read_user_json("spotify_access_token");
    refresh_token=read_user_json("spotify_refresh_token");
    clientID=read_user_json("spotify_clientID");
    clientSecret=read_user_json("spotify_clientSecret");

    //get_access_token();
}

Q_INVOKABLE void Spotify::get_access_token()
{

    QNetworkRequest request(QUrl("https://accounts.spotify.com/api/token"));
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/x-www-form-urlencoded");

    QUrlQuery params;
    params.addQueryItem("grant_type", "refresh_token");
    params.addQueryItem("refresh_token", refresh_token);
    params.addQueryItem("client_id", clientID);
    params.addQueryItem("client_secret", clientSecret);

    QNetworkReply *reply = n_manager->post(request, params.toString(QUrl::FullyEncoded).toUtf8());
    connect(reply, &QNetworkReply::finished, this, &Spotify::handleTokenReply);

}

void Spotify::handleTokenReply() {
    QNetworkReply *reply = qobject_cast<QNetworkReply*>(sender());
    if (reply->error() == QNetworkReply::NoError) {
        QByteArray responseData = reply->readAll();
        QJsonDocument jsonResponse = QJsonDocument::fromJson(responseData);
        QJsonObject jsonObj = jsonResponse.object();

        if (jsonObj.contains("access_token")) {
            access_token = jsonObj["access_token"].toString();
            emit accessTokenUpdated();
            write_user_json("spotify_access_token",access_token);
            qDebug()<<"ACCESS TOKEN CHANGED";
        }
    } else {
        //emit errorOccurred(reply->errorString());
    }

    reply->deleteLater();
}

Q_INVOKABLE void Spotify::play_track()
{

    QNetworkRequest request(QUrl("https://api.spotify.com/v1/me/player/play"));
    request.setRawHeader("Authorization", ("Bearer " + access_token).toUtf8());

    QNetworkReply *reply = n_manager->put(request, QByteArray());
    connect(reply, &QNetworkReply::finished, this, [reply]() {
        if (reply->error() == QNetworkReply::NoError) {
            qDebug() << "Track is now playing!";
        } else {
            qDebug() << "Error playing track:" << reply->errorString();
        }
        reply->deleteLater();
    });
}

Q_INVOKABLE void Spotify::pause_track()
{

    QNetworkRequest request(QUrl("https://api.spotify.com/v1/me/player/pause"));
    request.setRawHeader("Authorization", ("Bearer " + access_token).toUtf8());

    QNetworkReply *reply = n_manager->put(request, QByteArray());
    connect(reply, &QNetworkReply::finished, this, [reply]() {
        if (reply->error() == QNetworkReply::NoError) {
            qDebug() << "Track is paused!";
        } else {
            qDebug() << "Error pausing track:" << reply->errorString();
        }
        reply->deleteLater();
    });
}

Q_INVOKABLE void Spotify::next_track()
{
    QNetworkRequest request(QUrl("https://api.spotify.com/v1/me/player/next"));
    request.setRawHeader("Authorization", ("Bearer " + access_token).toUtf8());

    QNetworkReply *reply = n_manager->post(request, QByteArray());
    connect(reply, &QNetworkReply::finished, this, [reply]() {
        if (reply->error() == QNetworkReply::NoError) {
            qDebug() << "Next track request successful!";
        } else {
            qDebug() << "Error switching to next track:" << reply->errorString();
        }
        reply->deleteLater();
    });
}

Q_INVOKABLE void Spotify::prev_track()
{
    QNetworkRequest request(QUrl("https://api.spotify.com/v1/me/player/previous"));
    request.setRawHeader("Authorization", ("Bearer " + access_token).toUtf8());

    QNetworkReply *reply = n_manager->post(request, QByteArray());
    connect(reply, &QNetworkReply::finished, this, [reply]() {
        if (reply->error() == QNetworkReply::NoError) {
            qDebug() << "Previous track request successful!";
        } else {
            qDebug() << "Error switching to previous track:" << reply->errorString();
        }
        reply->deleteLater();
    });

}

Q_INVOKABLE void Spotify::change_track_status()
{
    QNetworkRequest request(QUrl("https://api.spotify.com/v1/me/player"));
    request.setRawHeader("Authorization", ("Bearer " + access_token).toUtf8());

    QNetworkReply *reply = n_manager->get(request);
    connect(reply, &QNetworkReply::finished, this, [this, reply]() {
        if (reply->error() == QNetworkReply::NoError) {
            QByteArray responseData = reply->readAll();
            QJsonDocument jsonResponse = QJsonDocument::fromJson(responseData);
            QJsonObject jsonObj = jsonResponse.object();

            if (jsonObj.contains("is_playing")) {
                bool isPlaying = jsonObj["is_playing"].toBool();
                if (isPlaying) {
                    pause_track();
                } else {
                    play_track();
                }
            }
        } else {
            qDebug() << "Error getting playback status:" << reply->errorString();
        }
        reply->deleteLater();
    });
}



void Spotify::get_current_track()
{
    QNetworkRequest request(QUrl("https://api.spotify.com/v1/me/player"));
    request.setRawHeader("Authorization", ("Bearer " + access_token).toUtf8());

    QNetworkReply *reply = n_manager->get(request);
    connect(reply, &QNetworkReply::finished, this, [this, reply]() {
        if (reply->error() == QNetworkReply::NoError)
        {
            QByteArray responseData = reply->readAll();
            QJsonDocument jsonResponse = QJsonDocument::fromJson(responseData);
            QJsonObject jsonObj = jsonResponse.object();

            current_track["progress"]=jsonObj["progress_ms"].toInt();
            if (jsonObj.contains("item"))
            {
                QJsonObject item = jsonObj["item"].toObject();
                current_track["track"]=item["name"].toString();
                current_track["duration"]=item["duration_ms"].toInt();

                if (item.contains("artists")) {
                    QJsonArray artists = item["artists"].toArray();
                    if (!artists.isEmpty()) {
                        current_track["artists"] = artists[0].toObject()["name"].toString();
                    }
                }

                if (item.contains("album")) {
                    QJsonObject album = item["album"].toObject();
                    if (album.contains("images")) {
                        QJsonArray images = album["images"].toArray();
                        if (!images.isEmpty()) {
                            current_track["icon"] = images[0].toObject()["url"].toString();
                        }
                    }
                }

            }
            else
            {
                current_track["progress"]=0;
                current_track["track"]="empty";
                current_track["artists"]="empty";
                current_track["duration"]="0";
            }
        }
        else {
            qDebug() << "Error getting playback status:" << reply->errorString();
        }
        reply->deleteLater();
    });
}


Q_INVOKABLE QVariant Spotify::current_track_info(const QString &key)
{
    return current_track.value(key);
}


Q_INVOKABLE void Spotify::set_volume(int value)
{
    volume=value;
    //write_user_json("volume")
}
