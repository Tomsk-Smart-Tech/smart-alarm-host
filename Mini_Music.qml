import QtQuick 2.0
// import QtQuick.Effects

Item {
    id: miniMusic

    property int x_pos: 10
    property int y_pos: 10

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
            width: 86  // Установите ширину
            height: 86 // Установите высоту
            color: "transparent"
            radius: 15
            clip: true // Это свойство обрезает содержимое по границам прямоугольника
            Image {
                id: image
                source: "pyro.png"
                anchors.fill: parent
                fillMode: Image.PreserveAspectCrop // Это важно для правильного масштабирования
            }
        }


        Text {
            id: _text
            text: qsTr("mea maxima culpa")
            anchors.top: parent.top
            anchors.topMargin: 104
            font.pixelSize: 22
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            font.family: castFont.name
            color: miniMusic.textColor
        }


        Rectangle {
            id: rectangle1
            width: 65
            height: 65
            // color: miniMusic.widColorSecond
            radius: 38
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 86
            anchors.topMargin: 163
            color: "transparent"
            Text {
                id: buttonText
                height: 39
                text: "▐ ▌"
                font.pixelSize: 26
                anchors.verticalCenterOffset: -2
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
                    playAnimation.start()
                }
            }
        }

        Rectangle {
            id: rectangle2
            x: 96
            y: 173
            width: 65
            height: 65
            color: "#00000000"
            radius: 38
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 11
            anchors.topMargin: 163
            Text {
                id: buttonText1
                width: 49
                height: 32
                color: "#ffffff"
                text: qsTr("◄◄")
                font.letterSpacing: -10
                font.pixelSize: 26
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: "Arial"
                anchors.verticalCenterOffset: -2
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
                }
            }
        }

        Rectangle {
            id: rectangle3
            x: 10
            y: 153
            width: 65
            height: 65
            color: "#00000000"
            radius: 38
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 151
            anchors.topMargin: 163
            Text {
                id: buttonText2
                width: 47
                height: 35
                color: "#ffffff"
                text: "►►"
                font.letterSpacing: -10
                font.pixelSize: 26
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: "Tahoma"
                anchors.verticalCenterOffset: -4
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
                onClicked: {
                    playAnimation2.start()
                }
            }
        }
    }
}
