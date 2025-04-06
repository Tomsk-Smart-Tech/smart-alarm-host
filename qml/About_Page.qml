import QtQuick 2.0
import QtQuick.Window 2.15

Item {
    id: about
    property color backgroundColor: Qt.rgba(240 / 255, 240 / 255, 240 / 255, 1.0)
    property color textColor: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 1.0)
    property color textColorSecond: Qt.rgba(200/255, 200/255, 200/255, 1.0)
    property alias rowWidth: row.width

    Rectangle {
        id: rec
        anchors.fill: parent
        color: backgroundColor

        FontLoader {
            id: castFont
            source: "ofont.ru_Nunito.ttf"
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            text: "Об устройстве"
            font.family: castFont.name
            font.pointSize: 30
            color: about.textColor
        }

        Row {
            id: row
            width: 550
            anchors.top: parent.top
            anchors.topMargin: 80
            spacing: 100
            anchors.horizontalCenter: parent.horizontalCenter

            Image {
                id: image
                width: 256
                height: 256
                source: "Kumkwat.png"
                fillMode: Image.PreserveAspectFit
                SequentialAnimation {
                    id: playAnimation
                    PropertyAnimation {
                        target: image
                        property: "scale"
                        duration: 70
                        to: 0.9
                    }

                    PropertyAnimation {
                        target: image
                        property: "scale"
                        duration: 70
                        to: 1
                    }
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                       playAnimation.start()
                    }
                }
            }
            Rectangle{
                width: 185
                height: parent.height
                color: "transparent"
                Column {
                    id: column
                    width: 200
                    spacing: 10
                    anchors.centerIn: parent
                    Text {
                        id: _text
                        color: about.textColor
                        text: qsTr("KumkwatOS")
                        width: parent.width
                        font.pixelSize: 41
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.family: castFont.name
                    }

                    Text {
                        id: _text1
                        color: about.textColorSecond
                        text: qsTr("Ver: 1.0")
                        font.pixelSize: 20
                        width: parent.width
                        horizontalAlignment: Text.AlignHCenter
                        font.family: castFont.name
                    }
                }

            }


        }
    }
}
