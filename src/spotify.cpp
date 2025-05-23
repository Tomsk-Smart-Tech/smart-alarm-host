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
    // volume=read_user_json("volume").toInt();
    get_access_token();
}


void Spotify::handleSpotifyCode(const QString &data)
{
    playlists.clear();
    tracks.clear();
    qDebug()<<"ОБРАБАТЫВАЮ КОД ИЗ SPOTIFYCLASS";
    QJsonDocument jsonDoc = QJsonDocument::fromJson(data.toUtf8());
    QJsonObject jsonObj = jsonDoc.object();
    QString code=jsonObj["authorization_code"].toString();
    QString code_verifier=jsonObj["code_verifier"].toString();
    QNetworkRequest request(QUrl("https://accounts.spotify.com/api/token"));
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/x-www-form-urlencoded");


    // QString credentials = QString("%1:%2").arg(clientID,clientSecret);
    // QString base64Credentials = QString(credentials.toUtf8().toBase64());
    // request.setRawHeader("Authorization", QString("Basic %1").arg(base64Credentials).toUtf8());

    QUrlQuery params;
    params.addQueryItem("grant_type", "authorization_code");
    params.addQueryItem("code", code);
    params.addQueryItem("redirect_uri", "myapp://callback");
    params.addQueryItem("client_id", clientID);
    params.addQueryItem("code_verifier", code_verifier);
    //params.addQueryItem("client_secret", clientSecret);

    QNetworkReply *reply = n_manager->post(request, params.toString(QUrl::FullyEncoded).toUtf8());
    connect(reply, &QNetworkReply::finished, this, [this,reply]() {
        if (reply->error() == QNetworkReply::NoError) {
            QByteArray responseData = reply->readAll();
            QJsonDocument jsonResponse = QJsonDocument::fromJson(responseData);
            QJsonObject jsonObj = jsonResponse.object();
            access_token=jsonObj["access_token"].toString();
            refresh_token=jsonObj["refresh_token"].toString();
            qDebug()<<"new refresh_token: "<<refresh_token;
            qDebug()<<"new access_token: "<<access_token;
            write_user_json("spotify_access_token",access_token);
            write_user_json("spotify_refresh_token",refresh_token);
            scan_playlists();
            get_current_track();
        } else {
            // qDebug() << "Error getting tokens:" << reply->errorString();
            // qWarning() << "Server response:" << reply->readAll();
        }
        reply->deleteLater();
    });
}

Q_INVOKABLE void Spotify::get_access_token()
{

    QNetworkRequest request(QUrl("https://accounts.spotify.com/api/token"));
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/x-www-form-urlencoded");
    // request.setRawHeader(
    //     "Authorization",
    //     QByteArray("Basic ") + (clientID + ":" + clientSecret).toUtf8().toBase64()
    //     );

    QUrlQuery params;
    params.addQueryItem("grant_type", "refresh_token");
    params.addQueryItem("refresh_token", refresh_token);
    params.addQueryItem("client_id", clientID);
    //params.addQueryItem("client_secret", clientSecret);

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
            if (jsonObj.contains("refresh_token")) {
                refresh_token = jsonObj["refresh_token"].toString();
                write_user_json("spotify_refresh_token", refresh_token);
                qDebug() << "NEW REFRESH TOKEN RECEIVED AND SAVED:" << refresh_token; // Логируем для отладки
            }
            scan_playlists();
            get_current_track();
        }
    } else {
        // qDebug() << "Error changing token:" << reply->errorString();
        // qWarning() << "Server response:" << reply->readAll();
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
            //qDebug() << "Error playing track:" << reply->errorString();
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
            //qDebug() << "Error pausing track:" << reply->errorString();
        }
        reply->deleteLater();
    });
}

Q_INVOKABLE void Spotify::next_track()
{
    QNetworkRequest request(QUrl("https://api.spotify.com/v1/me/player/next"));
    request.setRawHeader("Authorization", ("Bearer " + access_token).toUtf8());

    QNetworkReply *reply = n_manager->post(request, QByteArray());
    connect(reply, &QNetworkReply::finished, this, [this,reply]() {
        if (reply->error() == QNetworkReply::NoError) {
            qDebug() << "Next track request successful!";
            QTimer::singleShot(500, this, [this]() {
                get_current_track();
            });
        } else {
            // qDebug() << "Error switching to next track:" << reply->errorString();
            // qWarning() << "Server response:" << reply->readAll();
        }
        reply->deleteLater();
    });

}

