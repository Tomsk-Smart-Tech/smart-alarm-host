#include "user.h"
#include "general_func.h"

User::User()
{
    smooth_sound=(read_user_json("smooth_sound")=="true" ? true : false);
    event_remind=read_user_json("event_remind").toInt();
    time_event=read_user_json("time_event_create");
    theme=read_user_json("theme");
    qDebug()<<"time_event_create from start="<<time_event;
}

Q_INVOKABLE void User::set_smooth_sound(bool value)
{
    smooth_sound=value;
    emit smooth_sound_changed();
    QString str=smooth_sound==true ? "true" : "false";
    write_user_json("smooth_sound",str);
}


Q_INVOKABLE void User::set_event_remind(int value)
{
    qDebug()<<"event_remind = "<<value;
    event_remind=value;
    emit event_remind_changed();
    write_user_json("event_remind",QString::number(event_remind));
}

Q_INVOKABLE void User::set_time_event(QString value)
{
    time_event=value;
    emit time_event_changed();
    write_user_json("time_event_create",time_event);
}

Q_INVOKABLE void User::set_theme(QString value)
{
    theme=value;
    emit theme_changed();
    write_user_json("theme",theme);
}
