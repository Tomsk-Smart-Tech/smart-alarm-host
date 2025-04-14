#ifndef USER_H
#define USER_H

#include <QObject>

class User: public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool smooth_sound READ get_smooth_sound NOTIFY smooth_sound_changed)
    Q_PROPERTY(int event_remind READ get_event_remind NOTIFY event_remind_changed )
    Q_PROPERTY(QString time_event READ get_time_event WRITE set_time_event NOTIFY time_event_changed)
    Q_PROPERTY(int volume READ get_volume NOTIFY volume_changed)
    Q_PROPERTY(QString theme READ get_theme NOTIFY theme_changed)
public:
    User();
    Q_INVOKABLE bool get_smooth_sound(){return smooth_sound;};
    Q_INVOKABLE void set_smooth_sound(bool value);

    Q_INVOKABLE int get_event_remind(){return event_remind;}
    Q_INVOKABLE void set_event_remind(int value);

    Q_INVOKABLE QString get_time_event(){return time_event;}
    Q_INVOKABLE void set_time_event(QString value);

    Q_INVOKABLE QString get_theme(){return theme;}
    Q_INVOKABLE void set_theme(QString theme);

    Q_INVOKABLE void set_volume(int value);
    Q_INVOKABLE int get_volume(){return volume;}

signals:
    void smooth_sound_changed();
    void event_remind_changed();
    void time_event_changed();
    void theme_changed();
    void volume_changed();

private:
    bool smooth_sound;
    int event_remind;
    QString time_event;
    QString theme;
    int volume;

};

#endif // USER_H
