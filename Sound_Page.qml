import QtQuick 2.0

Item {
    Rectangle{
        id:rec
        anchors.fill: parent
        color:Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.6)
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
            color: "white"
        }
    }
}
