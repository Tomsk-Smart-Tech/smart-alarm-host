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
        // tempreture humidity_text
        Column{
            anchors.fill: parent
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            anchors.topMargin: 10
            anchors.bottomMargin: 36
            spacing: 6
            Rectangle{
                id: temp
                width: 216
                height: 59
                radius: 15
                color: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 0.22)

                Image {
                    id: temp1
                    width: 52
                    height: 52
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.leftMargin: 3
                    anchors.topMargin: 3
                    source: "sensors/temp.png"
                    fillMode: Image.PreserveAspectFit
                }
                Text{
                    x: 80
                    width: 151
                    height: 36
                    text: "10°C"
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.rightMargin: 2
                    anchors.topMargin: 0
                    font.family: castFont.name
                    horizontalAlignment: Text.AlignHCenter
                    font.pointSize: 22
                    color: sensors.textColor
                }

                Text {
                    x: 84
                    y: 52
                    width: 151
                    height: 23
                    text: "температура"
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 0
                    anchors.bottomMargin: 0
                    font.family: castFont.name
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignBottom
                    font.pointSize: 14
                    color: sensors.textColorSecond

                }
            }
            Rectangle{
                id: humidity
                width: 216
                height: 59
                radius: 15
                color: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 0.22)

                Image {
                    id: humidity1
                    width: 52
                    height: 52
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.leftMargin: 3
                    anchors.topMargin: 3
                    source: "sensors/humidity.png"
                    fillMode: Image.PreserveAspectFit
                }
                Text{
                    x: 80
                    width: 151
                    height: 36
                    text: "36%"
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.rightMargin: 2
                    anchors.topMargin: 0
                    font.family: castFont.name
                    horizontalAlignment: Text.AlignHCenter
                    font.pointSize: 22
                    color: sensors.textColor
                }

                Text {
                    x: 84
                    y: 52
                    width: 151
                    height: 23
                    text: "Влажность"
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 0
                    anchors.bottomMargin: 0
                    font.family: castFont.name
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignBottom
                    font.pointSize: 14
                    color: sensors.textColorSecond

                }
            }
            Rectangle{
                id: voc
                width: 216
                height: 59
                radius: 15
                color: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 0.22)

                Image {
                    id: voc1
                    width: 52
                    height: 52
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.leftMargin: 3
                    anchors.topMargin: 3
                    source: "sensors/voc.png"
                    fillMode: Image.PreserveAspectFit
                }
                Text{
                    x: 80
                    width: 151
                    height: 36
                    text: "110"
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.rightMargin: 2
                    anchors.topMargin: 0
                    font.family: castFont.name
                    horizontalAlignment: Text.AlignHCenter
                    font.pointSize: 22
                    color: sensors.textColor
                }

                Text {
                    x: 84
                    y: 52
                    width: 151
                    height: 23
                    text: "voc"
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 0
                    anchors.bottomMargin: 0
                    font.family: castFont.name
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignBottom
                    font.pointSize: 14
                    color: sensors.textColorSecond

                }
            }
        }
        //"humidity.png"
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
