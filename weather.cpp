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
    //setup city
    QString city=read_user_json("city");
    m_city=city;
    //read api keys
    QDir currentDir = QDir::currentPath();
    currentDir.cdUp();
    currentDir.cdUp();
    QString apifile = currentDir.filePath("api_keys.txt");
    QFile file(apifile);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        qDebug() << "Failed to open file for read and write:" << file.errorString();
    }
    QTextStream in(&file);
    openweathermap_key=in.readLine();
    weatherapi_key=in.readLine();
    file.close();
    //weather setup
    request_position();
}

void Weather::set_city(const QString &value)
{
    if(m_city!=value)
    {
        m_city=value;
        write_user_json("city",m_city);
        cur_forecast.clear();
        h_forecast.clear();
        d_forecast.clear();
        emit city_changed();
        request_position();

    }
}

void Weather::request_position()
{
    const QString url = QString("http://api.openweathermap.org/geo/1.0/direct?q=%1&limit=1&appid=%2").arg(m_city, openweathermap_key);
    QNetworkRequest request(url);
    QNetworkReply *reply = n_manager->get(request);
    connect(reply, &QNetworkReply::finished, this, &Weather::handleReply_pos);
}

void Weather::handleReply_pos()
{
    QNetworkReply *reply = qobject_cast<QNetworkReply *>(sender());
    if (reply->error() == QNetworkReply::NoError)
    {
        const QByteArray response = reply->readAll();
        const QJsonDocument jsonDoc = QJsonDocument::fromJson(response);
        const QJsonArray jsonArray = jsonDoc.array();
        if (!jsonArray.isEmpty()) {
            const QJsonObject jsonObj = jsonArray.first().toObject();
            m_latitude = QString::number(jsonObj["lat"].toDouble());
            m_longitude = QString::number(jsonObj["lon"].toDouble());
            emit coordinates_changed();
        }
        request_data();
    }
    reply->deleteLater();

}

void Weather::request_data()
{
    //request time
    const QString url1 =QString("https://timeapi.io/api/time/current/coordinate?latitude=%1&longitude=%2").arg(m_latitude,m_longitude);
    QNetworkRequest request1(url1);
    QNetworkReply *reply1 = n_manager->get(request1);
    connect(reply1, &QNetworkReply::finished, this, &Weather::handleReply_time);


    //request current weather
    QString q=m_latitude+","+m_longitude;
    QString lang="ru";
    const QString url2 = QString("http://api.weatherapi.com/v1/forecast.json?key=%1&q=%2&lang=%3&days=2")
                            .arg(weatherapi_key,q,lang);
    QNetworkRequest request2(url2);
    QNetworkReply *reply2 = n_manager->get(request2);
    connect(reply2, &QNetworkReply::finished, this, &Weather::handleReply_weather);


    //request daily weather
    QString language="eng";
    QString cnt="8";
    QString units="metric";
    const QString url3 = QString("https://api.openweathermap.org/data/2.5/forecast/daily?lat=%1&lon=%2&appid=%3&lang=%4&cnt=%5&units=%6")
                             .arg(m_latitude,m_longitude,openweathermap_key,language,cnt,units);
    QNetworkRequest request3(url3);
    QNetworkReply *reply3 = n_manager->get(request3);
    connect(reply3, &QNetworkReply::finished, this, &Weather::handleReply_days);



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
        // emit coordinates_changed();
        emit data_changed();
    }
    else
    {
        qDebug() << "Error in network time_reply: " << reply->errorString();
        request_data();
        //handleReply_time(); //что не так со вркменем
    }

    reply->deleteLater();
}



