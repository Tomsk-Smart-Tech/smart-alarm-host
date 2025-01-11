#include "weather.h"

QString read_user_json(const QString key)
{
    QDir currentDir = QDir::currentPath();
    currentDir.cdUp();
    currentDir.cdUp();
    QString userfile = currentDir.filePath("userdata.json");
    QFile file(userfile);
    if (!file.open(QIODevice::ReadWrite | QIODevice::Text))
    {
        qDebug() << "Failed to open file for read and write:" << file.errorString();
    }
    QByteArray fileData = file.readAll();
    QJsonDocument jsonDoc(QJsonDocument::fromJson(fileData));
    QJsonObject jsonObj = jsonDoc.object();
    QString param = jsonObj.value(key).toString();
    file.close();
    return param;
}

void write_user_json(const QString key,const QString newval)
{
    QDir currentDir = QDir::currentPath();
    currentDir.cdUp();
    currentDir.cdUp();
    QString userfile = currentDir.filePath("userdata.json");
    QFile file(userfile);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        qDebug() << "Failed to open file for read " << file.errorString();
    }
    QByteArray fileData = file.readAll();
    file.close();

    QJsonDocument jsonDoc(QJsonDocument::fromJson(fileData));
    QJsonObject jsonObj = jsonDoc.object();
    jsonObj[key]=newval;
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text | QIODevice::Truncate))
    {
        qDebug() << "Failed to open file for writing:" << file.errorString();
    }
    QJsonDocument updatedJsonDoc(jsonObj);
    file.write(updatedJsonDoc.toJson());
    file.close();
}


Weather::Weather() : n_manager(new QNetworkAccessManager(this))
{
    QString city=read_user_json("city");
    m_city=city;
    h_forecast.clear();
    request_position();
}

void Weather::set_city(const QString &value)
{
    if(m_city!=value)
    {
        m_city=value;
        write_user_json("city",m_city);
        h_forecast.clear();
        emit city_changed();
        request_position();

    }
}

void Weather::request_position()
{
    QString api_key="07fd2533a6b04b2e33350858fa6acd10";
    const QString url = QString("http://api.openweathermap.org/geo/1.0/direct?q=%1&limit=1&appid=%2").arg(m_city, api_key);
    //qDebug() << "Request URL:" << url;
    QNetworkRequest request(url);
    QNetworkReply *reply = n_manager->get(request);
    connect(reply, &QNetworkReply::finished, this, &Weather::handleReply_pos);
}

void Weather::handleReply_pos()
{
    QNetworkReply *reply = qobject_cast<QNetworkReply *>(sender());
    if (reply->error() == QNetworkReply::NoError) {
        const QByteArray response = reply->readAll();
        const QJsonDocument jsonDoc = QJsonDocument::fromJson(response);
        const QJsonArray jsonArray = jsonDoc.array();
        if (!jsonArray.isEmpty()) {
            const QJsonObject jsonObj = jsonArray.first().toObject();
            m_latitude = QString::number(jsonObj["lat"].toDouble());
            m_longitude = QString::number(jsonObj["lon"].toDouble());
            //emit coordinates_changed();
        }
    }
    reply->deleteLater();
    request_weather();
    request_data();
}

void Weather::request_data()
{
    const QString url =QString("https://timeapi.io/api/time/current/coordinate?latitude=%1&longitude=%2").arg(m_latitude,m_longitude);
    //qDebug() << "Request URL:" << url;
    QNetworkRequest request(url);
    QNetworkReply *reply = n_manager->get(request);
    connect(reply, &QNetworkReply::finished, this, &Weather::handleReply_time);

}

void Weather::handleReply_time()
{
    QNetworkReply *reply = qobject_cast<QNetworkReply *>(sender());
    if (reply->error() == QNetworkReply::NoError)
    {
        const QByteArray response = reply->readAll();
        const QJsonDocument jsonDoc = QJsonDocument::fromJson(response);
        QJsonObject jsonObj = jsonDoc.object();
        int year = jsonObj["year"].toInt();
        int month = jsonObj["month"].toInt();
        int day = jsonObj["day"].toInt();
        int hour = jsonObj["hour"].toInt();
        int minute = jsonObj["minute"].toInt();
        int seconds = jsonObj["seconds"].toInt();

        QDateTime dateTime(QDate(year, month, day), QTime(hour, minute, seconds));
        cur_time= dateTime.toMSecsSinceEpoch();
        emit coordinates_changed();
        emit data_changed();
        emit h_weather_changed();
    }
    else
    {
        qDebug() << "Error in network reply: " << reply->errorString();
        request_position();
    }

    reply->deleteLater();
}

// void Weather::request_weather()
// {
//     QString api_key="07fd2533a6b04b2e33350858fa6acd10";
//     QString language="eng";
//     QString cnt="30";
//     QString units="metric";
//     const QString url = QString("https://pro.openweathermap.org/data/2.5/forecast/hourly?lat=%1&lon=%2&appid=%3&lang=%4&cnt=%5&units=%6")
//                       .arg(m_latitude,m_longitude,api_key,language,cnt,units);
//     qDebug() << "Request URL:" << url;
//     QNetworkRequest request(url);
//     QNetworkReply *reply = n_manager->get(request);
//     connect(reply, &QNetworkReply::finished, this, &Weather::handleReply_weather);
// }

