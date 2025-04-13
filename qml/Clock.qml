import QtQuick 2.0
import GlobalTime 1.0
import Qt5Compat.GraphicalEffects

Item {
    id:clock
    property int x_pos: 10
    property int y_pos: 10

    property Image background: valueOf

    property int blur: 20

    property color textColor: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
    property color textColorSecond: Qt.rgba(200 / 255, 200 / 255, 200 / 255, 1.0)

    property color widColorAlphaFirst: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.6)
    property color widColorAlphaSecond: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 0.22)

    property string time:""
    property string date: ""
    property string year: ""

    // property var currentDateTime: new Date()
    Timer {
        id: timer
        interval: 1000 // 1 секунда
        running: true
        repeat: true
        onTriggered: {
            spotify.get_current_track()
            // Обновляем currentDateTime каждую секунду
            // currentDateTime = new Date(clock.currentDateTime.getTime() + 1000)
            GlobalTime.currentDateTime = new Date(GlobalTime.currentDateTime.getTime() + 1000)
            if (GlobalTime.currentDateTime.getMinutes()%5 === 0 && GlobalTime.currentDateTime.getSeconds() === 00) //обновление погоды каждые 5 минут надо сделать!!
            {
                weatherr.request_position() //обновляю погоду каждый час
                mqttclient.delete_past_events(GlobalTime.currentDateTime.getTime())
            }
            if (GlobalTime.currentDateTime.getSeconds() % 10 === 0) {
                mqttclient.publish_sensor_data(sensorss.temp,sensorss.humidity,sensorss.voc_index)
            }
            if(GlobalTime.currentDateTime.getMinutes()%30 === 0 && GlobalTime.currentDateTime.getSeconds()===0){
                spotify.get_access_token()
            }
            // if (GlobalTime.currentDateTime.getSeconds() % 10 === 0) {
            //     mqttclient.publish_alarms()
            // }

            if (GlobalTime.currentDateTime.getHours() === 23 && GlobalTime.currentDateTime.getMinutes() === 59 && GlobalTime.currentDateTime.getSeconds() === 50)
            {
                mqttclient.from_events_to_alarms(GlobalTime.currentDateTime.getTime(),user.event_remind,user.time_event,terminal.cur_song)
            }
        }
        Component.onCompleted: {
            mqttclient.from_events_to_alarms(GlobalTime.currentDateTime.getTime(),user.event_remind,user.time_event,terminal.cur_song)
            mqttclient.delete_past_events(GlobalTime.currentDateTime.getTime())
        }

    }

    // Следим за изменением unixtime и обновляем currentDateTime
    Connections {
        target: weatherr
        function onUnixtimeChanged() {
            GlobalTime.currentDateTime = new Date(weatherr.unixtime);
        }
    }
    // Connections {
    //     target: clock.swipe

    //     function onMovingChanged() {
    //         shader.sourceRect = Qt.rect(widgetContainer.x, widgetContainer.y, widgetContainer.width, widgetContainer.height);
    //         console.log("OKJDFSLKDS")
    //     }
    // }

    function getDayName(date)
    {
        var days = ["Воскресенье", "Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота"];
        return days[date.getDay()];
    }



    Rectangle {
        id: widgetContainer
        x: clock.x_pos
        y: clock.y_pos
        width: 236
        height: 236
        radius : 15
        color: clock.widColorAlphaFirst
        layer.enabled: true
        clip: true


        FontLoader {
            id: castFont
            source: "ofont.ru_Nunito.ttf"
        }

        Text {
            id: text
            x: (parent.width - width) / 2
            y: 26
            text: Qt.formatDateTime(GlobalTime.currentDateTime, "dd.MM.yyyy")
            font.pixelSize: 24
            font.family: castFont.name
            color: clock.textColorSecond
        }

        Text {

            x: (parent.width - width) / 2
            y: 180
            text: getDayName(GlobalTime.currentDateTime)
            font.pixelSize: 24
            font.family: castFont.name
            color: clock.textColor
        }


        Rectangle{
            id: timeRectangle
            width: 210
            height: 115
            color: clock.widColorAlphaSecond

            radius : 15
            anchors.centerIn: parent
            Text {
                id: globalTime
                anchors.centerIn: parent
                text: Qt.formatDateTime(GlobalTime.currentDateTime, "hh:mm")
                font.pixelSize: 70
                font.family: castFont.name
                color: clock.textColor
            }

        }
    }

}
