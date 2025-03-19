#include "general_func.h"


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
