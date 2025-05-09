import QtQuick 2.15
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

Item {
    id: weather

    property int x_pos: 0
    property int y_pos: 0

    property color backgroundColorAlpha: Qt.rgba(50/255, 50/255, 50/255, 0.5)
    property color widColorAlpha: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.3)

    property color textColor: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
    property color textColorSecond: Qt.rgba(200 / 255, 200 / 255, 200 / 255, 1.0)

    property color addColor: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.6)

    property ListModel week_list: valueOf

    property Image background: valueOf

    property var currect_temp: "None"
    property var currect_temp_max: "None"
    property var currect_temp_min: "None"

    property var humidity: "None"
    property var wind: "None"
    property var feel_temp: "None"

    property string sunrise: "None"
    property string sunset: "None"
    property var dew_point: "None"
    property string uv: "None"
    property var rain_sensor: "None"

    signal pressAlarms()
    signal unpressAlarms()

    onTextColorChanged: {
        console.log("Weather textColor changed to:", textColor, "- Requesting Canvas repaint.");
        // Запрашиваем перерисовку Canvas, если он уже создан
        if (graphCanvas) {
            graphCanvas.requestPaint();
        }
    }

    //обновление графика canvas
    Connections {
        target: weatherr
        function onH_weather_changed() {
            graphCanvas.requestPaint();
        }
    }
    function getDayName_short(timestamp)
    {
        var date = new Date(timestamp*1000)
        var days = ["Вс", "Пн", "Вт", "Ср", "Чт", "Пт", "Сб"];
        return days[date.getDay()];
    }


    Rectangle{
        id:rec
        x: weather.x_pos
        y: weather.y_pos
        width: 1024
        height: 600

        //color: Qt.rgba(50 / 255, 50 / 255, 50 / 255, 1.0)
        color: weather.backgroundColorAlpha

        // FastBlur {
        //     id: blurEffect
        //     anchors.fill: parent
        //     radius: 20
        //     source: ShaderEffectSource {
        //         sourceItem: weather.background
        //         live: true
        //     }
        // }

        FontLoader {
            id: castFont
            source: "ofont.ru_Nunito.ttf"
        }


        ScrollView {
            id: scroll
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
                    color: weather.widColorAlpha
                    radius: 15
                    anchors.margins: 30
                    Row {
                        x: 21
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 42

                        Image {
                            anchors.verticalCenter: parent.verticalCenter
                            source: "https:"+weatherr.h_weather[0]["icon"]
                            width: 120
                            height: 120
                        }
                        Column {
                            // spacing: 8
                            Text {
                                text: Math.round(weather.currect_temp) + " °C"
                                font.pointSize: 48
                                color: weather.textColor
                                anchors.horizontalCenter: parent.horizontalCenter
                                font.family: castFont.name
                            }
                            Row{
                                Rectangle{
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: 28
                                    height: 28
                                    color: weather.addColor
                                    radius: 5
                                    Image {
                                        width: 28
                                        height: 28
                                        source: "resource_icon/weather_icon/temp_down.png"
                                    }
                                }

                                Text {
                                    text: Math.round(weather.currect_temp_min) + " °C"
                                    font.pointSize: 22
                                    color: weather.textColor
                                    font.family: castFont.name
                                }
                                Text {
                                    text: qsTr("  ")
                                    font.pointSize: 22
                                    color: weather.textColor
                                    font.family: castFont.name
                                }
                                Rectangle{
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: 28
                                    height: 28
                                    color: weather.addColor
                                    radius: 5
                                    Image {
                                        width: 28
                                        height: 28
                                        source: "resource_icon/weather_icon/temp_up.png"
                                    }
                                }
                                Text {
                                    text: Math.round(weather.currect_temp_max) + " °C"
                                    font.pointSize: 22
                                    color: weather.textColor
                                    font.family: castFont.name
                                }
                            }
                        }
                    }
                    Column{
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 8
                        anchors.bottomMargin: 8
                        spacing: -4
                        Row{
                            Text {
                                width: 204
                                text: "Влажность:"
                                horizontalAlignment: Text.AlignRight
                                font.bold: true
                                font.pointSize: 20
                                color: weather.textColorSecond
                                font.family: castFont.name
                            }
                            Text {
                                width: 144
                                text: weather.humidity
                                horizontalAlignment: Text.AlignHCenter
                                font.pointSize: 20
                                color: weather.textColor
                                font.family: castFont.name
                            }
                        }
                        Row{
                            Text {
                                width: 204
                                text: "Скорость ветра:"
                                horizontalAlignment: Text.AlignRight
                                font.bold: true
                                font.pointSize: 20
                                color: weather.textColorSecond
                                font.family: castFont.name
                            }
                            Text {
                                width: 144
                                text: weather.wind
                                horizontalAlignment: Text.AlignHCenter
                                font.pointSize: 20
                                color: weather.textColor
                                font.family: castFont.name
                            }
                        }
                        Row{
                            Text {
                                width: 204
                                text: "Ощущается как:"
                                horizontalAlignment: Text.AlignRight
                                font.bold: true
                                font.pointSize: 20
                                color: weather.textColorSecond
                                font.family: castFont.name
                            }
                            Text {
                                width: 144
                                text: Math.round(weather.feel_temp) + " °C"
                                horizontalAlignment: Text.AlignHCenter
                                font.pointSize: 20
                                color: weather.textColor
                                font.family: castFont.name
                            }
                        }

                    }

                    Text {
                        x: 183
                        text: weatherr.city
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.rightMargin: 16
                        anchors.topMargin: 8
                        font.pointSize: 28
                        color: weather.textColor
                        font.family: castFont.name
                    }
                }
                Rectangle{
                    id: grah
                    width: parent.width
                    height: 178
                    color: weather.widColorAlpha
                    radius: 15
                    ScrollView {
                        id: scrollView
                        anchors.fill: parent
                        anchors.margins: 12
                        // clip: true
                        contentWidth: graph.width
                        contentHeight: 154
                        ScrollBar.vertical.policy: ScrollBar.AlwaysOff
                        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

                        Flickable {
                            id: flick
                            anchors.fill: parent
                            clip: true
                            flickableDirection: Flickable.HorizontalFlick
                            maximumFlickVelocity: 500
                            Rectangle {
                                id: graph
                                width: weatherr.h_weather.length * 100
                                height: parent.height
                                color: "transparent"
                                Row {
                                    id: graphRow
                                    anchors.fill: parent
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
                                                color: weather.textColorSecond
                                                font.family: castFont.name
                                            }
                                            Image {
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                source: "https:" + modelData["icon"]
                                                // width: 28
                                                // height: 28
                                                width: 40
                                                height: 40

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
                                        //ctx.font = "20px Arial";
                                        ctx.font = "18px sans-serif";
                                        ctx.textAlign = "center";

                                        // var step = 100 //тогда не съезжает
                                        var step =100
                                        var maxTemp = weatherr.cur_weather["max2d"];
                                        var minTemp = weatherr.cur_weather["min2d"];
                                        // var range = Math.abs(maxTemp) + Math.abs(minTemp) || 1;
                                        var range = maxTemp - minTemp || 1;
                                        var y_step = 70/range

                                        ctx.beginPath();
                                        for (var i = 0; i < data.length; i++) {
                                            var x = step * i + step / 2 - 26;
                                            var y = (50 - Math.abs(data[i]["temp"] - minTemp) * 50 / range);

                                            if (i === 0) {
                                                ctx.moveTo(x, y + 90);
                                            } else {
                                                ctx.lineTo(x, y + 90);
                                            }
                                        }
                                        ctx.strokeStyle = "#9DAEE4";
                                        ctx.lineWidth = 2;
                                        ctx.stroke();

                                        for (var i = 0; i < data.length; i++) {
                                            var x = step * i + step / 2 - 26;
                                            var y = (50 - Math.abs(data[i]["temp"] - minTemp) * 50 / range);

                                            ctx.beginPath();
                                            ctx.arc(x, y + 90, 5, 0, Math.PI * 2);
                                            ctx.fillStyle = "#D0CCEE";
                                            ctx.fill();
                                            ctx.closePath();

                                            var temperatureText = Math.round(data[i]["temp"]) + "°C";
                                            ctx.fillStyle = weather.textColor;
                                            ctx.fillText(temperatureText, x, y - 8 + 90);
                                        }
                                    }
                                }
                            }
                        }
                        TapHandler {
                            target: flick
                            acceptedButtons: Qt.AllButtons
                            onPressedChanged: {
                                if (pressed) {
                                    weather.pressAlarms()
                                } else {
                                    weather.unpressAlarms()
                                }
                            }
                            // TapHandler не должен мешать скроллингу или кликам внутри делегата
                        }
                    }
                }
                Rectangle{
                    width: parent.width
                    height: 178
                    color: weather.widColorAlpha
                    radius: 15
                    Row {
                        anchors.centerIn: parent
                        spacing: 30
                        Repeater {
                            id: weatherRepeater
                            model: weatherr.d_weather.slice(0, 8)
                            property color textColor: weather.textColor
                            property color textColorSecond: weather.textColorSecond
                            delegate: Column {
                                spacing: 0
                                height: 178 - 24
                                width: 93
                                FontLoader {
                                    id: castFont1
                                    source: "ofont.ru_Nunito.ttf"
                                }
                                Text {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text:  getDayName_short(modelData["time"])
                                    font.pointSize: 18
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
                                    //source: "loading.png"
                                    source: "https:" + modelData["icon"]
                                    width: 70
                                    height: 70
                                }
                                Row {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    spacing: 5
                                    Text {
                                        text: index === 0 ? Math.round(weather.currect_temp_min) + "°" : modelData["min_temp"] + "°"
                                        font.pointSize: 16
                                        color: weather.textColorSecond
                                        font.family: castFont1.name


                                    }
                                    Text {
                                        text: index === 0 ? Math.round(weather.currect_temp_max) + "°" : modelData["max_temp"] + "°"
                                        font.pointSize: 16
                                        color: weather.textColor
                                        font.family: castFont1.name
                                    }
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
                            color: weather.widColorAlpha
                            radius: 15
                            Rectangle{
                                id: rectangle8
                                width: 64
                                height: 64
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 12
                                color: weather.addColor
                                radius: 10
                                Image {
                                    width: 60
                                    height: 60
                                    anchors.verticalCenter: parent.verticalCenter
                                    source: "resource_icon/weather_icon/sunrise.png"
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
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
                            color: weather.widColorAlpha
                            radius: 15
                            Rectangle{
                                id: rectangle7
                                width: 64
                                height: 64
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 12
                                color: weather.addColor
                                radius: 10
                                Image {
                                    width: 60
                                    height: 60
                                    anchors.verticalCenter: parent.verticalCenter
                                    source: "resource_icon/weather_icon/sunset.png"
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
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
                        color: weather.widColorAlpha
                        radius: 15
                        Rectangle{
                            id: rectangle9
                            width: 80
                            height: 80
                            anchors.left: parent.left
                            anchors.top: parent.top
                            anchors.leftMargin: 16
                            anchors.topMargin: 16
                            color: weather.addColor
                            radius: 10
                            Image {
                                width: 70
                                height: 70
                                anchors.verticalCenter: parent.verticalCenter
                                source: "resource_icon/weather_icon/pressure.png"
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }
                        Text {
                            text: "Давление"
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
                        Canvas {
                            anchors.fill: parent
                            onPaint: {
                                var ctx = getContext("2d");
                                ctx.strokeStyle = "#757575";
                                ctx.lineWidth = 2;
                                ctx.beginPath();
                                var y = 16 + 80 + 16+ 16;
                                ctx.moveTo(16, y);
                                ctx.lineTo(236 - 16, y);
                                ctx.stroke();
                            }
                        }

                        Column {
                            id: column1
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
                                color: weather.textColor
                                text: weatherr.cur_weather["pressure"]
                                horizontalAlignment: Text.AlignHCenter
                                lineHeight: 0.5
                                font.weight: Font.DemiBold
                                font.pointSize: 36
                                font.family: castFont.name
                                font.bold: false
                                anchors.horizontalCenter: parent.horizontalCenter
                            }

                            Text {
                                color: weather.textColorSecond
                                text: "мм рт.ст."
                                lineHeight: 0.5
                                font.pointSize: 24
                                font.family: castFont.name
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }
                    }
                    // Rectangle{
                    //     id: rectangle3
                    //     width: 236
                    //     height: 178
                    //     color: weather.backgroundColor
                    //     radius: 15
                    //     Image {
                    //         width: 80
                    //         height: 80
                    //         anchors.left: parent.left
                    //         anchors.top: parent.top
                    //         anchors.leftMargin: 16
                    //         anchors.topMargin: 16
                    //         source: "weather_icon/UV.png"
                    //     }
                    //     Text {
                    //         width: 115
                    //         height: 55
                    //         text: weather.uv
                    //         anchors.right: parent.right
                    //         anchors.top: parent.top
                    //         anchors.rightMargin: 16
                    //         anchors.topMargin: 27
                    //         horizontalAlignment: Text.AlignHCenter
                    //         font.weight: Font.DemiBold
                    //         font.pointSize: 36
                    //         color: weather.textColor
                    //         font.family: castFont.name
                    //     }
                    //     Text {
                    //         text: "УФ индекс"
                    //         anchors.left: parent.left
                    //         anchors.right: parent.right
                    //         anchors.bottom: parent.bottom
                    //         anchors.rightMargin: 0
                    //         anchors.bottomMargin: 14
                    //         horizontalAlignment: Text.AlignHCenter
                    //         font.bold: false
                    //         font.pointSize: 20
                    //         color: weather.textColorSecond
                    //         font.family: castFont.name
                    //     }
                    //     Canvas {
                    //         anchors.fill: parent
                    //         onPaint: {
                    //             var ctx = getContext("2d");
                    //             ctx.strokeStyle = "#757575";
                    //             ctx.lineWidth = 2;
                    //             ctx.beginPath();
                    //             var y = 16 + 80 + 16;
                    //             ctx.moveTo(16, y);
                    //             ctx.lineTo(236 - 16, y);
                    //             ctx.stroke();
                    //         }
                    //     }
                    // }
                    Rectangle{
                        id: rectangle4
                        width: 236
                        height: 178
                        color: weather.widColorAlpha
                        radius: 15
                        Rectangle{
                            id: rectangle3
                            width: 80
                            height: 80
                            anchors.left: parent.left
                            anchors.top: parent.top
                            anchors.leftMargin: 16
                            anchors.topMargin: 16
                            color: weather.addColor
                            radius: 10
                            Image {
                                width: 70
                                height: 70
                                anchors.verticalCenter: parent.verticalCenter
                                source: "resource_icon/weather_icon/rain_sensor.png"
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
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
                        Canvas {
                            anchors.fill: parent
                            onPaint: {
                                var ctx = getContext("2d");
                                ctx.strokeStyle = "#757575";
                                ctx.lineWidth = 2;
                                ctx.beginPath();
                                var y = 16 + 80 + 16 + 16;
                                ctx.moveTo(16, y);
                                ctx.lineTo(236 - 16, y);
                                ctx.stroke();
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
                    Column{
                        spacing: 16
                        Rectangle{
                            id: rectangle89
                            width: 236
                            height: 81
                            color: weather.widColorAlpha
                            radius: 15
                            Rectangle{
                                width: 64
                                height: 64
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 12
                                color: weather.addColor
                                radius: 10
                                Image {
                                    width: 64
                                    height: 64
                                    source: "resource_icon/weather_icon/dew_point.png"
                                }
                            }
                            Text {
                                text: weather.dew_point
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
                                x: 82
                                y: 49
                                width: 150
                                height: 32
                                text: "Точка росы"
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
                            id: rectangle45
                            width: 236
                            height: 81
                            color: weather.widColorAlpha
                            radius: 15
                            Rectangle{
                                id: rectangle6
                                width: 64
                                height: 64
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 12
                                color: weather.addColor
                                radius: 10
                                Image {
                                    id: image
                                    width: 60
                                    height: 60
                                    anchors.verticalCenter: parent.verticalCenter
                                    source: "resource_icon/weather_icon/UV.png"
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    Rectangle {
                                        id: uv_indicator
                                        width: 16
                                        height: 16
                                        color: {
                                            if (weather.uv <= 2) {
                                                return "#3EA72D";
                                            } else if (weather.uv <= 5) {
                                                return "#FFF300";
                                            } else if (weather.uv <= 7) {
                                                return "#F18B00";
                                            } else if (weather.uv <= 10) {
                                                return "#E53210";
                                            } else {
                                                return "#B567A4";
                                            }
                                        }
                                        radius: 7
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.horizontalCenter: parent.horizontalCenter
                                    }
                                }
                            }
                            Text {
                                text: weather.uv
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
                                x: 102
                                y: 49
                                width: 130
                                height: 32
                                text: "УФ индекс"
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
                }

            }
            TapHandler {
                target: scroll
                acceptedButtons: Qt.AllButtons
                onPressedChanged: {
                    if (pressed) {
                        weather.pressAlarms()
                    } else {
                        weather.unpressAlarms()
                    }
                }
                // TapHandler не должен мешать скроллингу или кликам внутри делегата
            }
        }

    }
}
