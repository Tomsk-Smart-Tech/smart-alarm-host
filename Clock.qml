import QtQuick 2.0

Item {
    id:clock
    property int x_pos: 10
    property int y_pos: 10

    property string time: "18:08"
    property string date: "Пн, 9 окт."
    property string year: "2032"

    Rectangle {
        x: clock.x_pos
        y: clock.y_pos
        id: gradientRectangle
        width: 236
        height: 236
        radius : 15
        color: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.6)


        FontLoader {
            id: castFont
            source: "ofont.ru_Nunito.ttf"
        }

        Text {
            x: (parent.width - width) / 2
            y: 26
            text: clock.year
            font.pixelSize: 24
            font.family: castFont.name
            color: "white"
        }
        Text {
            x: (parent.width - width) / 2
            y: 180
            text: clock.date
            font.pixelSize: 24
            font.family: castFont.name
            color: "white"
        }


        Rectangle{
            id: timeRectangle
            width: 210
            height: 115
            color: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 0.22)

            radius : 15
            anchors.centerIn: parent

            Text {
                anchors.centerIn: parent
                text: clock.time
                font.pixelSize: 70
                font.family: castFont.name
                color: "white"
            }
        }
    }

}