Q_INVOKABLE void Spotify::prev_track()
{

    QNetworkRequest request(QUrl("https://api.spotify.com/v1/me/player/previous"));
    request.setRawHeader("Authorization", ("Bearer " + access_token).toUtf8());

    QNetworkReply *reply = n_manager->post(request, QByteArray());
    connect(reply, &QNetworkReply::finished, this, [this,reply]() {
        if (reply->error() == QNetworkReply::NoError) {
            qDebug() << "Previous track request successful!";
            QTimer::singleShot(500, this, [this]() {
                get_current_track();
            });
        } else {
            //qDebug() << "Error switching to previous track:" << reply->errorString();
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
            //qDebug() << "Error getting playback status:" << reply->errorString();
        }
        reply->deleteLater();
    });
}



Q_INVOKABLE void Spotify::get_current_track()
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
            current_track["is_playing"] = jsonObj["is_playing"].toBool();
            current_track["shuffle_state"]=jsonObj["shuffle_state"].toBool();
            current_track["repeat_state"]=jsonObj["repeat_state"].toString();
            if(jsonObj.contains("device"))
            {
                QJsonObject device = jsonObj["device"].toObject();
                current_track["volume"]=device["volume_percent"].toInt();
            }
            if (jsonObj.contains("item"))
            {
                QJsonObject item = jsonObj["item"].toObject();
                current_track["name"]=item["name"].toString();
                current_track["duration"]=item["duration_ms"].toInt();

                //qDebug()<<"track"<<item["name"].toString();

                if (item.contains("artists")) {
                    QJsonArray artists = item["artists"].toArray();
                    if (!artists.isEmpty()) {
                        current_track["artists"] = artists[0].toObject()["name"].toString();
                        //qDebug()<<"artist"<<artists[0].toObject()["name"].toString();
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
                current_track["name"]="empty";
                current_track["artists"]="empty";
                current_track["duration"]=0;
                current_track["volume"]=0;
                current_track["icon"]="resource_icon/music_icon/no_song.png";
            }
            emit cur_track_changed();
        }
        else {
            //qDebug() << "Error getting playback status:" << reply->errorString();
        }
        reply->deleteLater();
    });

}



Q_INVOKABLE void Spotify::scan_playlists()
{
    QNetworkRequest request(QUrl("https://api.spotify.com/v1/me/playlists"));
    request.setRawHeader("Authorization", ("Bearer " + access_token).toUtf8());
    QNetworkReply *reply = n_manager->get(request);
    connect(reply, &QNetworkReply::finished, this, [this, reply]() {
        if (reply->error() == QNetworkReply::NoError)
        {
            QByteArray responseData = reply->readAll();
            QJsonDocument jsonResponse = QJsonDocument::fromJson(responseData);
            QJsonObject jsonObj = jsonResponse.object();
            QJsonArray items = jsonObj["items"].toArray();
            for(const QJsonValue &item : items)
            {
                QVariantMap playlist_map;
                QJsonObject playlistObj = item.toObject();
                playlist_map["id"]=playlistObj["id"].toString();
                playlist_map["name"] = playlistObj["name"].toString();
                QJsonArray images = playlistObj["images"].toArray();
                if (!images.isEmpty()) {
                    playlist_map["icon"] = images.first().toObject()["url"].toString();
                    if(playlist_map["icon"]=="")
                    {
                        playlist_map["icon"] ="resource_icon/music_icon/no_cover.png";
                    }
                }
                else
                {
                    playlist_map["icon"] ="resource_icon/music_icon/no_cover.png";
                }
                playlists.append(playlist_map);
                //qDebug()<<"playlist_name"<<playlistObj["name"].toString()<<"  icon:"<<images.first().toObject()["url"].toString();

            }
            emit playlists_changed();
        }
        else {
            //qDebug() << "Error getting playlists:" << reply->errorString();
            //qWarning() << "Server response:" << reply->readAll();
        }
        reply->deleteLater();
    });
    emit playlists_changed();
}

