import QtQuick 2.0

Item {
    id: calendar

    property color widgetBackgroundColor: Qt.rgba(0, 0, 0, 0.6)
    property color textColor: Qt.rgba(255/255, 255/255, 255/255, 1.0)
    property color textColorSecond: Qt.rgba(200/255, 200/255, 200/255, 1.0)

    FontLoader {
        id: castFont
        source: "ofont.ru_Nunito.ttf"
    }
    Rectangle {
        id: rec
        x: weather.x_pos
        y: weather.y_pos
        width: 488
        height: 236
        radius: 15
        color: weather.widgetBackgroundColor
    }
}
