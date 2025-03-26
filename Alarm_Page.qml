import QtQuick 2.0
import QtQuick.Controls 2.15

Item {
    id: page
    property color backgroundColor: Qt.rgba(50 / 255, 50 / 255, 50 / 255, 1.0)
    property color textColor: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)

    property color widColorSecond: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 0.22)
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
                        text: qsTr("Откладывать будильник на: ")
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
                        Text{
                            anchors.centerIn: parent
                            text: "▲"
                            font.pixelSize: 24
                            color: page.textColor
                        }

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
                        Text{
                            text: "▼"
                            anchors.centerIn: parent
                            font.pixelSize: 24
                            color: page.textColor
                        }
                        width: 50
                        height: 50

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
                    checked: false
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
                    // onCheckedChanged: {

                    // }
                }
            }
            Text {
                width: 327
                height: 31
                text: qsTr("Настройки календаря")
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
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
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

                        Tumbler {
                            id: daytumbler
                            width: 80
                            height: 64
                            anchors.verticalCenter: parent.verticalCenter
                            visibleItemCount: 1
                            spacing: 5
                            // currentIndex:mqttclient.alarm_delay
                            // onCurrentIndexChanged: {
                            //     var selectedMinute = currentIndex
                            //     mqttclient.set_alarm_delay(selectedMinute)

                            // }
                            model: 8
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

                    Row {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        Rectangle {
                            id: button3
                            width: 50
                            height: 50
                            color: "#00000000"
                            Text {
                                color: page.textColor
                                text: "\u25b2"
                                font.pixelSize: 24
                                anchors.centerIn: parent
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
                            Text {
                                color: page.textColor
                                text: "\u25bc"
                                font.pixelSize: 24
                                anchors.centerIn: parent
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
                        // onCurrentIndexChanged: {
                        //     alarmDialog.alarm_hours = currentIndex
                        // }
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
                        // onCurrentIndexChanged: {
                        //     alarm_min = currentIndex
                        // }
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