void Weather::handleReply_weather()
{
    h_forecast.clear();
    QNetworkReply *reply = qobject_cast<QNetworkReply *>(sender());
    if (reply->error() == QNetworkReply::NoError)
    {

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

        QString cur_time1=current["last_updated"].toString().mid(11);
        QString cur_time2=cur_time1.chopped(2)+"00";
        QTime cur_time3 =QTime::fromString(cur_time2, "hh:mm");

        QJsonObject condition = current["condition"].toObject();
        cur_forecast["icon"]=condition["icon"].toString();
        cur_forecast["description"]=condition["text"].toString();

        QJsonObject forecast=root["forecast"].toObject();
        QJsonArray forecastday=forecast["forecastday"].toArray();
        QJsonObject dayObj1 = forecastday[0].toObject(); //1 день - текущий

        QJsonObject day1 = dayObj1["day"].toObject();
        cur_forecast["temp_min"]=day1["mintemp_c"].toDouble();
        double min_day1=cur_forecast["temp_min"].toDouble();
        cur_forecast["temp_max"]=day1["maxtemp_c"].toDouble();
        double max_day1=cur_forecast["temp_max"].toDouble();
        cur_forecast["total_precip"]=day1["totalprecip_mm"].toDouble();

        QJsonObject astro = dayObj1["astro"].toObject();
        cur_forecast["sunrise"]=astro["sunrise"].toString().chopped(3);
        QTime sunset =QTime::fromString(astro["sunset"].toString(), "hh:mm AP");
        cur_forecast["sunset"]=sunset.toString("HH:mm");

        QJsonArray hours1 = dayObj1["hour"].toArray();
        int hours_counter=0;
        for(const QJsonValue &value:hours1)
        {
            QVariantMap map;
            QJsonObject obj=value.toObject();

            QTime h_data=QTime::fromString(obj["time"].toString().mid(11), "hh:mm");
            if(h_data>=cur_time3)
            {
                map["time"]=obj["time"].toString().mid(11);
                map["temp"]=obj["temp_c"].toDouble();
                map["humidity"]=obj["humidity"].toDouble();
                QJsonObject condition_h=obj["condition"].toObject();
                map["icon"]=condition_h["icon"].toString();
                hours_counter++;
                h_forecast.append(map);
            }
        }
        //qDebug()<<"в первом дне выводится часов:"<<hours_counter;

        QJsonObject dayObj2 = forecastday[1].toObject(); //следующий день
        QJsonObject day2 = dayObj2["day"].toObject();
        QJsonArray hours2 = dayObj2["hour"].toArray();


        for(int i = 0; i <= hours2.size()-hours_counter; i++)
        {
            QVariantMap map;
            QJsonObject obj=hours2[i].toObject();
            map["time"]=obj["time"].toString().mid(11);
            map["temp"]=obj["temp_c"].toDouble();
            map["humidity"]=obj["humidity"].toDouble();
            QJsonObject condition_h=obj["condition"].toObject();
            map["icon"]=condition_h["icon"].toString();
            h_forecast.append(map);
        }
        qDebug()<<"выведено часов:"<<hours2.size()-hours_counter;
        double min_day2=day2["mintemp_c"].toDouble();
        double max_day2=day2["maxtemp_c"].toDouble();
        cur_forecast["min2d"]=(min_day1<min_day2) ? min_day1 : min_day2;
        cur_forecast["max2d"]=(max_day1>max_day2) ? max_day1 : max_day2;

        emit h_weather_changed();
    }
    else
    {
        request_data();
        qDebug() << "Error in network weather_reply: " << reply->errorString();
    }
    reply->deleteLater();

}

