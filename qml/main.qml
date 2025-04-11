import QtQuick
import QtQuick.Controls
//import QtQuick.VirtualKeyboard
import GlobalTime 1.0
import Themes 1.0


Window {
    id: window
    width: 1024
    height: 600
    visible: true
    title: qsTr("Hello World")
    //visibility: Window.FullScreen
    property var connection_status: mqttclient.connectionStatus

    // resource_icon/

    property bool isMusicPlaying: spotify.current["is_playing"] ||false
    function togglePlayback() {
        // Вызываем реальное действие в бэкенде
        // spotify.change_track_status();
        spotify.change_track_status()
        // Меняем наше центральное состояние
        window.isMusicPlaying = !window.isMusicPlaying;
        // Можно добавить лог для отладки
        console.log("Playback toggled via mainRoot function. New state:", window.isMusicPlaying);
    }

    Image {
        id: back
        source: terminal.cur_photo//"mounts.jpg"
        layer.enabled: true
        anchors.fill: parent
    }

    property int blur: 20



    FontLoader {
        id: castFont
        source: "ofont.ru_Nunito.ttf"
    }
    // Item{
    //     id: colors
    //     // Текст
    //     property color textColor: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
    //     property color textColorSecond: Qt.rgba(200 / 255, 200 / 255, 200 / 255, 1.0)
    //     // Для непрозрачных объектов
    //     property color backgroundColor: Qt.rgba(31 / 255, 31 / 255, 35 / 255, 1.0)
    //     property color widColor: Qt.rgba(61 / 255, 60 / 255, 65 / 255, 1)
    //     // Специальные
    //     property color choiceColor: Qt.rgba(150 / 255, 150 / 255, 150 / 255, 1.0)
    //     property color separatorColor: Qt.rgba(90 / 255, 90 / 255, 90 / 255, 1.0)
    //     // Для прозрачных объектов (Alpha)
    //     property color backgroundColorAlpha: Qt.rgba(50/255, 50/255, 50/255, 0.5)
    //     property color widColorAlpha: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.3)
    //     property color widColorAlphaFirst: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.6)
    //     property color widColorAlphaSecond: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 0.22)
    //     // Специальные темовые цвета
    //     property color specialColor: Qt.rgba(20 / 255, 20 / 255, 25 / 255, 1.0)
    //     property color backProgress: Qt.rgba(80 / 255, 80 / 255, 80 / 255, 1)
    // }
    // Item{
    //     id: colors
    //     // Текст
    //     property color textColor: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
    //     property color textColorSecond: Qt.rgba(200 / 255, 200 / 255, 200 / 255, 1.0)
    //     // Для непрозрачных объектов
    //     property color backgroundColor: Qt.rgba(31 / 255, 31 / 255, 35 / 255, 1.0)
    //     property color widColor: Qt.rgba(61 / 255, 60 / 255, 65 / 255, 1)
    //     // Текст для непрозрачных объектов
    //     property color textColorSett: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
    //     property color textColorSecondSett: Qt.rgba(200 / 255, 200 / 255, 200 / 255, 1.0)
    //     // Специальные
    //     property color choiceColor: Qt.rgba(150 / 255, 150 / 255, 150 / 255, 1.0)
    //     property color separatorColor: Qt.rgba(90 / 255, 90 / 255, 90 / 255, 1.0)
    //     // Для прозрачных объектов (Alpha)
    //     property color backgroundColorAlpha: Qt.rgba(50/255, 50/255, 50/255, 0.5)
    //     property color widColorAlpha: Qt.rgba(10 / 255, 10 / 255, 15 / 255, 0.5)
    //     property color widColorAlphaFirst: Qt.rgba(10 / 255, 10 / 255, 15 / 255, 0.8)
    //     property color widColorAlphaSecond: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 0.22)
    //     // Специальные темовые цвета
    //     property color specialColor: Qt.rgba(20 / 255, 20 / 255, 25 / 255, 1.0)
    //     property color backProgress: Qt.rgba(80 / 255, 80 / 255, 80 / 255, 1)
    //     property color switchColor: Qt.rgba(214 / 255, 174 / 255, 73 / 255, 1)
    // }
    // Item{
    //     id: colors
    //     // Текст
    //     property color textColor: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
    //     property color textColorSecond: Qt.rgba(220 / 255, 220 / 255, 220 / 255, 1.0)
    //     // Для непрозрачных объектов
    //     property color backgroundColor: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
    //     property color widColor: Qt.rgba(200 / 255, 200 / 255, 200 / 255, 1)
    //     // Текст для непрозрачных объектов
    //     property color textColorSett: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 1.0)
    //     property color textColorSecondSett: Qt.rgba(50 / 255, 50 / 255, 50 / 255, 1.0)
    //     // Специальные
    //     property color choiceColor: Qt.rgba(150 / 255, 150 / 255, 150 / 255, 1.0)
    //     property color separatorColor: Qt.rgba(90 / 255, 90 / 255, 90 / 255, 1.0)
    //     // Для прозрачных объектов (Alpha)
    //     property color backgroundColorAlpha: Qt.rgba(50/255, 50/255, 50/255, 0.5)
    //     property color widColorAlpha: Qt.rgba(100 / 255, 100 / 255, 105 / 255, 0.8)
    //     property color widColorAlphaFirst: Qt.rgba(100 / 255, 100 / 255, 105 / 255, 0.8)
    //     property color widColorAlphaSecond: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 0.3)
    //     // Специальные темовые цвета
    //     property color specialColor: Qt.rgba(20 / 255, 20 / 255, 25 / 255, 1.0)
    //     property color backProgress: Qt.rgba(80 / 255, 80 / 255, 80 / 255, 1)
    //     // Для переключателей
    //     property color switchColor: Qt.rgba(214 / 255, 174 / 255, 73 / 255, 1)
    // }


    Rectangle{
        anchors.fill: parent
        color: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.3)
    }
    SwipeView{
        id:ver_sv
        anchors.fill: parent
        orientation:Qt.Vertical
        interactive: true
        Rectangle{
            color: "transparent"
            Settings_for_Alarm{
                backgroundColor: Themes.backgroundColor
                textColor: Themes.textColorSett
                textColorSecond: Themes.textColorSecondSett
                choiceColor: Themes.choiceColor
                separatorColor: Themes.separatorColor
                widColor: Themes.widColor
                switchColor: Themes.switchColor
            }
        }
        Rectangle{
            color: "transparent"
            SwipeView{
                id:hor_sv
                anchors.fill: parent
                // maximumFlickVelocity: 1
                Rectangle{
                    color: "transparent"
                    Big_Weather{
                        background: back


                        backgroundColorAlpha: Themes.backgroundColorAlpha
                        widColorAlpha: Themes.widColorAlpha
                        textColor: Themes.textColor
                        textColorSecond: Themes.textColorSecond

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
                    color: "transparent"
                    Status_bar{
                        textColor: Themes.textColor
                        textColorSecond: Themes.textColorSecond
                        // widColorAlpha: colors.widColorAlpha
                    }
                    Clock{
                        x_pos:16
                        y_pos:56
                        background: back
                        time: Qt.formatDateTime(currentDateTime, "HH:mm")
                        year:Qt.formatDateTime(currentDateTime, "dd.MM.yyyy")
                        date: getDayName(currentDateTime)

                        textColor: Themes.textColor
                        textColorSecond: Themes.textColorSecond

                        widColorAlphaFirst: Themes.widColorAlphaFirst
                        widColorAlphaSecond: Themes.widColorAlphaSecond
                        blur: window.blur
                    }
                    Sensors{
                        x_pos:16
                        y_pos:56 + 236 + 16

                        textColor: Themes.textColor
                        textColorSecond: Themes.textColorSecond

                        widColorAlphaFirst: Themes.widColorAlphaFirst
                        widColorAlphaSecond: Themes.widColorAlphaSecond

                        background: back
                        blur: window.blur
                    }
                    Alarms{
                        x_pos:16 + 236 + 16
                        y_pos:56

                        backgroundColor: Themes.backgroundColor
                        widColor: Themes.widColor

                        textColor: Themes.textColor
                        textColorSecond: Themes.textColorSecond

                        textColorSett: Themes.textColorSett
                        textColorSecondSett: Themes.textColorSecondSett

                        separatorColor: Themes.separatorColor

                        choiceColor: Themes.choiceColor

                        widColorAlphaFirst: Themes.widColorAlphaFirst
                        widColorAlphaSecond: Themes.widColorAlphaSecond

                        switchColor: Themes.switchColor

                        background: back
                        blur: window.blur
                    }
                    Weather{
                        x_pos: 16 + 236 + 16 + 236 + 16
                        y_pos: 56 + 236 + 16
                        weather_list: weather

                        textColor: Themes.textColor
                        textColorSecond: Themes.textColorSecond

                        widColorAlphaFirst: Themes.widColorAlphaFirst
                        widColorAlphaSecond: Themes.widColorAlphaSecond

                        background: back
                        blur: window.blur
                    }
                    Mini_Events{
                        x_pos:16 + 236 + 16 + 236 + 16
                        y_pos:56

                        textColor: Themes.textColor
                        textColorSecond: Themes.textColorSecond

                        widColorAlphaFirst: Themes.widColorAlphaFirst
                        widColorAlphaSecond: Themes.widColorAlphaSecond

                        background: back
                        blur: window.blur
                    }
                    Mini_Music{
                        x_pos:16 + 236 + 16 + 236 + 16 + 236 + 16
                        y_pos:56
                        currentlyPlaying: window.isMusicPlaying
                        onPlayPauseClicked: window.togglePlayback()

                        textColor: Themes.textColor
                        textColorSecond: Themes.textColorSecond

                        backProgress:  Themes.backProgress

                        widColorAlphaFirst: Themes.widColorAlphaFirst

                        background: back
                        blur: window.blur
                    }
                }
                Rectangle{
                    color: "transparent"
                    Big_Calendar{
                        textColor: Themes.textColor
                        textColorSecond: Themes.textColorSecond

                        backgroundColorAlpha: Themes.backgroundColorAlpha
                        widColorAlpha: Themes.widColorAlpha
                    }
                }
            }
            Component.onCompleted: {
                hor_sv.currentIndex = 1
            }
            PageIndicator {
                id: indicatormusic
                count: hor_sv.count
                currentIndex: hor_sv.currentIndex

                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
        Rectangle{
            id: cal
            color: "transparent"
            readonly property date currentDate: new Date()
            Music{
                currentlyPlaying: window.isMusicPlaying
                onPlayPauseClicked: window.togglePlayback()

                textColor: Themes.textColorSett
                textColorSecond: Themes.textColorSecondSett

                backgroundColor: Themes.backgroundColor
                widColor: Themes.widColor

                backProgress: Themes.backProgress

                choiceColor: Themes.choiceColor

                specialColor: Themes.specialColor
            }
        }
    }
    Component.onCompleted: {
        ver_sv.currentIndex = 1
    }
}



