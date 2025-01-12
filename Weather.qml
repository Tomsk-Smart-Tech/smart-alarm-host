import QtQuick 2.0

Item {
    id: weather
    property int x_pos: 0
    property int y_pos: 0
    property ListModel weather_list: valueOf
    Rectangle {
        id: rec
        x: weather.x_pos
        y: weather.y_pos
        width: 488
        height: 236
        radius: 15
        color: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.6)
        Rectangle{
            id: rectangle
            x: 10
            y: 10
            width: 468
            height: (236 - 10*3)/3
            radius: 15
            color: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 0.22)
            Image {

                anchors.right: parent.right
                anchors.top: parent.top
                anchors.topMargin: 4
                anchors.rightMargin: 4
                source: "clouds.png"
                width: 60
                height: 60
                fillMode: Image.PreserveAspectFit
            }

            Text {
                id: _text
                text: qsTr("+15")
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: 12
                anchors.topMargin: 10
                font.pixelSize: 36
            }
        }
        Rectangle{
            x: 10
            y: 10*2 + (236 - 10*3)/3
            width: 468
            height: (236 - 10*3)/3*2
            radius: 15
            color: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 0.22)
            Row {
                anchors.centerIn: parent
                spacing: 42
                Repeater {
                    model: weather.weather_list
                    delegate: Column {
                        FontLoader {
                            id: castFont
                            source: "ofont.ru_Nunito.ttf"
                        }
                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: model.day
                            font.pointSize: 12
                            color: "White"
                            font.family: castFont.name
                        }
                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: model.date
                            font.pointSize: 12
                            color: "White"
                            font.family: castFont.name
                        }
                        Image {
                            anchors.horizontalCenter: parent.horizontalCenter
                            source: model.weather
                            width: 50
                            height: 50
                            fillMode: Image.PreserveAspectFit
                        }
                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: model.temp
                            font.pointSize: 12
                            color: "White"
                            font.family: castFont.name
                        }
                    }
                }
            }
        }
    }
}
