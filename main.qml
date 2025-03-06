import QtQuick
import QtQuick.Controls
import QtQuick.VirtualKeyboard


Window {
    id: window
    width: 1024
    height: 600
    visible: true
    title: qsTr("Hello World")
    // visibility: Window.FullScreen
    property color backgroundColor: Qt.rgba(50 / 255, 50 / 255, 50 / 255, 1.0)
    property color textColor: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
    property var connection_status: mqttclient.connectionStatus

    Image {
        id: back
        source: "mounts.jpg"
        anchors.fill: parent
    }
    Rectangle{
        anchors.fill: parent
        color: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.5)
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
                    Image{
                        id: connection
                        width: 36
                        height: 36
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 6
                        anchors.bottomMargin: 8
                        source :"connection/no_phone_connection.png";
                        // source: window.connection_status === 1 ? "connection/phone_connection.png" : "connection/no_phone_connection.png"
                        Connections {
                            target: mqttclient
                            function onConnectionStatusChanged() {
                                if (mqttclient.connectionStatus=== 1) {
                                    console.log("city ->", weatherr.city);
                                    connection.source = "connection/phone_connection.png";
                                    weatherr.request_position()
                                }
                            }
                        }
                    }
                    // Rectangle {
                    //     id: downArrowButton
                    //     width: 80
                    //     height: 40
                    //     color: "transparent"
                    //     anchors.left: parent.left
                    //     anchors.top: parent.top

                    //     // Анимация движения вверх и вниз
                    //     SequentialAnimation {
                    //         id: bounceAnimation
                    //         running: true
                    //         loops: Animation.Infinite

                    //         NumberAnimation {
                    //             target: downArrowButton
                    //             property: "y"
                    //             from: downArrowButton.y
                    //             to: downArrowButton.y - 8
                    //             duration: 800
                    //             easing.type: Easing.OutQuad
                    //         }

                    //         NumberAnimation {
                    //             target: downArrowButton
                    //             property: "y"
                    //             from: downArrowButton.y - 8
                    //             to: downArrowButton.y
                    //             duration: 800
                    //             easing.type: Easing.InQuad
                    //         }
                    //     }

                    //     // Стрелка вниз
                    //     Canvas {
                    //         id: arrowCanvas
                    //         anchors.fill: parent
                    //         opacity: 0.7 // Полупрозрачность

                    //         onPaint: {
                    //             var ctx = getContext("2d");
                    //             ctx.reset();
                    //             ctx.strokeStyle = "#FFFFFF";
                    //             ctx.lineWidth = 6;
                    //             ctx.lineCap = "round";

                    //             // Рисуем стрелку вниз (просто как линия)
                    //             ctx.beginPath();
                    //             ctx.moveTo(width * 0.2, height * 0.5);

                    //             ctx.lineTo(width * 0.8, height * 0.5);
                    //             ctx.stroke();
                    //         }
                    //     }

                    //     // Обработка кликов
                    //     MouseArea {
                    //         id: mouseArea
                    //         anchors.fill: parent
                    //         hoverEnabled: true
                    //         onClicked: {
                    //             console.log("Кнопка со стрелкой нажата")
                    //             // Включаем interactive перед переходом на экран настроек
                    //             ver_sv.interactive = true
                    //             // Переходим на экран настроек
                    //             ver_sv.currentIndex = 0
                    //         }
                    //     }

                    //     // Эффект нажатия
                    //     states: [
                    //         State {
                    //             name: "pressed"
                    //             when: mouseArea.pressed
                    //             PropertyChanges {
                    //                 target: downArrowButton
                    //                 scale: 0.9
                    //             }
                    //         }
                    //     ]

                    //     transitions: [
                    //         Transition {
                    //             from: ""
                    //             to: "pressed"
                    //             NumberAnimation {
                    //                 properties: "scale"
                    //                 duration: 100
                    //             }
                    //         },
                    //         Transition {
                    //             from: "pressed"
                    //             to: ""
                    //             NumberAnimation {
                    //                 properties: "scale"
                    //                 duration: 100
                    //             }
                    //         }
                    //     ]
                    // }
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

        }



    }

    Component.onCompleted: {
        ver_sv.currentIndex = 1
    }
    // Connections {
    //     target: ver_sv
    //     property bool ignoreIndexChange: false

    //     function onCurrentIndexChanged() {
    //         if (!ignoreIndexChange) {
    //             ignoreIndexChange = true

    //             console.log("Индекс изменился на:", ver_sv.currentIndex)

    //             // Если текущий индекс 1 (главный экран) - отключаем свайпы
    //             if (ver_sv.currentIndex === 1) {
    //                 ver_sv.interactive = false
    //             }
    //             // Если текущий индекс 0 (экран настроек) - оставляем свайпы включенными
    //             else if (ver_sv.currentIndex === 0) {
    //                 ver_sv.interactive = true
    //             }

    //             ignoreIndexChange = false
    //         }
    //     }
    // }
}


