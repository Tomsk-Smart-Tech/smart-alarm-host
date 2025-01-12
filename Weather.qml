import QtQuick 2.0

Item {
    id: weather
    property int x_pos: 0
    property int y_pos: 0
    property ListModel weather_list: valueOf
    property color widgetBackgroundColor: Qt.rgba(0, 0, 0, 0.6)
    property color textColor: Qt.rgba(255/255, 255/255, 255/255, 1.0)
    property color textColorSecond: Qt.rgba(200/255, 200/255, 200/255, 1.0)


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
                source: "loading.png"
                width: 60
                height: 60
                fillMode: Image.PreserveAspectFit
            }

            Row {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.leftMargin: 12
                anchors.rightMargin: 12
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
                    Rectangle{
                        width: 260
                        height: 28
                        color: Qt.rgba(0/255, 0/255, 0/255, 0.0)
                        Rectangle {
                            width: parent.width
                            height: parent.height
                            color: "transparent"
                            clip: true
                            Text {
                                id: scrollingText
                                text: weather.descrition
                                font.pixelSize: 24
                                font.family: castFont.name
                                color: weather.textColorSecond
                                x: 0
                                PropertyAnimation {
                                    id: textAnimation
                                    target: scrollingText
                                    property: "x"
                                    from: 0
                                    to: -scrollingText.contentWidth + 260
                                    duration: (scrollingText.contentWidth - 260) * 30
                                    loops: Animation.Infinite
                                    running: scrollingText.contentWidth > 260
                                }
                            }
                        }

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
                spacing: 15
                Repeater {
                    id: weatherRepeater
                    model: weatherr.d_weather.slice(0, 5)
                    property color textColor: weather.textColor
                    property color textColorSecond: weather.textColorSecond
                    delegate: Column {
                        anchors.verticalCenter: parent.verticalCenter
                        height: (236 - 10*3)/3*2 -12
                        width: 80
                        spacing: 0
                        FontLoader {
                            id: castFont1
                            source: "ofont.ru_Nunito.ttf"
                        }
                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text:  getDayName_short(modelData["time"])
                            font.pointSize: 14
                            color: textColor
                            font.weight: Font.DemiBold
                            font.family: castFont1.name
                        }
                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: Qt.formatDateTime(new Date(modelData["time"]*1000), "dd.MM")
                            font.pointSize: 14
                            color: textColorSecond
                            font.family: castFont1.name
                        }
                        Image {
                            anchors.horizontalCenter: parent.horizontalCenter
                            source: "loading.png"
                            width: 50
                            height: 50
                        }
                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: modelData["min_temp"] + "°C" + " " + modelData["max_temp"] + "°C"
                            font.pointSize: 12
                            color: textColor
                            font.family: castFont1.name
                        }
                    }
                }
            }
        }
    }
}
