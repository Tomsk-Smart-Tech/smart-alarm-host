import QtQuick 2.0
import Qt5Compat.GraphicalEffects
import QtQuick.Controls

Item {
    id: miniMusic

    property int x_pos: 10
    property int y_pos: 10

    property bool currentlyPlaying: false
    signal playPauseClicked()

    property color textColor: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
    property color textColorSecond: Qt.rgba(200 / 255, 200 / 255, 200 / 255, 1.0)

    property color backColor: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
    property color backColorSecond: Qt.rgba(200 / 255, 200 / 255, 200 / 255, 1.0)
    property color backColorThird: Qt.rgba(200 / 255, 200 / 255, 200 / 255, 0.1)

    property color backProgress: Qt.rgba(80 / 255, 80 / 255, 80 / 255, 1)


    property color widColor: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.6)
    property color widColorSecond: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 0.22)

    property color specialColor: Qt.rgba(70 / 255, 70 / 255, 70 / 255, 0.5)

    FontLoader {
        id: castFont
        source: "ofont.ru_Nunito.ttf"
    }


    Rectangle {
        id: blurRect
        x: miniMusic.x_pos
        y: miniMusic.y_pos
        width: 236
        height: 236
        radius : 15
        color: miniMusic.widColor
        clip: true

        // MultiEffect {
        //     id: bl
        //     source: image
        //     anchors.fill: image
        //     maskEnabled: true
        //     maskSource: mask
        // }

        // Image {
        //     id: image
        //     source: "pyro.png"
        //     visible: false
        //     anchors.fill: parent
        //     Rectangle{
        //         anchors.fill: parent
        //         color: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.6)
        //     }
        // }

        // MultiEffect{
        //     source: bl
        //     anchors.fill: bl
        //     blurEnabled: true
        //     blur: 20
        // }


        // Item {
        //     id: mask
        //     anchors.fill: image; layer.enabled: true; visible: false
        //     Rectangle { anchors.fill: parent; radius: 15}
        // }


        Rectangle {
            id: rectangle
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 10
            anchors.topMargin: 10
            // Установите ширину
            height: 86 // Установите высоту
            width: 86
            color: "transparent"
            radius: 15
            clip: true // Это свойство обрезает содержимое по границам прямоугольника
            OpacityMask {
                id: roundedImageEffect
                anchors.fill: parent
                source: Image {
                    id: imageSource
                    width: roundedImageEffect.width
                    height: roundedImageEffect.height
                    source: spotify.current["icon"]//"pyro.png"
                    fillMode: Image.PreserveAspectCrop
                    visible: false
                }
                maskSource: Rectangle {
                    id: imageMaskShape
                    width: roundedImageEffect.width
                    height: roundedImageEffect.height
                    radius: 10
                    visible: false
                }
            }
        }
        ProgressBar {
            id: progressBar
            width: 190
            height: 8
            to: 100
            value: 34
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 49
            anchors.horizontalCenter: parent.horizontalCenter
            background: Rectangle {
                implicitWidth: 300
                implicitHeight: 10
                color: miniMusic.backProgress
                radius: 5
            }

            contentItem: Item {
                implicitWidth: 300
                implicitHeight: 10
                Rectangle {
                    width: progressBar.visualPosition * parent.width
                    height: parent.height
                    radius: 5
                    color: miniMusic.textColor
                }
            }
        }
        Image {
            width: 40
            height: 40
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 10
            anchors.topMargin: 10
            source:"music_icon/playlist.png"
        }
        // Image{
        //     width: 45
        //     height: 45
        //     anchors.right: parent.right
        //     anchors.top: parent.top
        //     anchors.rightMargin: 10
        //     anchors.topMargin: 10
        //     source: "music_icon/music.png"
        // }


        Text {
            id: _text
            text: spotify.current["name"]//qsTr("mea maxima culpa")
            anchors.top: parent.top
            anchors.topMargin: 100
            font.pixelSize: 23
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            font.family: castFont.name
            color: miniMusic.textColor
        }
        Text {
            id: _text1
            text: spotify.current["artists"]//qsTr("pyrokinesis")
            anchors.top: parent.top
            anchors.topMargin: 127
            font.pixelSize: 21
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            height: 24
            font.family: castFont.name
            color: miniMusic.textColorSecond
        }
        Row{
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            spacing: 17
            anchors.horizontalCenter: parent.horizontalCenter
            Rectangle {
                id: rectangle2
                width: 50
                height: 50
                color: "transparent"
                Image{
                    anchors.fill: parent
                    source:"music_icon/rewind.png"
                }
                // Text {
                //     id: buttonText1
                //     width: 49
                //     height: 32
                //     color: "#ffffff"
                //     text: qsTr("◄◄")
                //     anchors.verticalCenter: parent.verticalCenter
                //     font.letterSpacing: -10
                //     font.pixelSize: 26
                //     horizontalAlignment: Text.AlignHCenter
                //     verticalAlignment: Text.AlignVCenter
                //     anchors.horizontalCenter: parent.horizontalCenter
                //     font.family: castFont.name
                // }

                SequentialAnimation {
                    id: playAnimation1
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
                MouseArea {
                    id: playPauseButton1
                    anchors.fill: parent
                    onClicked: {
                        playAnimation1.start()
                        spotify.prev_track()
                    }
                }
            }
            Rectangle {
                id: rectangle1
                width: 50
                height: 50
                color: "transparent"
                Image{
                    anchors.fill: parent
                    source:miniMusic.currentlyPlaying ? "music_icon/pause.png" : "music_icon/play.png"
                }
                // Text {
                //     id: buttonText
                //     text: miniMusic.currentlyPlaying ? "▐ ▌" : "►"
                //     // text: "▐ ▌"
                //     anchors.verticalCenter: parent.verticalCenter
                //     font.letterSpacing: 0
                //     font.pixelSize: 30
                //     horizontalAlignment: Text.AlignHCenter
                //     verticalAlignment: Text.AlignVCenter
                //     anchors.horizontalCenterOffset: 5
                //     anchors.horizontalCenter: parent.horizontalCenter
                //     font.weight: Font.Normal
                //     font.wordSpacing: 0
                //     font.family: castFont.name
                //     color: "white"
                // }
                SequentialAnimation {
                    id: playAnimation
                    PropertyAnimation {
                        target: rectangle1
                        property: "scale"
                        duration: 100
                        to: 0.8
                    }

                    PropertyAnimation {
                        target: rectangle1
                        property: "scale"
                        duration: 100
                        to: 1
                    }
                }
                MouseArea {
                    id: playPauseButton
                    anchors.fill: parent
                    onClicked: {
                        spotify.change_track_status()
                        miniMusic.playPauseClicked()
                        playAnimation.start()
                    }
                }
            }
            Rectangle {
                id: rectangle3
                width: 50
                height: 50
                color: "transparent"
                Image{
                    anchors.fill: parent
                    source:"music_icon/next.png"
                }
                SequentialAnimation {
                    id: playAnimation2
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
                MouseArea {
                    id: playPauseButton2
                    anchors.fill: parent
                    onClicked: {
                        playAnimation2.start()
                        spotify.next_track()
                    }
                }
            }
        }

    }
}
