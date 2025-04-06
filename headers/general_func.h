#ifndef GENERAL_FUNC_H
#define GENERAL_FUNC_H


#include <QString>
#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QDebug>
#include <QVariant>
#include <QVariantList>
#include <QVariantMap>
#include <QFile>
#include <QDir>
#include <QCoreApplication>

QString read_user_json(const QString key);
void write_user_json(const QString key, const QString newval);

#endif // GENERAL_FUNC_H
