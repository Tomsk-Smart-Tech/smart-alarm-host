import QtQuick 2.0

Item {
    id: music
    property int x_pos: 0
    property int y_pos: 0

    property color textColor: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
    property color textColorSecond: Qt.rgba(200 / 255, 200 / 255, 200 / 255, 1.0)

    property color backColor: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
    property color backColorSecond: Qt.rgba(200 / 255, 200 / 255, 200 / 255, 1.0)
    property color backColorThird: Qt.rgba(200 / 255, 200 / 255, 200 / 255, 0.1)


    property color widColor: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.6)
    property color widColorSecond: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 0.22)

    property color specialColor: Qt.rgba(70 / 255, 70 / 255, 70 / 255, 0.5)

    FontLoader {
        id: castFont
        source: "ofont.ru_Nunito.ttf"
    }

    Rectangle{
        id: rectangle
        width: 1024
        height: 600
        color: "transparent"

        Rectangle {
            id: rectangle1
            width: 1024/4
            height: 600 - 32
            color: music.widColor
            radius: 15
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 16
            anchors.topMargin: 16
        }
        Column{
            id: column
            width: 1024 - 1024/4*2 - 16* 4
            height: 600 - 16*2
            anchors.top: parent.top
            anchors.topMargin: 16
            spacing: 20
            anchors.horizontalCenter: parent.horizontalCenter
            Image {
                id: image
                width: 300
                height: 300
                source: "pyro.png"
                rotation: 0
                anchors.horizontalCenter: parent.horizontalCenter
                fillMode: Image.PreserveAspectCrop
            }


            Column{
                spacing: 0
                anchors.horizontalCenter: parent.horizontalCenter
                Text{
                    id: name
                    font.pixelSize: 32
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "mea maxima culpa"
                    font.family: castFont.name
                    color: music.textColor
                }
                Text{
                    id: autor
                    font.pixelSize: 24
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "pyrokinesis"
                    font.family: castFont.name
                    color: music.textColorSecond
                }
            }

            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                Rectangle {
                    id: rectangle4
                    width: 80
                    height: 80
                    color: "#00000000"
                    radius: 38
                    Text {
                        id: buttonText1
                        width: parent.width
                        height: parent.height
                        color: "#ffffff"
                        text: qsTr("◄◄")
                        font.letterSpacing: -10
                        font.pixelSize: 30
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.horizontalCenterOffset: -9
                        font.family: "Arial"
                        anchors.verticalCenterOffset: 0
                        anchors.centerIn: parent
                    }
                    SequentialAnimation {
                        id: playAnimation1
                        PropertyAnimation {
                            target: buttonText1
                            property: "scale"
                            duration: 100
                            to: 0.8
                        }

                        PropertyAnimation {
                            target: buttonText1
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
                    id: rectangle3
                    width: 80
                    height: 80
                    color: music.widColor
                    radius: 50
                    // color: "transparent"
                    Text {
                        id: buttonText
                        width: parent.width
                        height: parent.height
                        text: "▐ ▌"
                        font.pixelSize: 30
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.verticalCenterOffset: -3
                        anchors.centerIn: parent
                        color: "white"
                    }
                    SequentialAnimation {
                        id: playAnimation
                        PropertyAnimation {
                            target: buttonText
                            property: "scale"
                            duration: 100
                            to: 0.8
                        }

                        PropertyAnimation {
                            target: buttonText
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
                            playAnimation.start()
                        }
                    }
                }



                Rectangle {
                    id: rectangle5
                    width: 80
                    height: 80
                    color: "#00000000"
                    radius: 38
                    Text {
                        id: buttonText2
                        width: parent.width
                        height: parent.height
                        color: "#ffffff"
                        text: "►►"
                        font.letterSpacing: -10
                        font.pixelSize: 30
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        lineHeight: 1
                        font.bold: false
                        anchors.horizontalCenterOffset: 0
                        font.family: "Tahoma"
                        anchors.verticalCenterOffset: 0
                        anchors.centerIn: parent
                    }
                    SequentialAnimation {
                        id: playAnimation2
                        PropertyAnimation {
                            target: buttonText2
                            property: "scale"
                            duration: 100
                            to: 0.8
                        }

                        PropertyAnimation {
                            target: buttonText2
                            property: "scale"
                            duration: 100
                            to: 1
                        }
                    }
                    MouseArea {
                        id: playPauseButton2
                        anchors.fill: parent
                        anchors.topMargin: 0
                        onClicked: {
                            playAnimation2.start()
                            spotify.next_track()
                        }
                    }
                }
            }
        }

        Rectangle {
            id: rectangle2
            width: 1024/4
            height: 600 - 32
            color: music.widColor
            radius: 15
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 16
            anchors.topMargin: 16
        }
    }

}
