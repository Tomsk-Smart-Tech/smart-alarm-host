import QtQuick 2.0
import QtQuick.Controls 2.15

Item {
    id: page
    property color backgroundColor: Qt.rgba(31 / 255, 31 / 255, 35 / 255, 1.0)
    property color textColor: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
    property color widColorSecond: Qt.rgba(61 / 255, 60 / 255, 65 / 255, 1)

    // property var delay:mqttclient.alarm_delay
    property var smooth_sound:user.smooth_sound

    property var time_event_min
    property var time_event_hours



    function updateTimeString() {
        // Без создания Date объекта
        var hh = time_event_hours < 10 ? "0" + time_event_hours : time_event_hours;
        var mm = time_event_min < 10 ? "0" + time_event_min : time_event_min;
        user.set_time_event(hh + ":" + mm);
    }

    Rectangle{
        id:rec
        anchors.fill: parent
        color:page.backgroundColor
        FontLoader {
            id: castFont
            source: "ofont.ru_Nunito.ttf"
        }
        Text{
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            text:"Спец. настройки"
            font.family: castFont.name
            font.pointSize:30
            color: page.textColor
        }
        Column{
            id: column
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 20
            anchors.rightMargin: 20
            anchors.topMargin: 74
            anchors.bottomMargin: 20
            spacing: 10
            Text {
                width: 327
                height: 31
                text: qsTr("Настройки будильников")
                font.pixelSize: 24
                font.family: castFont.name
                color: page.textColor
            }
            Rectangle{
                id: rectangle
                width: parent.width
                height: 60
                color: page.widColorSecond
                anchors.margins: 10
                anchors.horizontalCenter: parent.horizontalCenter
                radius: 15
                clip: true
                Row{
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    Text {
                        text: qsTr("Откладывать будильник на ")
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 24
                        font.family: castFont.name
                        color: page.textColor
                    }
                    Tumbler {
                        id: minutesTumbler
                        model: 61
                        width: 80
                        height: 64
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: 0
                        visibleItemCount: 1
                        spacing: 5
                        // Component.onCompleted: {
                        //     minutesTumbler.currentIndex = page.delay//mqttclient.alarm_delay
                        // }
                        currentIndex:mqttclient.get_alarm_delay()
                        onCurrentIndexChanged: {
                            var selectedMinute = currentIndex
                            mqttclient.set_alarm_delay(selectedMinute)
                        }
                        delegate: Rectangle{
                            color:"transparent"
                            Text{
                                text: modelData < 10 ? "0" + modelData : modelData
                                color: page.textColor
                                anchors.centerIn: parent
                                font.pixelSize: 38
                                font.family: castFont.name
                                opacity: Math.max(0.3, 1.0 - Math.abs(Tumbler.displacement) * 0.5)
                                Behavior on opacity {
                                    NumberAnimation { duration: 50 }
                                }
                            }
                        }

                    }
                    Text {
                        text: qsTr("минут")
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 24
                        font.family: castFont.name
                        color: page.textColor
                    }
                }

                Row{
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    Rectangle {
                        id: button
                        color: "transparent"
                        Image{
                            anchors.fill: parent
                            source: "resource_icon/special/arrow_up_white"
                        }
                        // Text{
                        //     anchors.centerIn: parent
                        //     text: "▲"
                        //     font.pixelSize: 24
                        //     color: page.textColor
                        // }

                        SequentialAnimation{
                            id: playAnimation
                            PropertyAnimation {
                                target: button
                                property: "scale"
                                duration: 100
                                to: 0.8
                            }
                            PropertyAnimation {
                                target: button
                                property: "scale"
                                duration: 100
                                to: 1
                            }
                        }

                        width: 50
                        height: 50
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                playAnimation.start()
                                if (minutesTumbler.currentIndex < minutesTumbler.model - 1)
                                    minutesTumbler.currentIndex++
                            }
                        }

                    }
                    Rectangle {
                        id: button1
                        color: "transparent"
                        // Text{
                        //     text: "▼"
                        //     anchors.centerIn: parent
                        //     font.pixelSize: 24
                        //     color: page.textColor
                        // }
                        width: 50
                        height: 50
                        Image{
                            anchors.fill: parent
                            source: "resource_icon/special/arrow_down_white"
                        }

                        SequentialAnimation{
                            id: playAnimation1
                            PropertyAnimation {
                                target: button1
                                property: "scale"
                                duration: 100
                                to: 0.8
                            }
                            PropertyAnimation {
                                target: button1
                                property: "scale"
                                duration: 100
                                to: 1
                            }
                        }

                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                playAnimation1.start()
                                if (minutesTumbler.currentIndex > 0)
                                    minutesTumbler.currentIndex--
                            }
                        }
                    }
                }
            }
            Rectangle{
                id: rectangle1
                width: parent.width
                height: 60
                color: page.widColorSecond
                anchors.margins: 10
                anchors.horizontalCenter: parent.horizontalCenter
                radius: 15
                clip: true
                Text {
                    text: qsTr("Плавное увеличение громкости")
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    font.pixelSize: 24
                    font.family: castFont.name
                    color: page.textColor
                }
                Switch {
                    id: list_switch
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    checked: page.smooth_sound
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
                    Binding {
                        target: list_switch
                        property: "checked"
                        value: page.smooth_sound
                        when: !list_switch.pressed
                    }

                    onToggled: {
                        user.set_smooth_sound(checked)
                    }
                }
            }
            Text {
                width: 327
                height: 31
                text: qsTr("Настройки напоминаний")
                font.pixelSize: 24
                font.family: castFont.name
                color: page.textColor
            }

            Rectangle {
                id: rectangle2
                width: parent.width
                height: 80
                color: page.widColorSecond
                radius: 15
                anchors.margins: 10
                clip: true
                anchors.horizontalCenter: parent.horizontalCenter
                Row{
                    height: 60
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.leftMargin: 10
                    anchors.rightMargin: 10
                    anchors.topMargin: 10
                    Row {
                        width: 464
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        spacing: 41
                        Text {
                            width: 287
                            height: 60
                            color: page.textColor
                            text: qsTr("За сколько дней напоминать о событиях")
                            anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: 24
                            verticalAlignment: Text.AlignVCenter
                            wrapMode: Text.WordWrap
                            font.family: castFont.name
                        }
                        Row{
                            Tumbler {
                                id: daytumbler
                                width: 80
                                height: 64
                                anchors.verticalCenter: parent.verticalCenter
                                visibleItemCount: 1
                                spacing: 5
                                model: 8
                                // Component.onCompleted: {
                                //     daytumbler.currentIndex = user.event_remind
                                // }
                                currentIndex:user.get_event_remind()
                                onCurrentIndexChanged: {
                                    var days = daytumbler.currentIndex
                                    user.set_event_remind(days)
                                }

                                delegate: Rectangle {
                                    color: "#00000000"
                                    Text {
                                        opacity: Math.max(0.3, 1.0 - Math.abs(Tumbler.displacement) * 0.5)
                                        color: page.textColor
                                        text: modelData
                                        font.pixelSize: 38
                                        font.family: castFont.name
                                        Behavior {
                                            NumberAnimation {
                                                duration: 50
                                            }
                                        }
                                        anchors.centerIn: parent
                                    }
                                }

                                anchors.verticalCenterOffset: 0
                            }

                            Text {
                                color: page.textColor
                                text: qsTr("дней")
                                anchors.verticalCenter: parent.verticalCenter
                                font.pixelSize: 24
                                font.family: castFont.name
                            }
                        }


                    }

                    Row {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        Rectangle {
                            id: button3
                            width: 50
                            height: 50
                            color: "#00000000"
                            Image{
                                anchors.fill: parent
                                source: "resource_icon/special/arrow_up_white"
                            }

                            SequentialAnimation {
                                id: playAnimation3
                                PropertyAnimation {
                                    target: button3
                                    property: "scale"
                                    duration: 100
                                    to: 0.8
                                }

                                PropertyAnimation {
                                    target: button3
                                    property: "scale"
                                    duration: 100
                                    to: 1
                                }
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    playAnimation3.start()
                                    if (daytumbler.currentIndex < daytumbler.model - 1)
                                        daytumbler.currentIndex++
                                }
                            }
                        }

                        Rectangle {
                            id: button4
                            width: 50
                            height: 50
                            color: "#00000000"
                            Image{
                                anchors.fill: parent
                                source: "resource_icon/special/arrow_down_white"
                            }

                            SequentialAnimation {
                                id: playAnimation4
                                PropertyAnimation {
                                    target: button4
                                    property: "scale"
                                    duration: 100
                                    to: 0.8
                                }

                                PropertyAnimation {
                                    target: button4
                                    property: "scale"
                                    duration: 100
                                    to: 1
                                }
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    playAnimation4.start()
                                    if (daytumbler.currentIndex > 0)
                                        daytumbler.currentIndex--
                                }
                            }
                        }
                    }
                }
            }
            Rectangle{
                id: rectangle3
                width: parent.width
                height: 60
                color: page.widColorSecond
                radius: 15
                // во сколько напоминать о событии?
                Text {
                    width: 405
                    height: 40
                    color: page.textColor
                    text: qsTr("Во сколько напоминать о событии?")
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    font.pixelSize: 24
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.WordWrap
                    font.family: castFont.name
                }
                Row {
                    id: row
                    height: 61
                    anchors.right: parent.right
                    Tumbler {
                        id: hoursTumbler4
                        model: 24
                        width: 80
                        height: 60
                        visibleItemCount: 1
                        spacing: 5
                        currentIndex:user.get_time_event().substring(0,2)
                        onCurrentIndexChanged: {
                            if (time_event_hours !== currentIndex) {
                                time_event_hours = currentIndex;
                                updateTimeString();
                            }
                        }
                        delegate: Rectangle{
                            color:"transparent"
                            Text{
                                text: modelData < 10 ? "0" + modelData : modelData
                                color: "white"
                                anchors.centerIn: parent
                                font.pixelSize: 38
                                font.family: castFont.name
                                opacity: Math.max(0.3, 1.0 - Math.abs(Tumbler.displacement) * 0.5)
                                Behavior on opacity {
                                    NumberAnimation { duration: 200 }
                                }
                            }
                        }
                    }
                    Text {
                        height: 60
                        text: ":"
                        font.pixelSize: 45
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.verticalCenterOffset: -3
                        color: "white"
                        anchors.verticalCenter: parent.verticalCenter
                        font.family: castFont.name
                    }
                    Tumbler {
                        id: minutesTumbler4
                        model: 60
                        width: 80
                        height: 60
                        visibleItemCount: 1
                        currentIndex:user.get_time_event().substring(3,5)
                        onCurrentIndexChanged: {
                            if (time_event_min !== currentIndex) {
                                time_event_min = currentIndex;
                                updateTimeString();
                            }
                        }
                        delegate: Rectangle{
                            color:"transparent"
                            Text{
                                text: modelData < 10 ? "0" + modelData : modelData
                                color: "white"
                                anchors.centerIn: parent
                                font.family: castFont.name
                                font.pixelSize: 38
                                opacity: Math.max(0.3, 1.0 - Math.abs(Tumbler.displacement) * 0.5)
                                Behavior on opacity {
                                    NumberAnimation { duration: 200 }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
