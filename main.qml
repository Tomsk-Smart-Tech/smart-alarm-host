import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


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
        Rectangle{
            color: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.0)
            Settings_for_Alarm{
                backgroundColor: window.backgroundColor
                textColor: window.textColor
            }

        }
        Rectangle{
            // Status_bar{}
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
                }
                Rectangle{
                    color: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.0)
                    Big_Calendar{}
                }

            }
            Component.onCompleted: {
                hor_sv.currentIndex = 1
            }
        }
        Rectangle{
            id: cal
            color: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.0)
            readonly property date currentDate: new Date()
            // MonthGrid{
            //     id: grid
            //     month: cal.currentDate.getMonth()
            //     year: cal.currentDate.getFullYear()
            //     spacing: 0

            //     readonly property int gridLineThickness: 1

            //     Layout.fillWidth: true
            //     Layout.fillHeight: true

            //     delegate: MonthGridDelegate {
            //         id: gridDelegate
            //         visibleMonth: grid.month
            //     }

            //     background: Item {
            //         x: grid.leftPadding
            //         y: grid.topPadding
            //         width: grid.availableWidth
            //         height: grid.availableHeight

            //         // Vertical lines
            //         Row {
            //             spacing: (parent.width - (grid.gridLineThickness * rowRepeater.model)) / rowRepeater.model

            //             Repeater {
            //                 id: rowRepeater
            //                 model: 7
            //                 delegate: Rectangle {
            //                     width: 1
            //                     height: grid.height
            //                     color: "#ccc"
            //                 }
            //             }
            //         }

            //         // Horizontal lines
            //         Column {
            //             spacing: (parent.height - (grid.gridLineThickness * columnRepeater.model)) / columnRepeater.model

            //             Repeater {
            //                 id: columnRepeater
            //                 model: 6
            //                 delegate: Rectangle {
            //                     width: grid.width
            //                     height: 1
            //                     color: "#ccc"
            //                 }
            //             }
            //         }
            //     }

            // }
        }

    }

    Component.onCompleted: {
        ver_sv.currentIndex = 1
    }
}

