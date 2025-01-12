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

    //обновление графика canvas
    Connections {
        target: weatherr
        function onH_weather_changed() {
            graphCanvas.requestPaint();
        }
    }


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
                    ScrollView {
                        id: scrollView
                        anchors.fill: parent
                        anchors.margins: 12
                        clip: true
                        contentWidth: graph.width
                        contentHeight: parent.height

                        ScrollBar.vertical.policy: ScrollBar.AlwaysOff
                        // ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

                        Rectangle {
                            id: graph
                            width: weatherr.h_weather.length * 100
                            height: parent.height
                            color: "transparent"
                            Row {
                                id: graphRow
                                width: 536
                                height: 178
                                spacing: 50
                                anchors.verticalCenter: parent.verticalCenter
                                Repeater {
                                    model: weatherr.h_weather
                                    delegate: Column {
                                        spacing: 0
                                        Text {
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            text: modelData["time"]
                                            font.pointSize: 14
                                            font.weight: Font.DemiBold
                                            color: "white"
                                            font.family: castFont.name
                                        }
                                        Image {
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            source: "sun.png"
                                            width: 30
                                            height: 30
                                        }
                                    }
                                }
                            }

                            Canvas {
                                id: graphCanvas
                                anchors.fill: parent
                                onPaint: {
                                    var ctx = graphCanvas.getContext("2d");
                                    ctx.clearRect(0, 0, graphCanvas.width, graphCanvas.height);

                                    // Проверка данных
                                    var data = weatherr.h_weather;
                                    if (!data || data.length === 0) {
                                        console.log("Нет данных для отрисовки");
                                        return;
                                    }
                                    ctx.strokeStyle = "#9DAEE4";
                                    ctx.lineWidth = 2;
                                    ctx.font = "16px Arial";
                                    ctx.textAlign = "center";

                                    // var step = 100 //тогда не съезжает
                                    var step =101.8
                                    var maxTemp = weatherr.cur_weather["max2d"];
                                    var minTemp = weatherr.cur_weather["min2d"];
                                    // var range = Math.abs(maxTemp) + Math.abs(minTemp) || 1;
                                    var range = maxTemp - minTemp || 1;
                                    var y_step = 70/range

                                    ctx.beginPath();

                                    for (var i = 0; i < data.length; i++) {
                                        var x = step * i + step / 2 - 26;
                                        if(data[i]["temp"] < 0){
                                            var y = (150 - Math.abs(data[i]["temp"] - minTemp) * y_step);
                                        } else {
                                            var y = (150 + Math.abs(data[i]["temp"] - minTemp) * y_step);
                                        }


                                        if (i === 0) {
                                            ctx.moveTo(x, y);
                                        } else {
                                            ctx.lineTo(x, y);
                                        }
                                        ctx.arc(x, y, 5, 0, Math.PI * 2);
                                        var temperatureText = Math.round(data[i]["temp"]) + "°C";
                                        ctx.fillStyle = "white";
                                        ctx.fillText(temperatureText, x, y - 10);
                                    }
                                    ctx.stroke();
                                }
                            }
                        }
                    }
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