// void Weather::handleReply_weather()
// {
//     QNetworkReply *reply = qobject_cast<QNetworkReply *>(sender());
//     if (reply->error() == QNetworkReply::NoError)
//     {
//         qDebug()<<"check";
//         const QByteArray response = reply->readAll();
//         const QJsonDocument jsonDoc = QJsonDocument::fromJson(response);
//         QJsonObject root = jsonDoc.object();
//         QJsonArray list=root["list"].toArray();
//         QVariantList hours;
//         double mint=1000;
//         double maxt=-1000;
//         int search_temp=1;
//         for(const QJsonValue &value:list)
//         {
//             QVariantMap map;
//             QJsonObject obj=value.toObject();
//             map["osadki"]=obj["pop"].toDouble()*100;
//             map["time"]=obj["dt_txt"].toString().mid(11);//только время
//             if(obj["dt_txt"].toString().mid(11)=="00:00:00")
//             {
//                 search_temp=0;
//             }

//             QJsonObject main=obj["main"].toObject();
//             map["temp"]=main["temp"].toDouble();
//             map["feels_temp"]=main["feels_like"].toDouble();
//             double temp_min=main["temp_min"].toDouble();
//             double temp_max=main["temp_max"].toDouble();
//             if(temp_min<mint && search_temp==1)
//             {
//                 mint=temp_min;
//             }
//             if(temp_max>maxt && search_temp==1)
//             {
//                 maxt=temp_max;
//             }

//             map["humidity"]=main["humidity"].toInt();

//             QJsonArray weatherarr=obj["weather"].toArray();
//             QJsonObject weather=weatherarr.first().toObject();
//             map["main"]=weather["main"].toString();
//             map["description"]=weather["description"].toString();
//             map["icon"]=weather["icon"].toString();

//             QJsonObject wind=obj["wind"].toObject();
//             map["wind_speed"]=wind["speed"].toDouble();



//             hours.append(map);
//         }

//         h_forecast=hours.mid(6);//убираю первые 6+1 - текущая погода
//         cur_forecast=h_forecast.at(0).toMap();
//         cur_forecast["temp_min"]=mint;
//         cur_forecast["temp_max"]=maxt;
//         h_forecast=hours.mid(1);
//         emit h_weather_changed();
//     }
//     else
//     {
//         qDebug() << "Error in network reply: " << reply->errorString();
//     }
// }


void Weather::request_weather()
{
    QString api_key="e2959452db5643d1ae6123433250501";
    QString q=m_latitude+","+m_longitude;
    QString lang="ru";
    const QString url = QString("http://api.weatherapi.com/v1/forecast.json?key=%1&q=%2&lang=%3")
                            .arg(api_key,q,lang);
    qDebug() << "Request URL:" << url;
    QNetworkRequest request(url);
    QNetworkReply *reply = n_manager->get(request);
    connect(reply, &QNetworkReply::finished, this, &Weather::handleReply_weather);
}

void Weather::handleReply_weather()
{
    QNetworkReply *reply = qobject_cast<QNetworkReply *>(sender());
    if (reply->error() == QNetworkReply::NoError)
    {
        qDebug()<<"check";
        const QByteArray response = reply->readAll();
        const QJsonDocument jsonDoc = QJsonDocument::fromJson(response);
        QJsonObject root = jsonDoc.object();
        //вначале считываем текущую погоду
        QJsonObject current=root["current"].toObject();

        cur_forecast["temp"]=current["temp_c"].toDouble();
        cur_forecast["wind_speed"]=current["wind_kph"].toDouble();
        cur_forecast["osadki"]=current["precip_mm"].toDouble();
        cur_forecast["humidity"]=current["humidity"].toDouble();
        cur_forecast["feels_temp"]=current["feelslike_c"].toDouble();
        cur_forecast["dewpoint_c"]=current["dewpoint_c"].toDouble();
        cur_forecast["uv"]=current["uv"].toDouble();

        QJsonObject condition = current["condition"].toObject();
        cur_forecast["icon"]=condition["icon"].toString();
        cur_forecast["description"]=condition["text"].toString();

        QJsonObject forecast=root["forecast"].toObject();
        QJsonArray forecastday=forecast["forecastday"].toArray();
        QJsonObject dayObj = forecastday[0].toObject();

        QJsonObject day = dayObj["day"].toObject();
        cur_forecast["temp_min"]=day["mintemp_c"].toDouble();
        cur_forecast["temp_max"]=day["maxtemp_c"].toDouble();
        cur_forecast["total_precip"]=day["totalprecip_mm"].toDouble();

        QJsonObject astro = dayObj["astro"].toObject();
        cur_forecast["sunrise"]=astro["sunrise"].toString().chopped(3);
        QTime sunset =QTime::fromString(astro["sunset"].toString(), "hh:mm AP");
        cur_forecast["sunset"]=sunset.toString("HH:mm");

        QJsonArray hours = dayObj["hour"].toArray();
        for(const QJsonValue &value:hours)
        {
            QVariantMap map;
            QJsonObject obj=value.toObject();

            map["time"]=obj["time"].toString().mid(11);
            map["temp"]=obj["temp_c"].toDouble();
            map["humidity"]=obj["humidity"].toDouble();
            QJsonObject condition_h=obj["condition"].toObject();
            map["icon"]=condition_h["icon"].toString();

            h_forecast.append(map);
        }
        emit h_weather_changed();
    }
    else
    {
        qDebug() << "Error in network reply: " << reply->errorString();
    }

}
