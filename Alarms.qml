import QtQuick 2.0
import QtQuick.Controls
import GlobalTime 1.0




Item {
    id: alarm
    property int x_pos: 0
    property int y_pos: 0
    property var alarms: valueOf

    AlarmScreen {
        id: alarmPopup
    }

    function getTimeDiff(globaldate,first_alarm)
    {
        if (!first_alarm) {
            return { h: '-', m: '-' };  // Возвращаем 0, если нет времени для будильника
        }
        var hours = globaldate.getHours();
        var minutes = globaldate.getMinutes();

        var alarmParts = first_alarm.time.split(":");
        var alarmHours = parseInt(alarmParts[0],10);
        var alarmMinutes = parseInt(alarmParts[1],10);

        var globalTotalMinutes = hours * 60 + minutes;
        var alarmTotalMinutes = alarmHours * 60 + alarmMinutes;

        var difference;
        if (alarmTotalMinutes > globalTotalMinutes)
        {
            difference = alarmTotalMinutes - globalTotalMinutes;
        }
        else
        {
            difference = (24 * 60 )- (globalTotalMinutes-alarmTotalMinutes);
        }

        var rhours = Math.floor(difference / 60);
        var rminutes = difference % 60;
        if(rhours==24 && rminutes==0)
        {
            mqttclient.alarm_start(first_alarm.id)
            alarmPopup.show()

        }
        return { h: rhours, m: rminutes };
    }



    property var diff: getTimeDiff(
        GlobalTime.currentDateTime,
        mqttclient.alarms?.find(alarm => alarm["isEnabled"] === true)
    )

    // property var diff:getTimeDiff(GlobalTime.currentDateTime,mqttclient.alarms?.[0]?.["time"])



    Rectangle {
        id: rec2
        x: alarm.x_pos
        y: alarm.y_pos
        width: 236
        height: 488
        radius: 15
        color: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.6)
        Column {
            anchors.fill: parent
            anchors.margins: 10
            spacing: 10

            Rectangle {
                id: header
                width: parent.width
                height: 50
                radius: 15
                color: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 0.22)

                FontLoader {
                    id: castFont
                    source: "ofont.ru_Nunito.ttf"
                }

                Text {
                    anchors.centerIn: parent
                    text: "Через "+ diff.h+"ч " +diff.m+"мин"
                    font.pointSize: 14
                    font.family: castFont.name
                    color: "white"
                }
            }

            Rectangle{
                id: rec_page
                width: 236 - 10* 2
                height: parent.height - 60
                visible: true
                color: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 0.0)
                ListView {
                    id: listView
                    anchors.fill: parent
                    spacing: 10
                    clip: true
                    model: mqttclient.alarms
                    snapMode: ListView.SnapToItem
                    delegate: Rectangle {
                        id:rect
                        width: 236 - 10* 2
                        height: 94
                        radius: 15
                        color: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 0.22)

                        FontLoader {
                            id: castFont1
                            source: "ofont.ru_Nunito.ttf"
                        }
                        Text {
                            anchors.left: parent.left
                            anchors.top: parent.top
                            anchors.leftMargin: 10
                            text: modelData["time"]
                            font.pointSize: 30
                            font.family: castFont1.name
                            color: "white"
                        }
                        Switch {
                            id: list_switch
                            x: 140
                            y: 20
                            checked: modelData["isEnabled"]
                            indicator : Rectangle{
                                anchors.centerIn: parent
                                implicitWidth: 50
                                implicitHeight: 30
                                radius:15
                                color: list_switch.checked ? Qt.rgba(180 / 255, 180 / 255, 180 / 255, 1) : Qt.rgba(50 / 255, 50 / 255, 50 / 255, 1)
                                Rectangle{
                                    x: list_switch.checked ? parent.width - width - 2 : 2
                                    y: 2
                                    width:26
                                    height:26
                                    radius:13
                                    color: list_switch.down ? Qt.rgba(255 / 255, 255 / 255, 255 / 255, 0.5) : Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1)
                                }
                            }

                            onCheckedChanged: {
                                mqttclient.update_alarm_status(modelData["id"], list_switch.checked)
                            }


                        }
                        Text {
                            // x: 10
                            // y: 60
                            anchors.left: parent.left
                            anchors.bottom: parent.bottom
                            anchors.leftMargin: 10
                            text: modelData["label"]
                            font.pointSize: 18
                            font.family: castFont1.name
                            color: "white"
                            elide: Text.ElideRight
                            width: parent.width - 10
                        }

                    }


                }
            }
        }
    }
}









