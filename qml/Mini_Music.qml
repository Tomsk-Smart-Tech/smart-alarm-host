import QtQuick 2.0
import Qt5Compat.GraphicalEffects
import QtQuick.Controls

Item {
    id: miniMusic

    property int x_pos: 10
    property int y_pos: 10

    property bool currentlyPlaying: false
    signal playPauseClicked()
    signal tapMusic()


    property color textColor: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
    property color textColorSecond: Qt.rgba(200 / 255, 200 / 255, 200 / 255, 1.0)

    property color backProgress: Qt.rgba(80 / 255, 80 / 255, 80 / 255, 1)

    property color widColorAlphaFirst: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.6)

    property color addColor: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.6)

    property Image background: valueOf
    property int blur: 20

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
        color: miniMusic.widColorAlphaFirst
        clip: true
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
                    source: spotify.current["icon"]
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
            to: spotify.current["duration"] || 1
            value: spotify.current["progress"] || 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 46
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
        Rectangle{
            id: rectangle5
            width: 40
            height: 40
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 10
            anchors.topMargin: 10
            color: miniMusic.addColor
            radius: 11
            Image {
                width: 40
                height: 40
                anchors.verticalCenter: parent.verticalCenter
                // anchors.right: parent.right
                // anchors.top: parent.top
                // anchors.rightMargin: 10
                // anchors.topMargin: 10
                source:"resource_icon/music_icon/playlist.png"
                anchors.verticalCenterOffset: -1
                anchors.horizontalCenterOffset: 0
                anchors.horizontalCenter: parent.horizontalCenter
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        miniMusic.tapMusic()
                    }
                }
            }
        }


        Rectangle {
            id: container
            anchors.top: parent.top
            anchors.topMargin: 100
            width: 206
            height: 35
            anchors.horizontalCenter: parent.horizontalCenter
            clip: true
            color: "transparent"

            Text {
                id: _text
                anchors.verticalCenter: parent.verticalCenter
                x: 0
                text: spotify.current["name"]
                font.pixelSize: 23
                font.family: castFont.name
                color: Themes.textColor

                SequentialAnimation {
                    id: anim
                    loops: Animation.Infinite
                    running: _text.contentWidth > container.width
                    PropertyAnimation {
                        target: _text
                        property: "x"
                        from: container.width
                        to: 0
                        duration: container.width * 20
                    }
                    PauseAnimation {
                        duration: 3000
                    }
                    PropertyAnimation {
                        target: _text
                        property: "x"
                        from: 0
                        to: -_text.contentWidth
                        duration: (_text.contentWidth - container.width/container.width) * 20
                    }
                }
                onTextChanged: {
                    anim.stop();
                    _text.x = 0;
                    if (_text.contentWidth > container.width) {
                        anim.start();
                    }
                }
            }
        }
        Text {
            id: _text1
            width: 200
            text: spotify.current["artists"]
            elide: Text.ElideRight
            anchors.top: parent.top
            anchors.topMargin: 130//qsTr("pyrokinesis")
            font.pixelSize: 21
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            height: 24
            font.family: castFont.name
            color: miniMusic.textColorSecond
        }
        Rectangle{
            id: rectangle4
            width: 192
            height: 50
            color: miniMusic.addColor
            radius: 19
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
            Row{
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 10
                Rectangle {
                    id: rectangle2
                    width: 50
                    height: 50
                    color: "transparent"
                    Image{
                        anchors.fill: parent
                        source:"resource_icon/music_icon/rewind.png"
                    }
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
                        source:miniMusic.currentlyPlaying ? "resource_icon/music_icon/pause.png" : "resource_icon/music_icon/play.png"
                    }
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
                        source:"resource_icon/music_icon/next.png"
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
}
