import QtQuick 2.0

Item {
    id:sensors
    property int x_pos: 10
    property int y_pos: 10
    Rectangle {
        x: sensors.x_pos
        y: sensors.y_pos
        id: gradientRectangle
        width: 236
        height: 236
        radius : 15
        color: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.6)
    }
}
