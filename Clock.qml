import QtQuick 2.0

Item {
    id:clock
    property int x_pos: 10
    property int y_pos: 10

    // property string time: "18:08"
    // property string date: "Пн, 9 окт."
    // property string year: "2032"

    //не пугайся кирилл это мой код для управления временем
    property string time: ""
    property string date: ""
    property string year: ""

    property var currentDateTime: new Date()
    Timer {
        id: timer
        interval: 1000 // 1 секунда
        running: true
        repeat: true
        onTriggered: {
            // Обновляем currentDateTime каждую секунду
            currentDateTime = new Date(clock.currentDateTime.getTime() + 1000)

            if (currentDateTime.getMinutes() === 0 && currentDateTime.getSeconds() === 0)
            {
                weatherr.request_position() //обновляю погоду каждый час
                graphCanvas.requestPaint();
            }
        }
    }

    // Следим за изменением unixtime и обновляем currentDateTime
    Connections {
        target: weatherr // Здесь предполагается, что `weather` имеет сигнал изменения
        function onUnixtimeChanged() {
            currentDateTime = new Date(weatherr.unixtime);
        }
    }

    function getDayName(date)
    {
        var days = ["Воскресенье", "Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота"];
        return days[date.getDay()];
    }



    //конец моего кода управления временем


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
