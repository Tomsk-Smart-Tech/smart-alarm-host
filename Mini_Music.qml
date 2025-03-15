import QtQuick 2.0

Item {
    id: miniEvents

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
        x: miniEvents.x_pos
        y: miniEvents.y_pos
        width: 236
        height: 236
        radius : 15
        color: miniEvents.widColor
        layer.enabled: true

        Rectangle {
            id: rectangle
            width: 86
            height: 86
            color: "#ffffff"
            radius: 15
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 10
            anchors.topMargin: 10
        }

        Text {
            id: _text
            x: 108
            y: 110
            text: qsTr("Text")
            font.pixelSize: 12
        }
    }
}
