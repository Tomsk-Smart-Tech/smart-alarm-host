#ifndef LINUXTERMINAL_H
#define LINUXTERMINAL_H

#include <QObject>
#include <QVariantList>
#include <QVariantMap>
#include <QProcess>
#include <QDebug>


class LinuxTerminal : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QVariantList nets READ get_nets NOTIFY nets_changed)

public:
    explicit LinuxTerminal(QObject *parent = nullptr);

    QVariantList get_nets() const {return m_nets;}

    Q_INVOKABLE void scanNets();

signals:
    void nets_changed();

private:
    QVariantList m_nets;
};

#endif // LINUXTERMINAL_H
