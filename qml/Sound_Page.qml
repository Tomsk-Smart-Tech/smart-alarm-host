import QtQuick 2.0
import QtQuick.Controls 2.15
import QtMultimedia 6.0

Item {
    id: sound
    property color backgroundColor: Qt.rgba(240 / 255, 240 / 255, 240 / 255, 1.0)
    property color widColor: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 0.22)

    property color textColor: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 1.0)
    property color textColorSecond: Qt.rgba(200 / 255, 200 / 255, 200 / 255, 1.0)

    property color choiceColor: Qt.rgba(100 / 255, 100 / 255, 100 / 255, 1.0)

    property alias controlWidth: control.width

    function findSongIndex(songPath) {
        for (var i = 0; i < terminal.songs.length; i++) {
            if (terminal.songs[i]["songPath"] === songPath) {
                return i;
            }
        }
    }



    Rectangle{
        id:rec
        anchors.fill: parent
        color:sound.backgroundColor
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
                color: sound.widColor
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
                            text:spotify.get_volume()+"%"
                        }
                    }
                    Slider {
                        id: control
                        from: 0
                        value: spotify.volume
                        width: parent.width
                        height: 30
                        to: 100
                        stepSize: 1
                        snapMode: Slider.SnapAlways

                        onMoved:
                        {
                            output.text = value + '%'
                            spotify.set_volume(value)
                        }
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
            Row{
                width: parent.width
                height: 40
                spacing: 20
                ComboBox {
                    id: soundComboBox
                    width: parent.width - 80 - 20
                    height: 40
                    textRole: "songName"
                    model: terminal.songs
                    currentIndex:findSongIndex(terminal.cur_song);

                    background: Rectangle {
                        color: sound.widColor
                        radius: 10
                    }

                    indicator: Rectangle {
                        width: 40
                        height: 40
                        radius: 10
                        color: sound.choiceColor
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        Image{
                            anchors.fill: parent
                            source: "resource_icon/special/arrow_down"
                        }
                        // Text {
                        //     anchors.centerIn: parent
                        //     text: "▼"
                        //     color: Qt.rgba(100 / 255, 100 / 255, 100 / 255, 1.0)
                        //     font.family: castFont.name
                        //     font.pixelSize: 24
                        // }
                    }

                    contentItem: Text {
                        text: soundComboBox.currentText
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                        color: sound.textColor
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
                            color: soundComboBox.highlightedIndex === index ? sound.widColor : sound.backgroundColor

                            Text {
                                // anchors.centerIn: parent
                                anchors.fill: parent
                                anchors.leftMargin: 8
                                text: modelData["songName"]
                                color: sound.textColor
                                font.pixelSize: 24
                                font.family: castFont.name
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                soundComboBox.currentIndex = index
                                //console.log(modelData["songPath"])
                                terminal.set_song(modelData["songPath"])
                                soundComboBox.popup.close()
                            }
                        }
                    }
                }
                Button{
                    id: melodyButoon
                    width: 80
                    height: 40
                    checked: false
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    background: Rectangle{
                        radius: 10
                        color: sound.widColor
                        Image{
                            width: 40
                            height: 40
                            anchors.centerIn: parent
                            source:melodyButoon.checked ? "resource_icon/music_icon/pause.png" : "resource_icon/music_icon/play.png"
                        }
                        // Text{
                        //     color: sound.textColor
                        //     anchors.fill: parent
                        //     horizontalAlignment: Text.AlignHCenter
                        //     verticalAlignment: Text.AlignVCenter
                        //     font.pointSize: 14
                        //     text: melodyButoon.checked ? "▐ ▌" : "►"
                        //     font.family: castFont.name
                        // }
                    }
                    SequentialAnimation{
                        id: playAnimation4
                        PropertyAnimation {
                            target: melodyButoon
                            property: "scale"
                            duration: 100
                            to: 0.8
                        }
                        PropertyAnimation {
                            target: melodyButoon
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
                            if(melodyButoon.checked===true)
                            {
                                alarmSound.play()
                            }
                            else
                            {
                                alarmSound.stop()
                            }
                        }
                    }
                }
            }
        }
    }

    MediaPlayer {
        id: alarmSound
        audioOutput: audioOutput
        source: "file://"+terminal.cur_song
        loops: MediaPlayer.Infinite
    }
    AudioOutput {
        id: audioOutput
        volume: spotify.volume/100
    }

}
