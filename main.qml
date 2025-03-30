import QtQuick
import QtQuick.Controls
//import QtQuick.VirtualKeyboard


Window {
    id: window
    width: 1024
    height: 600
    visible: true
    title: qsTr("Hello World")
    // visibility: Window.FullScreen
    property color backgroundColor: Qt.rgba(30 / 255, 30 / 255, 30 / 255, 1)
    property color textColor: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
    property var connection_status: mqttclient.connectionStatus


    property bool isMusicPlaying: false
    function togglePlayback() {
        // Вызываем реальное действие в бэкенде
        // spotify.change_track_status();
        // Меняем наше центральное состояние
        window.isMusicPlaying = !window.isMusicPlaying;
        // Можно добавить лог для отладки
        console.log("Playback toggled via mainRoot function. New state:", window.isMusicPlaying);
    }

    Image {
        id: back
        source: "mounts.jpg"
        anchors.fill: parent
    }

    Rectangle{
        anchors.fill: parent
        color: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.5)
    }

    FontLoader {
        id: castFont
        source: "ofont.ru_Nunito.ttf"
    }


    SwipeView{
        id:ver_sv
        anchors.fill: parent
        orientation:Qt.Vertical
        interactive: true
        Rectangle{
            color: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.0)
            Settings_for_Alarm{
                backgroundColor: window.backgroundColor
                textColor: window.textColor
            }

        }
        Rectangle{

            color: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.0)
            SwipeView{
                id:hor_sv
                anchors.fill: parent
                // maximumFlickVelocity: 1
                Rectangle{
                    color: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.0)

                    Big_Weather{
                        textColor: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
                        currect_temp: weatherr.cur_weather["temp"]
                        humidity:weatherr.cur_weather["humidity"]+"%"
                        currect_temp_max: weatherr.cur_weather["temp_max"]
                        currect_temp_min: weatherr.cur_weather["temp_min"]
                        wind: weatherr.cur_weather["wind_speed"]+" км/ч"
                        feel_temp: weatherr.cur_weather["feels_temp"]

                        sunrise: weatherr.cur_weather["sunrise"]
                        sunset: weatherr.cur_weather["sunset"]
                        dew_point: weatherr.cur_weather["dewpoint_c"]+"°"
                        uv: weatherr.cur_weather["uv"]
                        rain_sensor: weatherr.cur_weather["total_precip"]

                        week_list: big_weather
                    }
                }
                Rectangle{
                    width:600
                    height:1024
                    id: rectangle
                    color: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.0)
                    Status_bar{}


                    Clock{
                        x_pos:16
                        y_pos:56
                        time: Qt.formatDateTime(currentDateTime, "HH:mm")
                        year:Qt.formatDateTime(currentDateTime, "dd.MM.yyyy")
                        date: getDayName(currentDateTime)
                        back: back
                    }
                    Sensors{
                        x_pos:16
                        y_pos:56 + 236 + 16
                    }
                    Alarms{
                        x_pos:16 + 236 + 16
                        y_pos:56

                    }
                    Weather{
                        x_pos: 16 + 236 + 16 + 236 + 16
                        y_pos: 56 + 236 + 16
                        weather_list: weather
                    }
                    Mini_Events{
                        x_pos:16 + 236 + 16 + 236 + 16
                        y_pos:56
                    }
                    Mini_Music{
                        x_pos:16 + 236 + 16 + 236 + 16 + 236 + 16
                        y_pos:56
                        currentlyPlaying: window.isMusicPlaying
                        onPlayPauseClicked: window.togglePlayback()
                    }


                }
                Rectangle{
                    color: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.0)
                    Big_Calendar{}
                }
            }
            Component.onCompleted: {
                hor_sv.currentIndex = 1
            }
            PageIndicator {
                id: indicator
                count: hor_sv.count
                currentIndex: hor_sv.currentIndex

                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
        Rectangle{
            id: cal
            color: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.0)
            readonly property date currentDate: new Date()
            Music{
                currentlyPlaying: window.isMusicPlaying
                onPlayPauseClicked: window.togglePlayback()
            }

        }
    }

    Component.onCompleted: {
        ver_sv.currentIndex = 1
    }
}



