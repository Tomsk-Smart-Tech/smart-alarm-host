import QtQuick 2.15
import QtQuick.Controls
import GlobalTime 1.0
import Qt5Compat.GraphicalEffects
//import QtQuick.VirtualKeyboard 2.15



Item {
    id: alarm
    property int x_pos: 0
    property int y_pos: 0
    property var alarms: valueOf
    property var popup: valueOf

    property var time_of_first_alarm: mqttclient.find_first_alarm((GlobalTime.currentDateTime.getDay()===0) ? 6: GlobalTime.currentDateTime.getDay()-1,GlobalTime.currentDateTime)

    property color backgroundColor: Qt.rgba(31 / 255, 31 / 255, 35 / 255, 1.0)
    property color widColor: Qt.rgba(61 / 255, 60 / 255, 65 / 255, 1)

    property color textColor: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
    property color textColorSecond: Qt.rgba(200 / 255, 200 / 255, 200 / 255, 1.0)

    property color separatorColor: Qt.rgba(90 / 255, 90 / 255, 90 / 255, 1.0)

    property color choiceColor: Qt.rgba(150 / 255, 150 / 255, 150 / 255, 1.0)

    property color widColorAlphaFirst: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.6)
    property color widColorAlphaSecond: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 0.22)

    property color switchColor: Qt.rgba(245/ 255, 178/ 255, 12/ 255, 1)

    property color textColorSett: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
    property color textColorSecondSett: Qt.rgba(200 / 255, 200 / 255, 200 / 255, 1.0)

    property Image background: valueOf

    property int blur: 20

    signal pressAlarms()
    signal unpressAlarms()
    AlarmScreen {
        id: alarmPopup
    }
    AlarmSettings_Popup{
        id: alarmDialog
        backgroundColor: alarm.backgroundColor
        widColor: alarm.widColor
        textColor: alarm.textColorSett
        textColorSecond: alarm.textColorSecondSett
        choiceColor: alarm.choiceColor
        switchColor: alarm.switchColor
    }

    function getTimeDiff(globaldate,first_alarm)
    {

        if (first_alarm==="") {
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
            spotify.pause_track();
            alarmPopup.show(mqttclient.alarms?.find(alarm => alarm["id"] === id)); // передавать аларм исходя из id
            mqttclient.alarm_start(id);


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
        color: alarm.widColorAlphaFirst
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
                    color: alarm.widColorAlphaSecond

                    FontLoader {
                        id: castFont
                        source: "ofont.ru_Nunito.ttf"
                    }

                    Text {
                        anchors.centerIn: parent
                        text: "Через "+ diff.h+"ч " +diff.m+"мин"
                        font.pointSize: 12
                        font.family: castFont.name
                        color: alarm.textColor
                    }
                }
                Rectangle{
                    width: 50
                    height: 50
                    color: alarm.switchColor
                    radius: 15
                    Text{
                        color: "white"
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
                color: "transparent"

                ListView {
                    id: listView
                    anchors.fill: parent
                    spacing: 10
                    clip: true
                    model: mqttclient.alarms
                    snapMode: ListView.SnapToItem
                    focus: true

                    delegate: Rectangle {
                        id: rec
                        width: 236 - 10* 2
                        height: 94
                        radius: 15
                        color: alarm.widColorAlphaSecond


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
                            color: alarm.textColor
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
                                color: list_switch.checked ? alarm.switchColor : alarm.choiceColor
                                Rectangle{
                                    x: list_switch.checked ? parent.width - width - 2 : 2
                                    y: 2
                                    width:26
                                    height:26
                                    radius:13
                                    color: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
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
                            color: alarm.textColor
                            elide: Text.ElideRight
                            width: parent.width - 10
                        }

                    }
                    // MouseArea {
                    //     anchors.fill: parent
                    //     // preventStealing: true
                    //     // hoverEnabled: true
                    //     onPressedChanged: {
                    //         if(pressed){
                    //             alarm.pressAlarms()
                    //         } else {
                    //             alarm.unpressAlarms()
                    //         }
                    //     }
                    // }
                    TapHandler {
                        // target: listView // По умолчанию родитель
                        acceptedButtons: Qt.AllButtons
                        onPressedChanged: {
                            if (pressed) {
                                alarm.pressAlarms()
                            } else {
                                alarm.unpressAlarms()
                            }
                        }
                        // TapHandler не должен мешать скроллингу или кликам внутри делегата
                    }


                }

            }
        }
    }
}










