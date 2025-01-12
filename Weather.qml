import QtQuick 2.0

Item {
    id: weather
    property int x_pos: 0
    property int y_pos: 0
    property ListModel weather_list: valueOf
    property color widgetBackgroundColor: Qt.rgba(0, 0, 0, 0.6)
    property color textColor: "white"

    property var curr_temp: Math.round(weatherr.cur_weather["temp"])+"°C"
    property var city: weatherr.city
    property var descrition: weatherr.cur_weather["description"]

    function getDayName_short(timestamp)
    {
        var date = new Date(timestamp*1000)
        var days = ["Вс", "Пн", "Вт", "Ср", "Чт", "Пт", "Сб"];
        return days[date.getDay()];
    }

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

        Rectangle {
            x: 10
            y: 10
            width: 468
            height: (236 - 10*3)/3
            radius: 15
            color: Qt.rgba(255, 255, 255, 0.22)
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

            Row {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.leftMargin: 8
                anchors.rightMargin: 8
                spacing: 25
                Text {
                    text: weather.curr_temp
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 12
                    anchors.topMargin: 10
                    font.pixelSize: 36
                    font.family: castFont.name
                    color: weather.textColor
                }
                Column {
                    height: 62
                    anchors.verticalCenter: parent.verticalCenter
                    Text {
                        text: weather.city
                        font.pixelSize: 24
                        font.family: castFont.name
                        color: weather.textColor
                    }
                    Text {
                        text: weather.descrition
                        font.pixelSize: 24
                        font.family: castFont.name
                        color: weather.textColor
                    }
                }
            }
        }
        Rectangle {
            x: 10
            y: 10*2 + (236 - 10*3)/3
            width: 468
            height: (236 - 10*3)/3*2
            radius: 15
            color: Qt.rgba(255, 255, 255, 0.22)
            Row {
                anchors.centerIn: parent
                spacing: 42
                Repeater {
                    id: weatherRepeater
                    model: weatherr.d_weather
                    property color textColor: weather.textColor
                    FontLoader {
                        id: castFont1
                        source: "ofont.ru_Nunito.ttf"
                    }
                    delegate: Column {
                        spacing: 5
                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: model.day
                            font.pointSize: 12
                            color: textColor || "Нет данных"
                            font.family: castFont1.name
                        }
                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text:  getDayName_short(modelData["time"])
                            font.pointSize: 12
                            color: textColor || "Нет данных"
                            font.family: castFont1.name
                        }
                        Image {
                            anchors.horizontalCenter: parent.horizontalCenter
                            source: model.weather
                            width: 50
                            height: 50
                        }
                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: modelData["min_temp"] + "/" + modelData["max_temp"]
                            font.pointSize: 12
                            color: textColor || "Нет данных"
                            font.family: castFont1.name
                        }
                    }
                }
            }
        }
    }
}
