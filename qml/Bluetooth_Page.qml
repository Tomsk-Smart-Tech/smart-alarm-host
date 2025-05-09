import QtQuick 2.0

Item {
    property color backgroundColor: Qt.rgba(240 / 255, 240 / 255, 240 / 255, 1.0)
    property color textColor: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 1.0)
    property color widColorSecond: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
    property color choiceColor: Qt.rgba(100 / 255, 100 / 255, 100 / 255, 1.0)
    Rectangle{

        id:rec
        anchors.fill: parent
        color: backgroundColor
        FontLoader {
            id: castFont
            source: "ofont.ru_Nunito.ttf"
        }
        Text{

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            text:"Bluetooth"
            font.family: castFont.name
            font.pointSize:30
            color: textColor
        }
    }
}
