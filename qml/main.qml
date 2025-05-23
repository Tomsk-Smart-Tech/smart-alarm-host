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
    title: qsTr("Smart Alarm")
    //visibility: Window.FullScreen
    property var connection_status: mqttclient.connectionStatus
    // flags: Qt.Popup | Qt.NoDropShadowWindowHint | Qt.WindowStaysOnTopHint | Qt.WA_AcceptTouchEvents

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

    function switchIndex(){
        ver_sv.currentIndex = 2
        console.log("Tap on music");
    }
    function alarmSwitchIndex(){
        ver_sv.currentIndex = 1
        hor_sv.currentIndex = 1
    }
    function interactiveChanged(state){
        if (state === 0){
            ver_sv.interactive = false
            hor_sv.interactive = false
            console.log("Press")
        } else if(state === 1){
            ver_sv.interactive = true
            hor_sv.interactive = true
            console.log("Unpress")
        }

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

                onPressAlarms: window.interactiveChanged(0)
                onUnpressAlarms: window.interactiveChanged(1)
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

                        onPressAlarms: window.interactiveChanged(0)
                        onUnpressAlarms: window.interactiveChanged(1)

                        addColor: Themes.addColor
                    }
                }
                Rectangle{
                    width:600
                    height:1024
                    id: rectangle
                    color: "transparent"
                    Rectangle{
                        anchors.fill: parent
                        color: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.3)
                    }
                    Status_bar{
                        textColor: Themes.textColor
                        textColorSecond: Themes.textColorSecond
                        widColorAlpha: Themes.widColorAlpha
                        statusColor: Themes.statusColor
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

                        backgroundColor: Themes.backgroundColor
                        widColor: Themes.widColor

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

                        onPressAlarms: window.interactiveChanged(0)
                        onUnpressAlarms: window.interactiveChanged(1)
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

                        onPressAlarms: window.interactiveChanged(0)
                        onUnpressAlarms: window.interactiveChanged(1)
                    }
                    Mini_Music{
                        x_pos:16 + 236 + 16 + 236 + 16 + 236 + 16
                        y_pos:56
                        currentlyPlaying: window.isMusicPlaying
                        onPlayPauseClicked: window.togglePlayback()
                        onTapMusic: window.switchIndex()

                        textColor: Themes.textColor
                        textColorSecond: Themes.textColorSecond

                        backProgress:  Themes.backProgress

                        widColorAlphaFirst: Themes.widColorAlphaFirst

                        addColor: Themes.addColor

                        widColor: Themes.widColor

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

                        onPressAlarms: window.interactiveChanged(0)
                        onUnpressAlarms: window.interactiveChanged(1)

                        addColor: Themes.addColor
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

                onPressAlarms: window.interactiveChanged(0)
                onUnpressAlarms: window.interactiveChanged(1)

            }
        }
        onCurrentItemChanged:{
            audioplayer.stop()
        }
    }
    Component.onCompleted: {
        ver_sv.currentIndex = 1
    }
}



