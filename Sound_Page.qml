import QtQuick 2.0
import QtQuick.Controls 2.15

Item {
    property color backgroundColor: Qt.rgba(240 / 255, 240 / 255, 240 / 255, 1.0)
    property color textColor: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 1.0)
    Rectangle{
        id:rec
        anchors.fill: parent
        color:backgroundColor
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
            color: textColor
        }
        Slider {
            anchors.horizontalCenter: parent.horizontalCenter
            y: 200
            from: 0
            value: 25
            width: 400
            to: 100
            stepSize: 10
            snapMode: Slider.SnapAlways
            onMoved: {output.text = "Value: " + value}

        }
        Text {
            id: output
            font.family: castFont.name
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize:30
            y: 220
        }
    }
}
