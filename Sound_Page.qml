import QtQuick 2.0
import QtQuick.Controls 2.15

Item {
    id: sound
    property color backgroundColor: Qt.rgba(240 / 255, 240 / 255, 240 / 255, 1.0)
    property color textColor: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 1.0)
    property color textColorSecond: Qt.rgba(200 / 255, 200 / 255, 200 / 255, 1.0)

    property color widColorSecond: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 0.22)

    property color choiceColor: Qt.rgba(100 / 255, 100 / 255, 100 / 255, 1.0)

    property alias controlWidth: control.width
    Rectangle{
        id:rec
        anchors.fill: parent
        color:backgroundColor
        FontLoader {
            id: castFont
            source: "ofont.ru_Nunito.ttf"
        }
        Text{
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            text:"Звук"
            font.family: castFont.name
            font.pointSize:30
            color: sound.textColor
        }

        Column {
            id: column
            anchors.fill: parent
            anchors.leftMargin: 20
            anchors.rightMargin: 20
            anchors.topMargin: 74
            anchors.bottomMargin: 20
            spacing: 15
            Text {
                text: qsTr("Настройки громкости")
                font.pixelSize: 24
                font.family: castFont.name
                color: sound.textColor
            }
            Rectangle{
                x: 0
                width: parent.width
                height: 95
                radius: 15
                color: sound.widColorSecond
                Column{
                    anchors.fill:parent
                    anchors.margins: 10
                    spacing: 10
                    Row {
                        id: row
                        spacing: 10
                        Text {
                            font.family: castFont.name
                            font.pointSize:18
                            text: "Текущий уровень громкости:"
                            color: sound.textColorSecond

                        }
                        Text {
                            id: output
                            width: 100
                            font.family: castFont.name
                            font.pointSize:18
                            color: sound.textColor
                        }
                    }
                    Slider {
                        id: control
                        from: 0
                        value: 0
                        width: parent.width
                        height: 30
                        to: 100
                        stepSize: 1
                        snapMode: Slider.SnapAlways
                        onMoved: {output.text = value + '%'}
                        // contentItem: Rectangle {
                        //     width: control.visualPosition * control.width
                        //     height: 2
                        //     radius: 2
                        //     color: "#FF5733"
                        // }
                    }
                }
            }
            Text {
                text: qsTr("Выбор мелодии")
                font.pixelSize: 24
                font.family: castFont.name
                color: sound.textColor
            }
            ComboBox {
                id: soundComboBox
                width: parent.width
                height: 40

                model: terminal.songs

                background: Rectangle {
                    color: sound.choiceColor
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
                        color: soundComboBox.highlightedIndex === index ? sound.choiceColor : sound.backgroundColor

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
                            terminal.set_song(modelData["songPath"])
                            soundComboBox.popup.close()
                        }
                    }
                }
            }
        }
    }
}
