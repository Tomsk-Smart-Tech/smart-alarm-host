import QtQuick 2.0
import QtQuick.Controls

Item {
    id: bar
    property color textColor: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
    property color textColorSecond: Qt.rgba(200 / 255, 200 / 255, 200 / 255, 1.0)

    property color backColor: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
    property color backColorSecond: Qt.rgba(200 / 255, 200 / 255, 200 / 255, 1.0)
    property color backColorThird: Qt.rgba(200 / 255, 200 / 255, 200 / 255, 0.1)

    property color barColor: Qt.rgba(30 / 255, 30 / 255, 30 / 255, 0.4)


    property color widColor: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.6)
    property color widColorSecond: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 0.22)

    property color specialColor: Qt.rgba(70 / 255, 70 / 255, 70 / 255, 0.5)

    property int x_pos: 0
    property int y_pos: 0
    Rectangle{
        id: rectangle
        x: bar.x_pos
        y: bar.y_pos
        width: 1024
        height: 40
        color: bar.barColor
        Rectangle{
            id: connection
            width: 20
            height: 20
            radius: 10
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.rightMargin: 10
            anchors.bottomMargin: 10
            border.color: bar.textColorSecond
            color : Qt.rgba(154/255, 247/255, 134/255, 1.0)
            Connections {
                target: mqttclient
                function onConnectionStatusChanged() {
                    if (mqttclient.connectionStatus=== 1) {
                        console.log("city ->", weatherr.city);
                        connection.color = Qt.rgba(154/255, 247/255, 134/255, 1.0);
                        weatherr.request_position()
                    }
                }
            }
        }
    }
}
