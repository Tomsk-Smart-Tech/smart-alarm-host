import QtQuick 2.0

Item {
    id:sensors
    property int x_pos: 10
    property int y_pos: 10
    property color textColor: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
    property color textColorSecond: Qt.rgba(200 / 255, 200 / 255, 200 / 255, 1.0)
    property string tempreture: dht22.temp
    property string humidity_text: dht22.humidity
    Rectangle {
        x: sensors.x_pos
        y: sensors.y_pos
        id: gradientRectangle
        width: 236
        height: 236
        radius : 15
        color: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.6)
        FontLoader {
            id: castFont
            source: "ofont.ru_Nunito.ttf"
        }
        Rectangle{
            x: 10
            y: 10
            width: 216
            height: 90
            radius: 15
            color: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 0.22)

            Image {
                id: temp
                x: 8
                y: 8
                width: 74
                height: 74
                source: "temp.png"
                fillMode: Image.PreserveAspectFit
            }
            Text{
                x: 80
                y: 0
                width: 128
                height: 53
                text: tempreture
                font.family: castFont.name
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 28
                color: sensors.textColor

            }

            Text {
                x: 84
                y: 52
                width: 124
                height: 30
                text: "Температура"
                font.family: castFont
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 14
                color: sensors.textColorSecond

            }
        }
        //"humidity.png"
        Rectangle{
            x: 10
            y: 110
            width: 216
            height: 90
            radius: 15
            color: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 0.22)

            Image {
                id: humidity
                x: 8
                y: 8
                width: 74
                height: 74
                source: "humidity.png"
                fillMode: Image.PreserveAspectFit
            }
            Text{
                x: 80
                y: 0
                width: 128
                height: 53
                text: humidity_text
                font.family: castFont.name
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 28
                color: sensors.textColor
            }

            Text {
                x: 84
                y: 52
                width: 124
                height: 30
                text: "Влажность"
                font.family: castFont.name
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 14
                color: sensors.textColorSecond

            }
        }
        Text {
            x: 13
            y: 201
            width: 215
            height: 27
            color: sensors.textColor
            text: "Датчики"
            font.family: castFont.name
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 18
        }
    }
}
