import QtQuick 2.0

Item {
    id: bar
    property int x_pos: 0
    property int y_pos: 0
    Rectangle{
        x: bar.x_pos
        y: bar.y_pos
        width: 1024
        height: 50
        color: Qt.rgba(240 / 255, 240 / 255, 240 / 255, 1.0)
    }
}
