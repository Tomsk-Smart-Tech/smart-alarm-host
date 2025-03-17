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
            spacing: 4

            Text {
                color: "#ffffff"
                text: qsTr("Название")
                font.pixelSize: 32
                verticalAlignment: Text.AlignVCenter
                font.family: castFont.name
            }
            Rectangle {
                width: parent.width
                height: 60
                color: "#555555"
                radius: 10
                Text {
                    color: "#ffffff"
                    text: qsTr("Хуева хуйня")
                    anchors.fill: parent
                    anchors.leftMargin: 12
                    font.pixelSize: 32
                    verticalAlignment: Text.AlignVCenter
                    font.family: castFont.name
                }
            }

            Text {
                color: "#ffffff"
                text: qsTr("Время")
                font.pixelSize: 32
                verticalAlignment: Text.AlignVCenter
                font.family: castFont.name
            }
            Rectangle{
                width: parent.width
                height: 75
                color: "#555555"
                radius: 15
                anchors.horizontalCenter: parent.horizontalCenter
                Row {
                    id: row
                    height: 85
                    anchors.horizontalCenter: parent.horizontalCenter
                    Tumbler {
                        id: hoursTumbler
                        model: 24
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
                font.pixelSize: 32
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
                                    playAnimation.start()
                                }
                            }
                        }
                    }
                }
            }
        }

        Rectangle {
            id: rectangle
            width: 150
            height: 50
            color: "#67b145"
            radius: 15
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.rightMargin: 10
            anchors.bottomMargin: 10

            SequentialAnimation{
                id: playAnimation1
                PropertyAnimation {
                    target: rectangle
                    property: "scale"
                    duration: 100
                    to: 0.8
                }
                PropertyAnimation {
                    target: rectangle
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
            width: 150
            height: 50
            color: "#b33b3b"
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
                    playAnimation2.start()
                }
            }
        }
    }
}
