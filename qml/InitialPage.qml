import QtQuick 2.0

Item{
    id:page
    property color backgroundColor: Qt.rgba(50 / 255, 50 / 255, 50 / 255, 1.0)
    property color textColor: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
    Rectangle{
        id:rec
        anchors.fill: parent
        color:page.backgroundColor
        FontLoader {
            id: castFont
            source: "ofont.ru_Nunito.ttf"
        }
        Text{
            anchors.centerIn: parent
            text:"Экран изменения настроек"
            font.family: castFont.name
            font.pointSize:30
            color: page.textColor
        }
    }
}