void Weather::handleReply_days()
{
    std::unordered_map<QString,QString> icon_transfer=
    {
        {"clear sky","//cdn.weatherapi.com/weather/64x64/day/113.png"},

        {"few clouds","//cdn.weatherapi.com/weather/64x64/day/113.png"},
        {"scattered clouds","//cdn.weatherapi.com/weather/64x64/day/116.png"},
        {"broken clouds","//cdn.weatherapi.com/weather/64x64/day/116.png"},
        {"overcast clouds","//cdn.weatherapi.com/weather/64x64/day/116.png"},

        {"mist","//cdn.weatherapi.com/weather/64x64/day/143.png"},
        {"smoke","//cdn.weatherapi.com/weather/64x64/day/143.png"},
        {"haze","//cdn.weatherapi.com/weather/64x64/day/143.png"},
        {"sand/dust whirls","//cdn.weatherapi.com/weather/64x64/day/143.png"},
        {"fog","//cdn.weatherapi.com/weather/64x64/day/248.png"},
        {"sand","//cdn.weatherapi.com/weather/64x64/day/143.png"},
        {"dust","//cdn.weatherapi.com/weather/64x64/day/143.png"},
        {"volcanic ash","//cdn.weatherapi.com/weather/64x64/day/143.png"},
        {"squalls","//cdn.weatherapi.com/weather/64x64/day/386.png"},
        {"tornado","//cdn.weatherapi.com/weather/64x64/day/230.png"},

        {"light snow","//cdn.weatherapi.com/weather/64x64/day/323.png"},
        {"snow","//cdn.weatherapi.com/weather/64x64/day/338.png"},
        {"heavy snow","//cdn.weatherapi.com/weather/64x64/day/338.png"},
        {"sleet","//cdn.weatherapi.com/weather/64x64/day/266.png"},
        {"light shower sleet","//cdn.weatherapi.com/weather/64x64/day/284.png"},
        {"shower sleet","//cdn.weatherapi.com/weather/64x64/day/284.png"},
        {"light rain and snow","//cdn.weatherapi.com/weather/64x64/day/362.png"},
        {"rain and snow","//cdn.weatherapi.com/weather/64x64/day/365.png"},
        {"light shower snow","//cdn.weatherapi.com/weather/64x64/day/368.png"},
        {"shower snow","//cdn.weatherapi.com/weather/64x64/day/227.png"},
        {"heavy shower snow","//cdn.weatherapi.com/weather/64x64/day/338.png"},

        {"light rain","//cdn.weatherapi.com/weather/64x64/day/176.png"},
        {"moderate rain","//cdn.weatherapi.com/weather/64x64/day/176.png"},
        {"heavy intensity rain","//cdn.weatherapi.com/weather/64x64/day/314.png"},
        {"very heavy rain","//cdn.weatherapi.com/weather/64x64/day/308.png"},
        {"extreme rain","//cdn.weatherapi.com/weather/64x64/day/359.png"},
        {"freezing rain","//cdn.weatherapi.com/weather/64x64/day/314.png"},
        {"light intensity shower rain","//cdn.weatherapi.com/weather/64x64/day/359.png"},
        {"shower rain","//cdn.weatherapi.com/weather/64x64/day/359.png"},
        {"heavy intensity shower rain","//cdn.weatherapi.com/weather/64x64/day/359.png"},
        {"ragged shower rain","//cdn.weatherapi.com/weather/64x64/day/356.png"},

        {"light intensity drizzle","//cdn.weatherapi.com/weather/64x64/day/263.png"},
        {"drizzle","//cdn.weatherapi.com/weather/64x64/day/266.png"},
        {"heavy intensity drizzle","//cdn.weatherapi.com/weather/64x64/day/284.png"},
        {"light intensity drizzle rain","//cdn.weatherapi.com/weather/64x64/day/.png"},
        {"drizzle rain","//cdn.weatherapi.com/weather/64x64/day/293.png"},
        {"heavy intensity drizzle rain","//cdn.weatherapi.com/weather/64x64/day/296.png"},
        {"shower rain and drizzle","//cdn.weatherapi.com/weather/64x64/day/353.png"},
        {"heavy shower rain and drizzle","//cdn.weatherapi.com/weather/64x64/day/308.png"},
        {"shower drizzle","//cdn.weatherapi.com/weather/64x64/day/308.png"},

        {"thunderstorm with light rain","//cdn.weatherapi.com/weather/64x64/day/386.png"},
        {"thunderstorm with rain","//cdn.weatherapi.com/weather/64x64/day/386.png"},
        {"thunderstorm with heavy rain","//cdn.weatherapi.com/weather/64x64/day/389.png"},
        {"light thunderstorm","//cdn.weatherapi.com/weather/64x64/day/389.png"},
        {"thunderstorm","//cdn.weatherapi.com/weather/64x64/day/389.png"},
        {"heavy thunderstorm","//cdn.weatherapi.com/weather/64x64/day/389.png"},
        {"ragged thunderstorm","//cdn.weatherapi.com/weather/64x64/day/389.png"},
        {"thunderstorm with light drizzle","//cdn.weatherapi.com/weather/64x64/day/389.png"},
        {"thunderstorm with drizzle","//cdn.weatherapi.com/weather/64x64/day/389.png"},
        {"thunderstorm with heavy drizzle","//cdn.weatherapi.com/weather/64x64/day/389.png"},

    };

    QNetworkReply *reply = qobject_cast<QNetworkReply *>(sender());
    if (reply->error() == QNetworkReply::NoError)
    {
        const QByteArray response = reply->readAll();
        const QJsonDocument jsonDoc = QJsonDocument::fromJson(response);
        QJsonObject root = jsonDoc.object();
        QJsonArray list=root["list"].toArray();
        for(const QJsonValue &value:list)
        {
            QVariantMap map;
            QJsonObject obj=value.toObject();
            map["time"]=obj["dt"].toInt();

            QJsonObject temp=obj["temp"].toObject();
            map["min_temp"] = std::round(temp["min"].toDouble());
            map["max_temp"] = std::round(temp["max"].toDouble());

            QJsonArray weatherarr=obj["weather"].toArray();
            QJsonObject weather=weatherarr.first().toObject();
            QString desc =weather["description"].toString();
            map["icon"]=icon_transfer[desc];
            d_forecast.append(map);
        }
        emit d_weather_changed();
    }
    else
    {
        request_data();
        qDebug() << "Error in network d_weather_reply: " << reply->errorString();
    }
    qDebug()<<"check";
    reply->deleteLater();
}
