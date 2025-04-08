import QtQuick 2.0

Item {
    id: storage
    property color backgroundColor: Qt.rgba(240 / 255, 240 / 255, 240 / 255, 1.0)
    property color widColor: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 0.22)

    property color textColor: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 1.0)
    property color textColorSecond: Qt.rgba(200 / 255, 200 / 255, 200 / 255, 1.0)

    property color choiceColor: Qt.rgba(100 / 255, 100 / 255, 100 / 255, 1.0)
    Rectangle{
        id:rec
        anchors.fill: parent
        color:storage.backgroundColor
        FontLoader {
            id: castFont
            source: "ofont.ru_Nunito.ttf"
        }
        Text{
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            text:"Внутреннее хранилище"
            font.family: castFont.name
            font.pointSize:30
            color: storage.textColor
        }
    }
}
