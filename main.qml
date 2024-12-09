import QtQuick
import QtQuick.Controls

Window {
    width: 1024
    height: 600
    visible: true
    title: qsTr("Hello World")

    Image {
        id: back
        source: "mounts.jpg"
        anchors.fill: parent
    }
    Rectangle{
        anchors.fill: parent
        color: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.0)
    }
    ListModel{
        id:alarms
        ListElement { time: "8:30"; description: "Первая"; activate: true}
        ListElement { time: "10:25"; description: "Пора спать"; activate: false }
        ListElement { time: "12:40"; description: "Томск"; activate: false }
        ListElement { time: "14:35"; description: "Четвертая пара"; activate: true }
    }
    ListModel {
        id:weather
        ListElement { day: "Пн"; date: "11.11"; temp: "15°C"; weather: "rain.png" }
        ListElement { day: "Вт"; date: "12.11"; temp: "-17°C"; weather: "sun.png" }
        ListElement { day: "Ср"; date: "13.11"; temp: "13°C"; weather: "cloud.png" }
        ListElement { day: "Чт"; date: "14.11"; temp: "19°C"; weather: "clouds.png" }
        ListElement { day: "Пт"; date: "15.11"; temp: "20°C"; weather: "lightning.png" }
    }


    SwipeView{
        id:ver_sv
        anchors.fill: parent
        orientation:Qt.Vertical


        Rectangle{
            color: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.0)
            Settings_for_Alarm{}
        }


        Rectangle{
            color: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.0)
            SwipeView{

                id:hor_sv
                anchors.fill: parent

                Rectangle{
                    color: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.0)

                }
                Rectangle{
                    color: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.0)
                    Clock{
                        x_pos:16
                        y_pos:56
                    }
                    Sensors{
                        x_pos:16
                        y_pos:56 + 236 + 16
                    }
                    Alarms{
                        x_pos:16 + 236 + 16
                        y_pos:56
                        alarms: alarms
                    }
                    Weather{
                        x_pos: 16 + 236 + 16 + 236 + 16
                        y_pos: 56 + 236 + 16
                        weather_list: weather
                    }


                }
                Rectangle{
                    color: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.0)

                }
            }
            Component.onCompleted: {
                hor_sv.currentIndex = 1
            }

        }
    }
    Component.onCompleted: {
        ver_sv.currentIndex = 1
    }
}

