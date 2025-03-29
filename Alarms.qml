import QtQuick 2.0
import QtQuick.Controls
import GlobalTime 1.0
//import QtQuick.VirtualKeyboard 2.15



Item {
    id: alarm
    property int x_pos: 0
    property int y_pos: 0
    property var alarms: valueOf
    property var popup: valueOf

    property var time_of_first_alarm: mqttclient.find_first_alarm((GlobalTime.currentDateTime.getDay()===0) ? 6: GlobalTime.currentDateTime.getDay()-1,GlobalTime.currentDateTime)

    AlarmScreen {
        id: alarmPopup
    }
    AlarmSettings_Popup{
        id: alarmDialog
    }

    function getTimeDiff(globaldate,first_alarm)
    {

        if (first_alarm=="") {
            return { h: '-', m: '-' };
        }

        var cur_hours = globaldate.getHours();
        var cur_minutes = globaldate.getMinutes();
        var cur_seconds = globaldate.getSeconds();

        var alarmParts = first_alarm.split(":");
        var alarmHours = parseInt(alarmParts[0],10);
        var alarmMinutes = parseInt(alarmParts[1],10);
        var alarmSeconds = 0;
        var id = parseInt(alarmParts[2],10);

        var cur_total_seconds=cur_hours*3600+cur_minutes*60+cur_seconds;
        var alarm_total_seconds=alarmHours*3600+alarmMinutes*60+alarmSeconds;

        var difference;
        if (alarm_total_seconds > cur_total_seconds)
        {
            difference = alarm_total_seconds - cur_total_seconds;
        }
        else
        {
            difference = (24 * 3600 )- (cur_total_seconds-alarm_total_seconds);
        }

        var rhours = Math.floor(difference / 3600);
        var remainingseconds=difference%3600;
        var rminutes = Math.floor(remainingseconds / 60);
        if(difference<=1)
        {

            alarmPopup.show(mqttclient.alarms?.find(alarm => alarm["id"] === id)) // передавать аларм исходя из id
            mqttclient.alarm_start(id)

        }
        return { h: rhours, m: rminutes };
    }



    property var diff: getTimeDiff(
        GlobalTime.currentDateTime,
        time_of_first_alarm
        //mqttclient.alarms?.find(alarm => alarm["isEnabled"] === true )//&& alarm["repeatDays"][((GlobalTime.currentDateTime.getDay()===0) ? 6: GlobalTime.currentDateTime.getDay()-1)]===true
    )





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
            Row{
                height: 50
                spacing: 10
                width: parent.width
                Rectangle {
                    id: header
                    width: 157
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
                        font.pointSize: 12
                        font.family: castFont.name
                        color: "white"
                    }
                }
                Rectangle{
                    width: 50
                    height: 50
                    color: "#b5d96a27"
                    radius: 15
                    Text{
                        color: "#ffffff"
                        text: "+"
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pointSize: 34
                        font.family: castFont.name
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            alarmDialog.add_show()
                        }
                    }
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
                        id: rec
                        width: 236 - 10* 2
                        height: 94
                        radius: 15
                        color: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 0.22)

                        FontLoader {
                            id: castFont1
                            source: "ofont.ru_Nunito.ttf"
                        }
                        Text {
                            id: text3
                            anchors.left: parent.left
                            anchors.top: parent.top
                            anchors.leftMargin: 10
                            text: modelData["time"]
                            font.pointSize: 30
                            font.family: castFont1.name
                            color: "white"
                        }
                        SequentialAnimation {
                            id: playAnimation
                            PropertyAnimation {
                                target: text3, text1, list_switch, rec
                                property: "scale"
                                duration: 50
                                to: 0.8
                            }
                            PropertyAnimation {
                                target:  text3, text1, list_switch, rec
                                property: "scale"
                                duration: 100
                                to: 1
                            }
                        }
                        MouseArea {
                            width: parent.width/2
                            height: parent.height
                            onClicked: {
                                alarmDialog.show(modelData)
                            }
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
                            id: text1
                            // x: 10
                            // y: 60
                            anchors.left: parent.left
                            anchors.bottom: parent.bottom
                            anchors.leftMargin: 10
                            text: modelData["label"]
                            font.pointSize: 16
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










