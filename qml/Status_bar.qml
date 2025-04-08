import QtQuick 2.0
import QtQuick.Controls

Item {
    id: bar
    property color textColor: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 1.0)
    property color textColorSecond: Qt.rgba(200 / 255, 200 / 255, 200 / 255, 1.0)

    property color widColorAlpha: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.6)


    property int x_pos: 0
    property int y_pos: 0
    Rectangle{
        id: rectangle
        x: bar.x_pos
        y: bar.y_pos
        width: 1024
        height: 40
        // color: bar.widColorAlpha
        color: "transparent"
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
            color : Qt.rgba(242/255, 73/255, 84/255, 1.0)
            Connections {
                target: mqttclient
                function onConnectionStatusChanged() {
                    if (mqttclient.connectionStatus=== 1) {
                        console.log("city ->", weatherr.city);
                        connection.color = Qt.rgba(154/255, 247/255, 134/255, 1.0);
                        weatherr.request_position()
                    } else {
                        connection.color = Qt.rgba(242/255, 73/255, 84/255, 1.0)
                    }
                }
            }
        }
    }
}
