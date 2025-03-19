import QtQuick 2.0
import GlobalTime 1.0

Item {
    id:clock
    property int x_pos: 10
    property int y_pos: 10

    // property string time: "18:08"
    // property string date: "Пн, 9 окт."
    // property string year: "2032"

    //не пугайся кирилл это мой код для управления временем
    property string time:""
    property string date: ""
    property string year: ""
    property var back: valueOf

    // property var currentDateTime: new Date()
    Timer {
        id: timer
        interval: 1000 // 1 секунда
        running: true
        repeat: true
        onTriggered: {

            // Обновляем currentDateTime каждую секунду
            // currentDateTime = new Date(clock.currentDateTime.getTime() + 1000)
            GlobalTime.currentDateTime = new Date(GlobalTime.currentDateTime.getTime() + 1000)
            if (GlobalTime.currentDateTime.getMinutes() === 0 && GlobalTime.currentDateTime.getSeconds() === 00) //обновление погоды каждые 5 минут надо сделать!!
            {
                weatherr.request_position() //обновляю погоду каждый час
            }
            if (GlobalTime.currentDateTime.getSeconds() % 10 === 0) {
                mqttclient.publish_sensor_data(dht22.temp,dht22.humidity)
            }
            // if (GlobalTime.currentDateTime.getSeconds() % 10 === 0) {
            //     mqttclient.publish_alarms()
            // }
        }
    }

    // Следим за изменением unixtime и обновляем currentDateTime
    Connections {
        target: weatherr
        function onUnixtimeChanged() {
            GlobalTime.currentDateTime = new Date(weatherr.unixtime);
        }
    }


    function getDayName(date)
    {
        var days = ["Воскресенье", "Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота"];
        return days[date.getDay()];
    }



    //конец моего кода управления временем

    ShaderEffectSource {
        id: blurSource
        sourceItem: clock.back
        sourceRect: Qt.rect(blurRect.x, blurRect.y, blurRect.width, blurRect.height)
        smooth: true

    }

    Rectangle {
        id: blurRect
        x: clock.x_pos
        y: clock.y_pos
        width: 236
        height: 236
        radius : 15
        color: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.6)
        layer.enabled: true
        // MultiEffect {
        //     anchors.fill: parent
        //     source: blurSource
        //     blurEnabled: true
        //     blurMax: 64
        //     blur: 0.5
        //     autoPaddingEnabled: false
        // }

        FontLoader {
            id: castFont
            source: "ofont.ru_Nunito.ttf"
        }

        Text {
            x: (parent.width - width) / 2
            y: 26
            text: Qt.formatDateTime(GlobalTime.currentDateTime, "dd.MM.yyyy")
            font.pixelSize: 24
            font.family: castFont.name
            color: "white"
        }
        Text {
            x: (parent.width - width) / 2
            y: 180
            text: getDayName(GlobalTime.currentDateTime)
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
                text: Qt.formatDateTime(GlobalTime.currentDateTime, "hh:mm")
                font.pixelSize: 70
                font.family: castFont.name
                color: "white"
            }
        }
    }

}
