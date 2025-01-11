import QtQuick 2.0
import QtQuick.Controls 2.15
import QtCharts 2.15

Item {
    id: weather

    //поменял почти везде string на var ибо ругается
    property int x_pos: 0
    property int y_pos: 0
    property color backgroundColor: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.3)
    property color textColor: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
    property color textColorSecond: Qt.rgba(200 / 255, 200 / 255, 200 / 255, 1.0)
    property ListModel week_list: valueOf

    property var currect_temp: ""
    property var currect_temp_max: ""
    property var currect_temp_min: ""

    property var humidity: ""
    property var wind: ""
    property var feel_temp: ""

    property string sunrise: "000"
    property string sunset: "000"
    property var dew_point: "000"
    property string uv: "000"
    property var rain_sensor: "000"


    Rectangle{
        id:rec
        x: weather.x_pos
        y: weather.y_pos
        width: 1024
        height: 600

        color: Qt.rgba(50 / 255, 50 / 255, 50 / 255, 1.0)

        FontLoader {
            id: castFont
            source: "ofont.ru_Nunito.ttf"
        }


        ScrollView {
            contentWidth: parent.width
            anchors.fill: parent
            anchors.topMargin: 16
            anchors.bottomMargin: 16

            ScrollBar.vertical.policy: ScrollBar.AlwaysOff
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            Column {
                spacing: 16
                width: parent.width - 32
                anchors.horizontalCenter: parent.horizontalCenter
                Rectangle{
                    id: rectangle5
                    width: parent.width
                    height: 178
                    color: weather.backgroundColor
                    radius: 15
                    anchors.margins: 30
                    Row {
                        x: 21
                        y: 23
                        spacing: 30
                        Image {
                            anchors.verticalCenter: parent.verticalCenter
                            source: "sun.png"
                            width: 120
                            height: 120
                        }
                        Column {
                            // spacing: 8
                            Text {
                                text: weather.currect_temp + "°C"
                                font.pointSize: 48
                                color: weather.textColor
                                anchors.horizontalCenter: parent.horizontalCenter
                                font.family: castFont.name
                            }
                            Row{
                                Image {
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: 28
                                    height: 28
                                    source: "weather_icon/temp_down.png"
                                }
                                Text {
                                    text: weather.currect_temp_min + "°C"
                                    font.pointSize: 24
                                    color: weather.textColor
                                    font.family: castFont.name
                                }
                                Text {
                                    text: qsTr("  ")
                                    font.pointSize: 24
                                    color: weather.textColor
                                    font.family: castFont.name
                                }
                                Image {
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: 28
                                    height: 28
                                    source: "weather_icon/temp_up.png"
                                }
                                Text {
                                    text: weather.currect_temp_max + "°C"
                                    font.pointSize: 24
                                    color: weather.textColor
                                    font.family: castFont.name
                                }
                            }

                        }
                    }
                    Column{
                        id: column1
                        x: 446
                        width: 460
                        height: 155
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 12
                        spacing: 8
                        Row{
                            id: row
                            width: 460
                            height: 45
                            anchors.leftMargin: 0
                            anchors.rightMargin: 0
                            Text {
                                text: "Влажность:"
                                anchors.right: parent.right
                                anchors.rightMargin: 220
                                font.pointSize: 24
                                color: weather.textColorSecond
                                font.family: castFont.name
                            }
                            Image {
                                width: 45
                                height: 45
                                anchors.left: parent.left
                                anchors.leftMargin: 260
                                source: "weather_icon/humidity.png"
                            }
                            Text {
                                width: 144
                                text: weather.humidity
                                anchors.right: parent.right
                                anchors.rightMargin: 0
                                horizontalAlignment: Text.AlignLeft
                                font.weight: Font.DemiBold
                                font.pointSize: 24
                                color: weather.textColor
                                font.family: castFont.name
                            }
                        }
                        Row{
                            id: row1
                            width: 460
                            height: 45
                            anchors.leftMargin: 0
                            anchors.rightMargin: 0
                            Text {
                                text: "Скорость ветра:"
                                anchors.right: parent.right
                                anchors.rightMargin: 218
                                font.pointSize: 24
                                color: weather.textColorSecond
                                font.family: castFont.name
                            }
                            Image {
                                width: 45
                                height: 45
                                anchors.left: parent.left
                                anchors.leftMargin: 260
                                source: "weather_icon/wind.png"
                            }
                            Text {
                                width: 144
                                text: weather.wind
                                anchors.right: parent.right
                                horizontalAlignment: Text.AlignLeft
                                font.weight: Font.DemiBold
                                font.pointSize: 24
                                color: weather.textColor
                                font.family: castFont.name
                            }
                        }
                        Row{
                            width: 460
                            height: 45
                            anchors.leftMargin: 0
                            anchors.rightMargin: 0
                            Text {
                                text: "Ощущается как:"
                                anchors.left: parent.left
                                anchors.leftMargin: 0
                                font.pointSize: 24
                                color: weather.textColorSecond
                                font.family: castFont.name
                            }
                            Image {
                                width: 45
                                height: 45
                                anchors.left: parent.left
                                anchors.leftMargin: 260
                                source: "weather_icon/temp.png"
                            }
                            Text {
                                width: 144
                                anchors.right: parent.right
                                horizontalAlignment: Text.AlignLeft
                                font.weight: Font.DemiBold
                                font.pointSize: 24
                                color: weather.textColor
                                font.family: castFont.name
                                text: weather.feel_temp
                            }
                        }

                    }
                }
                Rectangle{
                    id: grah
                    width: parent.width
                    height: 178
                    color: weather.backgroundColor
                    radius: 15
                    SwipeView {
                            anchors.fill: parent
                            Row {
                                spacing: 50
                                Repeater {
                                    model: weatherr.h_weather
                                    delegate: Rectangle {
                                        width: 100
                                        height: 146
                                        radius: 15
                                        color: Qt.rgba(200 / 255, 200 / 255, 200 / 255, 0.3)
                                        Text {
                                            anchors.centerIn: parent
                                            text: modelData["time"] + ": " + modelData["temp"] + "°C"  // Выводим данные из QVariantMap
                                        }
                                        Component.onCompleted: {
                                                        console.log("Item created with time: " + model.time + " and temp: " + model.temp);
                                                    }
                                    }
                                }
                            }
                        }

                    // Canvas {
                    //     id: graphCanvas
                    //     anchors.fill: parent
                    //     contextType: ""
                    //     onPaint: {
                    //         var ctx = graphCanvas.getContext("2d");
                    //         ctx.beginPath();
                    //         ctx.moveTo(10, 10);
                    //         ctx.lineTo(50, 50);
                    //         ctx.strokeStyle = "white";
                    //         ctx.lineWidth = 2;
                    //         ctx.stroke();
                    //     }
                        // onPaint: {
                        //     var ctx = graphCanvas.getContext("2d");
                        //     ctx.clearRect(0, 0, graphCanvas.width, graphCanvas.height);

                        //     var padding = 40;
                        //     var graphWidth = graphCanvas.width - padding * 2;
                        //     var graphHeight = graphCanvas.height - padding * 2;

                        //     // Границы данных
                        //     var maxTemp = Math.max.apply(null, temperatureData.map(d => d.temp));
                        //     var minTemp = Math.min.apply(null, temperatureData.map(d => d.temp));
                        //     var tempRange = maxTemp - minTemp;

                        //     var pointSpacing = graphWidth / (temperatureData.length - 1);

                        //     // Рисуем оси
                        //     ctx.beginPath();
                        //     ctx.moveTo(padding, graphCanvas.height - padding);
                        //     ctx.lineTo(padding, padding);
                        //     ctx.lineTo(graphCanvas.width - padding, graphCanvas.height - padding);
                        //     ctx.strokeStyle = "black";
                        //     ctx.lineWidth = 2;
                        //     ctx.stroke();

                        //     // Рисуем точки и соединяем их
                        //     ctx.beginPath();
                        //     temperatureData.forEach((data, index) => {
                        //         var x = padding + index * pointSpacing;
                        //         var y = graphCanvas.height - padding - (data.temp - minTemp) / tempRange * graphHeight;

                        //         if (index === 0) {
                        //             ctx.moveTo(x, y);
                        //         }else {
                        //             ctx.lineTo(x, y);
                        //         }

                        //         // Рисуем точки
                        //         ctx.arc(x, y, 3, 0, Math.PI * 2);
                        //         ctx.moveTo(x, y);
                        //     });
                        //     ctx.strokeStyle = "blue";
                        //     ctx.lineWidth = 2;
                        //     ctx.stroke();

                        //     // Подписи времени
                        //     ctx.fillStyle = "black";
                        //     ctx.font = "12px Arial";
                        //     temperatureData.forEach((data, index) => {
                        //         var x = padding + index * pointSpacing;
                        //         ctx.fillText(data.time, x - 10, graphCanvas.height - padding + 15);
                        //     });
                        // }
                    // }

                }
                Rectangle{
                    width: parent.width
                    height: 178
                    color: weather.backgroundColor
                    radius: 15
                    Row {
                        anchors.centerIn: parent
                        spacing: 50
                        Repeater {
                            model: weather.week_list
                            delegate: Column {
                                Text {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: model.day
                                    font.pointSize: 14
                                    font.weight: Font.DemiBold
                                    color: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
                                    font.family: castFont.name
                                }
                                Text {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: model.date
                                    font.pointSize: 14
                                    font.weight: Font.DemiBold
                                    color: Qt.rgba(200 / 255, 200 / 255, 200 / 255, 1.0)
                                    font.family: castFont.name
                                }
                                Image {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    source: model.weather
                                    width: 70
                                    height: 70
                                    fillMode: Image.PreserveAspectFit
                                }
                                Text {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: model.temp
                                    font.pointSize: 14
                                    font.weight: Font.DemiBold
                                    color: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
                                    font.family: castFont.name
                                }
                            }
                        }
                    }
                }
                Row{
                    spacing: 16
                    Column{
                        spacing: 16
                        Rectangle{
                            id: rectangle
                            width: 236
                            height: 81
                            color: weather.backgroundColor
                            radius: 15
                            Image {
                                width: 64
                                height: 64
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 12
                                source: "weather_icon/sunrise.png"
                                anchors.verticalCenterOffset: 0
                            }
                            Text {
                                text: weather.sunrise
                                anchors.right: parent.right
                                anchors.top: parent.top
                                anchors.rightMargin: 9
                                anchors.topMargin: 4
                                font.weight: Font.DemiBold
                                font.pointSize: 32
                                color: weather.textColor
                                font.family: castFont.name
                            }
                            Text {
                                x: 129
                                y: 49
                                width: 103
                                height: 32
                                text: "Рассвет"
                                anchors.right: parent.right
                                anchors.bottom: parent.bottom
                                anchors.rightMargin: 4
                                horizontalAlignment: Text.AlignHCenter
                                font.bold: false
                                font.pointSize: 18
                                color: weather.textColorSecond
                                font.family: castFont.name
                            }

                        }
                        Rectangle{
                            id: rectangle1
                            width: 236
                            height: 81
                            color: weather.backgroundColor
                            radius: 15
                            Image {
                                width: 64
                                height: 64
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 12
                                source: "weather_icon/sunset.png"
                                anchors.verticalCenterOffset: 0
                            }
                            Text {
                                text: weather.sunset
                                anchors.right: parent.right
                                anchors.top: parent.top
                                anchors.rightMargin: 9
                                anchors.topMargin: 4
                                font.weight: Font.DemiBold
                                font.pointSize: 32
                                color: weather.textColor
                                font.family: castFont.name
                            }
                            Text {
                                x: 129
                                y: 49
                                width: 103
                                height: 32
                                text: "Закат"
                                anchors.right: parent.right
                                anchors.bottom: parent.bottom
                                anchors.rightMargin: 4
                                horizontalAlignment: Text.AlignHCenter
                                font.bold: false
                                font.pointSize: 18
                                color: weather.textColorSecond
                                font.family: castFont.name
                            }
                        }
                    }
                    Rectangle{
                        id: rectangle2
                        width: 236
                        height: 178
                        color: weather.backgroundColor
                        radius: 15
                        Image {
                            width: 80
                            height: 80
                            anchors.left: parent.left
                            anchors.top: parent.top
                            anchors.leftMargin: 16
                            anchors.topMargin: 16
                            source: "weather_icon/dew_point.png"
                        }
                        Text {
                            width: 115
                            height: 55
                            text: weather.dew_point
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.rightMargin: 16
                            anchors.topMargin: 27
                            horizontalAlignment: Text.AlignHCenter
                            font.weight: Font.DemiBold
                            font.pointSize: 36
                            color: weather.textColor
                            font.family: castFont.name
                        }
                        Text {
                            text: "Точка росы"
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.bottom: parent.bottom
                            anchors.rightMargin: 0
                            anchors.bottomMargin: 8
                            horizontalAlignment: Text.AlignHCenter
                            font.bold: false
                            font.pointSize: 20
                            color: weather.textColorSecond
                            font.family: castFont.name
                        }
                    }
                    Rectangle{
                        id: rectangle3
                        width: 236
                        height: 178
                        color: weather.backgroundColor
                        radius: 15
                        Image {
                            width: 80
                            height: 80
                            anchors.left: parent.left
                            anchors.top: parent.top
                            anchors.leftMargin: 16
                            anchors.topMargin: 16
                            source: "weather_icon/UV.png"
                        }
                        Text {
                            width: 115
                            height: 55
                            text: weather.uv
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.rightMargin: 16
                            anchors.topMargin: 27
                            horizontalAlignment: Text.AlignHCenter
                            font.weight: Font.DemiBold
                            font.pointSize: 36
                            color: weather.textColor
                            font.family: castFont.name
                        }
                        Text {
                            text: "УФ индекс"
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.bottom: parent.bottom
                            anchors.rightMargin: 0
                            anchors.bottomMargin: 8
                            horizontalAlignment: Text.AlignHCenter
                            font.bold: false
                            font.pointSize: 20
                            color: weather.textColorSecond
                            font.family: castFont.name
                        }
                    }
                    Rectangle{
                        id: rectangle4
                        width: 236
                        height: 178
                        color: weather.backgroundColor
                        radius: 15
                        Image {
                            width: 80
                            height: 80
                            anchors.left: parent.left
                            anchors.top: parent.top
                            anchors.leftMargin: 16
                            anchors.topMargin: 16
                            source: "weather_icon/rain_sensor.png"
                        }
                        Column{
                            id: column
                            x: 114
                            width: 115
                            height: 99
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.rightMargin: 16
                            anchors.topMargin: 27
                            Text {
                                width: 115
                                height: 55
                                text: weather.rain_sensor
                                horizontalAlignment: Text.AlignHCenter
                                lineHeight: 0.5
                                font.weight: Font.DemiBold
                                font.bold: false
                                anchors.horizontalCenter: parent.horizontalCenter
                                font.pointSize: 36
                                color: weather.textColor
                                font.family: castFont.name
                            }
                            Text {
                                text: "мм"
                                lineHeight: 0.5
                                anchors.horizontalCenter: parent.horizontalCenter
                                font.pointSize: 24
                                color: weather.textColorSecond
                                font.family: castFont.name
                            }

                        }

                        Text {
                            text: "Кол-во осадков"
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.bottom: parent.bottom
                            anchors.rightMargin: 0
                            anchors.bottomMargin: 8
                            horizontalAlignment: Text.AlignHCenter
                            font.bold: false
                            font.pointSize: 20
                            color: weather.textColorSecond
                            font.family: castFont.name
                        }

                    }
                }

            }

        }
    }
}
