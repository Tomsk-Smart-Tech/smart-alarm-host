import QtQuick 2.0
import QtQuick.Controls 2.15

Item {
    FontLoader {
        id: castFont
        source: "ofont.ru_Nunito.ttf"
    }
    width: 800
    height: 500
    id: _item

    Rectangle {
            id: rectangle1
            anchors.fill: parent
            color: Qt.rgba(70 / 255, 70 / 255, 70 / 255, 1.0)
            radius: 15
            Column {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 3

                Text {
                    color: "#ffffff"
                    text: qsTr("Название")
                    font.pixelSize: 28
                    verticalAlignment: Text.AlignVCenter
                    font.family: castFont.name
                }
                Rectangle {
                    width: parent.width
                    height: 44
                    color: "#555555"
                    radius: 10
                    Text {
                        color: "#ffffff"
                        text: alarm_name
                        anchors.fill: parent
                        anchors.leftMargin: 12
                        font.pixelSize: 28
                        verticalAlignment: Text.AlignVCenter
                        font.family: castFont.name
                    }
                }

                Text {
                    color: "#ffffff"
                    text: qsTr("Время")
                    font.pixelSize: 28
                    verticalAlignment: Text.AlignVCenter
                    font.family: castFont.name
                }
                Rectangle{
                    width: parent.width
                    height: 70
                    color: "#555555"
                    radius: 15
                    anchors.horizontalCenter: parent.horizontalCenter
                    clip: true
                    Row {
                        id: row
                        height: 70
                        anchors.horizontalCenter: parent.horizontalCenter
                        Tumbler {
                            id: hoursTumbler
                            model: 24
                            currentIndex:alarm_hours
                            width: 80
                            height: 75
                            visibleItemCount: 1
                            spacing: 5
                            delegate: Rectangle{
                                color:"transparent"
                                Text{
                                    text: modelData < 10 ? "0" + modelData : modelData
                                    color: "white"
                                    anchors.centerIn: parent
                                    font.pixelSize: 45
                                    font.family: castFont.name
                                    opacity: Math.max(0.3, 1.0 - Math.abs(Tumbler.displacement) * 0.5)
                                    Behavior on opacity {
                                        NumberAnimation { duration: 200 }
                                    }
                                }
                            }
                        }
                        Text {
                            height: 69
                            text: ":"
                            font.pixelSize: 45
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignTop
                            color: "white"
                            anchors.verticalCenter: parent.verticalCenter
                            font.family: castFont.name
                        }
                        Tumbler {
                            id: minutesTumbler
                            model: 60
                            width: 80
                            height: 75
                            currentIndex:alarm_min
                            visibleItemCount: 1
                            delegate: Rectangle{
                                color:"transparent"
                                Text{
                                    text: modelData < 10 ? "0" + modelData : modelData
                                    color: "white"
                                    anchors.centerIn: parent
                                    font.family: castFont.name
                                    font.pixelSize: 45
                                    opacity: Math.max(0.3, 1.0 - Math.abs(Tumbler.displacement) * 0.5)
                                    Behavior on opacity {
                                        NumberAnimation { duration: 200 }
                                    }
                                }
                            }
                        }
                    }
                }

                Text {
                    color: "#ffffff"
                    text: qsTr("Дни недели")
                    font.pixelSize: 28
                    verticalAlignment: Text.AlignVCenter
                    font.family: castFont.name
                }


                ListModel {
                    id: daysModel
                    ListElement { day: "Пн" }
                    ListElement { day: "Вт" }
                    ListElement { day: "Ср" }
                    ListElement { day: "Чт" }
                    ListElement { day: "Пт" }
                    ListElement { day: "Сб" }
                    ListElement { day: "Вс" }
                }
                Rectangle{
                    width: parent.width
                    height: 60
                    color: "#555555"
                    radius: 15
                    anchors.horizontalCenter: parent.horizontalCenter

                    Row {
                        anchors.fill: parent
                        anchors.margins: 7
                        spacing: 8
                        Repeater {
                            model: daysModel
                            Button {
                                id: dayButton
                                text: model.day
                                width: parent.width/7 - 7
                                height: parent.height
                                checkable: true
                                background: Rectangle {
                                    id: rec
                                    // color: dayButton.checked ? "#cf8a29" : "#444"
                                    color: dayButton.checked ? "#cf8a29" : "#444"
                                    radius: 10
                                }
                                SequentialAnimation{
                                    id: playAnimation
                                    PropertyAnimation {
                                        target: dayButton
                                        property: "scale"
                                        duration: 100
                                        to: 0.8
                                    }
                                    PropertyAnimation {
                                        target: dayButton
                                        property: "scale"
                                        duration: 100
                                        to: 1
                                    }
                                }
                                contentItem: Text {
                                    anchors.fill: parent
                                    text: parent.text
                                    font.pixelSize: 30
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    color: "white"
                                    font.family: castFont.name
                                }
                                MouseArea {
                                    id: playPauseButton2
                                    anchors.fill: parent
                                    onClicked: {
                                        playAnimation.start();
                                        dayButton.checked = !dayButton.checked; // Правильное изменение состояния
                                    }
                                }
                            }
                        }
                    }
                }

                Text {
                    color: "#ffffff"
                    text: qsTr("Мелодия")
                    font.pixelSize: 28
                    verticalAlignment: Text.AlignVCenter
                    font.family: castFont.name
                }
                Row{
                    id: row1
                    spacing: 20
                    ComboBox {
                        id: soundComboBox
                        width: 650
                        height: 40

                        model: terminal.songs


                        background: Rectangle {
                            color: alarmDialog.choiceColor
                            radius: 10
                        }

                        indicator: Rectangle {
                            width: 40
                            height: 40
                            radius: 10
                            color: "#e5e5e5"
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter

                            Text {
                                anchors.centerIn: parent
                                text: "▼"
                                color: Qt.rgba(100 / 255, 100 / 255, 100 / 255, 1.0)
                                font.family: castFont.name
                                font.pixelSize: 24
                            }
                        }

                        contentItem: Text {
                            text: soundComboBox.currentText
                            anchors.left: parent.left
                            anchors.leftMargin: 8
                            color: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
                            font.pixelSize: 24
                            verticalAlignment: Text.AlignVCenter
                            font.family: castFont.name
                        }

                        delegate: Item {
                            width: soundComboBox.width
                            height: 40

                            Rectangle {
                                width: parent.width
                                height: 40
                                color: soundComboBox.highlightedIndex === index ? alarmDialog.choiceColor : alarmDialog.backgroundColor

                                Text {
                                    // anchors.centerIn: parent
                                    anchors.fill: parent
                                    anchors.leftMargin: 8
                                    text: modelData["songName"]
                                    color: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
                                    font.pixelSize: 24
                                    font.family: castFont.name
                                }
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    soundComboBox.currentIndex = index
                                    console.log(modelData["songPath"])
                                    //terminal.set_song(modelData["songPath"])
                                    soundComboBox.popup.close()
                                }
                            }
                        }
                    }
                    Button{
                        id: melodyButoon
                        width: 110
                        height: 40
                        checked: false
                        anchors.verticalCenter: parent.verticalCenter
                        background: Rectangle{
                            radius: 25
                            color: "#555555"
                            Text{
                                color: "#ffffff"
                                anchors.fill: parent
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.pointSize: 14
                                text: melodyButoon.checked ? "►" : "▐ ▌"
                            }
                        }
                        SequentialAnimation{
                            id: playAnimation4
                            PropertyAnimation {
                                target: dayButton
                                property: "scale"
                                duration: 100
                                to: 0.8
                            }
                            PropertyAnimation {
                                target: dayButton
                                property: "scale"
                                duration: 100
                                to: 1
                            }
                        }
                        MouseArea {
                            id: playPauseButton1
                            anchors.fill: parent
                            onClicked: {
                                playAnimation4.start();
                                melodyButoon.checked = !melodyButoon.checked;
                            }
                        }
                    }
                }


                Row{
                    width: 373
                    spacing: 8
                    Text {
                        color: "#ffffff"
                        text: qsTr("Удалить после проигрывания")
                        font.pixelSize: 28
                        verticalAlignment: Text.AlignVCenter
                        font.family: castFont.name
                    }
                    Switch {
                        id: list_switch
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
                        onCheckedChanged: {

                        }
                    }
                }
            }

            Rectangle {
                id: rectangle6
                width: 150
                height: 40
                color: "#67b145"
                radius: 15
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.rightMargin: 10
                anchors.bottomMargin: 10

                SequentialAnimation{
                    id: playAnimation1
                    PropertyAnimation {
                        target: rectangle6
                        property: "scale"
                        duration: 100
                        to: 0.8
                    }
                    PropertyAnimation {
                        target: rectangle6
                        property: "scale"
                        duration: 100
                        to: 1
                    }
                }

                Text {
                    id: _text
                    color: "#ffffff"
                    text: qsTr("Сохранить")
                    anchors.fill: parent
                    anchors.topMargin: 0
                    anchors.bottomMargin: 4
                    font.pixelSize: 27
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.family: castFont.name
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        playAnimation1.start()
                    }
                }
            }

            Rectangle {
                id: rectangle2
                width: 145
                height: 40
                color: "#767676"
                radius: 15
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.rightMargin: 170
                anchors.bottomMargin: 10
                SequentialAnimation{
                    id: playAnimation2
                    PropertyAnimation {
                        target: rectangle2
                        property: "scale"
                        duration: 100
                        to: 0.8
                    }
                    PropertyAnimation {
                        target: rectangle2
                        property: "scale"
                        duration: 100
                        to: 1
                    }
                }
                Text {
                    id: _text1
                    color: "#ffffff"
                    text: qsTr("Отменить")
                    anchors.fill: parent
                    anchors.topMargin: 0
                    anchors.bottomMargin: 4
                    font.pixelSize: 27
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.family: castFont.name
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        playAnimation2.start()
                    }
                }
            }

            Rectangle {
                id: rectangle3
                width: 145
                height: 40
                color: "#b33b3b"
                radius: 15
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.leftMargin: 10
                anchors.bottomMargin: 10
                SequentialAnimation {
                    id: playAnimation3
                    PropertyAnimation {
                        target: rectangle3
                        property: "scale"
                        duration: 100
                        to: 0.8
                    }

                    PropertyAnimation {
                        target: rectangle3
                        property: "scale"
                        duration: 100
                        to: 1
                    }
                }

                Text {
                    id: _text2
                    color: "#ffffff"
                    text: qsTr("Удалить")
                    anchors.fill: parent
                    anchors.topMargin: 0
                    anchors.bottomMargin: 4
                    font.pixelSize: 27
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.family: castFont.name
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        playAnimation3.start()
                    }
                }
            }
        }
}
