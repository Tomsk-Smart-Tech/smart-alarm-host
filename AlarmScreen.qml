import QtQuick
import QtQuick.Controls
import QtMultimedia 6.0

Popup {
    id: alarmPopup
    modal: true
    dim: true
    focus: true
    closePolicy: Popup.NoAutoClose
    width:  1024
    height:  600

    background:         Rectangle {
        id: rectangle2
        anchors.fill: parent
        color: Qt.rgba(0/255, 0/255, 0/255, 0.8)

        FontLoader {
            id: castFont
            source: "ofont.ru_Nunito.ttf"
        }
        Column {
            id: column
            anchors.centerIn: parent
            spacing: 78
            Text {
                width: 216
                text: "Будильник"
                font.pixelSize: 50
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                color: "white"
                font.family: castFont.name
            }
            Column{
                id: column1
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 12
                Rectangle{
                    id: rectangle
                    width: 350
                    height: 70
                    color: "#545454"
                    radius: 25
                    border.width: 0
                    anchors.horizontalCenter: parent.horizontalCenter

                    Text {
                        id: _text1
                        color: "#ffffff"
                        text: qsTr("Отложить на 15 мин.")
                        anchors.fill: parent
                        font.pixelSize: 30
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.family: castFont.name
                    }
                }

                Rectangle{
                    id: rectangle1
                    width: 300
                    height: 70
                    color: "#944f1a"
                    radius: 25
                    anchors.horizontalCenter: parent.horizontalCenter

                    Text {
                        id: _text2
                        color: "#e4e4e4"
                        text: qsTr("Остановить")
                        anchors.fill: parent
                        font.pixelSize: 30
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.family: castFont.name
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            alarmSound.stop();
                            alarmPopup.close();
                        }
                    }
                }
            }
        }

        Column {
            id: column2
            anchors.top: parent.top
            anchors.topMargin: 40
            anchors.horizontalCenter: parent.horizontalCenter

            Text {
                id: _text
                color: "#aaaaaa"
                text: qsTr("12 Марта")
                font.pixelSize: 30
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: castFont.name
            }

            Text {
                id: _text3
                color: "#ffffff"
                text: qsTr("3:00")
                font.pixelSize: 60
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: castFont.name
            }
        }
    }

    MediaPlayer {
        id: alarmSound
        audioOutput: audioOutput
        source: "file:///home/nikita/Downloads/alarmtest.mp3"
        loops: MediaPlayer.Infinite
    }
    AudioOutput {
        id: audioOutput
        volume: 1.0
    }

    function show() {
        alarmPopup.open();
        alarmSound.play();
    }
    // MouseArea {
    //     anchors.fill: parent
    //     onClicked: {
    //         alarmSound.stop();
    //         alarmPopup.close();
    //     }
    // }
}
