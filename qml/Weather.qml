import QtQuick 2.0
import Qt5Compat.GraphicalEffects

Item {
    id: weather
    property int x_pos: 0
    property int y_pos: 0
    property ListModel weather_list: valueOf

    property color textColor: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
    property color textColorSecond: Qt.rgba(200 / 255, 200 / 255, 200 / 255, 1.0)

    property color widColorAlphaFirst: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.6)
    property color widColorAlphaSecond: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 0.22)


    property var curr_temp: Math.round(weatherr.cur_weather["temp"])+"°C"
    property var city: weatherr.city
    property var descrition: weatherr.cur_weather["description"]

    property Image background: valueOf
    property int blur: 20

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
        color: weather.widColorAlphaFirst

        Rectangle {
            x: 10
            y: 10
            width: 468
            height: (236 - 10*3)/3
            radius: 15
            color: weather.widColorAlphaSecond
            Image {
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.topMargin: 4
                anchors.rightMargin: 4
                source: "https:"+weatherr.h_weather[0]["icon"]
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
                    width: 102
                    text: weather.curr_temp
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 12
                    anchors.topMargin: 10
                    font.pixelSize: 36
                    horizontalAlignment: Text.AlignHCenter
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
                            width: 260
                            height: 28
                            color: "transparent"
                            clip: true
                            Text {
                                width: 260
                                height: 28
                                id: scrollingText
                                text: weather.descrition
                                font.pixelSize: 24
                                font.family: castFont.name
                                color: weather.textColorSecond

                                PropertyAnimation {
                                    id: textAnimation
                                    target: scrollingText
                                    property: "x"
                                    from: 260  // Начальная позиция
                                    to: -scrollingText.contentWidth  // Конечная позиция
                                    duration: scrollingText.contentWidth * 30  // Скорость анимации
                                    loops: Animation.Infinite  // Бесконечная анимация
                                    running: scrollingText.contentWidth > 260 // Запуск анимации, если текст длиннее textWidth
                                }
                                // Обработка динамического обновления текста
                                onTextChanged: {
                                    // Останавливаем анимацию
                                    textAnimation.stop();

                                    // Сбрасываем позицию текста
                                    scrollingText.x = 0;

                                    // Пересчитываем параметры анимации
                                    textAnimation.from = 260;
                                    textAnimation.to = -scrollingText.contentWidth;
                                    textAnimation.duration = scrollingText.contentWidth * 30;

                                    // Запускаем анимацию, если текст длиннее textWidth
                                    if (scrollingText.contentWidth > 260) {
                                        textAnimation.start();
                                    }
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
            color: weather.widColorAlphaSecond
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
                            color: weather.textColor
                            font.weight: Font.DemiBold
                            font.family: castFont1.name
                        }
                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: Qt.formatDateTime(new Date(modelData["time"]*1000), "dd.MM")
                            font.pointSize: 14
                            color: weather.textColorSecond
                            font.family: castFont1.name
                        }
                        Image {
                            anchors.horizontalCenter: parent.horizontalCenter
                            source: "https:" + modelData["icon"]
                            width: 50
                            height: 50
                        }
                        Row {
                            anchors.horizontalCenter: parent.horizontalCenter
                            spacing: 5 // Добавлено для красоты
                            Text {
                                text: modelData["min_temp"] + "°"
                                font.pointSize: 12
                                color: weather.textColorSecond
                                font.family: castFont1.name
                            }
                            Text {
                                text: modelData["max_temp"] + "°"
                                font.pointSize: 12
                                color: weather.textColor
                                font.family: castFont1.name
                            }
                        }

                    }
                }
            }
        }
    }
}