Q_INVOKABLE void Spotify::scan_playlist_tracks(const QString playlistID)
{
    tracks.clear();
    QString url=QString("https://api.spotify.com/v1/playlists/%1/tracks").arg(playlistID);
    QNetworkRequest request(url);
    request.setRawHeader("Authorization", ("Bearer " + access_token).toUtf8());
    QNetworkReply *reply = n_manager->get(request);
    connect(reply, &QNetworkReply::finished, this, [this, reply]() {
        if (reply->error() == QNetworkReply::NoError)
        {
            QByteArray responseData = reply->readAll();
            QJsonDocument jsonResponse = QJsonDocument::fromJson(responseData);
            QJsonObject jsonObj = jsonResponse.object();
            QJsonArray items = jsonObj["items"].toArray();
            for(const QJsonValue &trackVal : items)
            {
                QVariantMap track_map;
                QJsonObject trackObj=trackVal.toObject()["track"].toObject();
                track_map["name"]=trackObj["name"].toString();
                track_map["id"]=trackObj["id"].toString();


                QJsonArray artists = trackObj["artists"].toArray();
                if (!artists.isEmpty()) {
                    track_map["artists"] = artists.first().toObject()["name"].toString();
                }

                QJsonArray albumImages = trackObj["album"].toObject()["images"].toArray();
                if (!albumImages.isEmpty()) {
                    track_map["icon"] = albumImages.first().toObject()["url"].toString();
                    if(track_map["icon"]=="")
                    {
                        track_map["icon"] ="resource_icon/music_icon/no_song.png";
                    }
                }
                else
                {
                    track_map["icon"] ="resource_icon/music_icon/no_song.png";
                }
                tracks.append(track_map);
                //qDebug()<<"track_name:"<<trackObj["name"].toString()<<" artists:"<<artists.first().toObject()["name"].toString()<<" icon:"<<track_map["icon"];
            }
            emit tracks_changed();
        }
        else {
            //qDebug() << "Error getting playlists tracks:" << reply->errorString();
            //qWarning() << "Server response:" << reply->readAll();
        }
        reply->deleteLater();
    });
    //emit tracks_changed();
}

Q_INVOKABLE void Spotify::set_track(const QString playlistID)
{
    QString trackUri = QString("spotify:track:%1").arg(playlistID); // Заменить на нужный трек
    QString url = "https://api.spotify.com/v1/me/player/play";

    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    request.setRawHeader("Authorization", QByteArray("Bearer " + access_token.toUtf8()));

    QJsonObject json;
    QJsonArray uris;
    uris.append(trackUri);
    json["uris"] = uris;

    QNetworkReply *reply = n_manager->put(request, QJsonDocument(json).toJson());
    connect(reply, &QNetworkReply::finished, this, [this,reply]() {
        if (reply->error() != QNetworkReply::NoError) {
            qWarning() << "Error playing track:" << reply->errorString();
            qWarning() << "Server response:" << reply->readAll();
        } else {
            qDebug() << "Track started playing!";
            get_current_track();
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
    QUrl url(QString("https://api.spotify.com/v1/me/player/volume?volume_percent=%1").arg(value));
    QNetworkRequest request(url);
    request.setRawHeader("Authorization", ("Bearer " + access_token).toUtf8());

    QNetworkReply* reply = n_manager->put(request, QByteArray());
    connect(reply, &QNetworkReply::finished, this, [reply]() {
        if (reply->error() == QNetworkReply::NoError) {
            qDebug() << "Volume changed successfully!";
        } else {
            qWarning() << "Failed to change volume:" << reply->errorString();
            qWarning() << "Server response:" << reply->readAll();
        }
        reply->deleteLater();
    });
}

Q_INVOKABLE void Spotify::change_shuffle(bool state)
{
    QUrl url("https://api.spotify.com/v1/me/player/shuffle");
    QUrlQuery query;
    query.addQueryItem("state", state ? "true" : "false");
    url.setQuery(query);

    QNetworkRequest request(url);
    QString authHeader = QString("Bearer %1").arg(access_token);
    request.setRawHeader("Authorization", authHeader.toUtf8());

    n_manager->put(request, QByteArray());
}

Q_INVOKABLE void Spotify::change_repeat_mode(QString state)
{
    QUrl url("https://api.spotify.com/v1/me/player/repeat");
    QUrlQuery query;
    query.addQueryItem("state", state);
    url.setQuery(query);

    QNetworkRequest request(url);
    QString authHeader = QString("Bearer %1").arg(access_token);
    request.setRawHeader("Authorization", authHeader.toUtf8());

    n_manager->put(request, QByteArray());
}
