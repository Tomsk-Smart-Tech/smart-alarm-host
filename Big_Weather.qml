import QtQuick 2.0
import QtQuick.Controls 2.15

Item {
    id: weather
    property int x_pos: 0
    property int y_pos: 16
    property color backgroundColor: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.3)
    property color textColor: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 1.0)
    property string currect_temp: "+3"
    property string currect_temp_up: "+3"
    property string currect_temp_down: "+3"

    property string humidity: "+3"
    property string wind: "+3"
    property string non_temp: "+3"

    property string sunrise: "+3"
    property string sunset: "+3"
    property string dew_point: "+3"
    property string uv: "+3"
    property string rain_sensor: "+3"
    Rectangle{
        x: weather.x_pos
        y: weather.y_pos
        width: 1024
        height: 600 - 32

        FontLoader {
            id: castFont
            source: "ofont.ru_Nunito.ttf"
        }
        color: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.0)

        ScrollView {
            contentWidth: parent.width
            anchors.fill: parent

            ScrollBar.vertical.policy: ScrollBar.AlwaysOff
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            Column {
                spacing: 16
                width: parent.width - 32
                anchors.horizontalCenter: parent.horizontalCenter
                Rectangle{
                    width: parent.width
                    height: 178
                    color: weather.backgroundColor
                    radius: 15
                    anchors.margins: 30
                    Row {
                        x: 21
                        y: 23
                        spacing: 30
                        Image {
                            anchors.verticalCenter: parent.verticalCenter
                            source: "sun.png"
                            width: 120
                            height: 120
                        }
                        Column {
                            // spacing: 8
                            Text {
                                text: weather.currect_temp + "°C"
                                font.pointSize: 48
                                color: weather.textColor
                                anchors.horizontalCenter: parent.horizontalCenter
                                font.family: castFont.name
                            }
                            Row{
                                Image {
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: 28
                                    height: 28
                                    source: "weather_icon/low.png"
                                }
                                Text {
                                    text: weather.currect_temp_down + "°C"
                                    font.pointSize: 24
                                    color: weather.textColor
                                    font.family: castFont.name
                                }
                                Text {
                                    text: qsTr("  ")
                                    font.pointSize: 24
                                    color: weather.textColor
                                    font.family: castFont.name
                                }
                                Image {
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: 28
                                    height: 28
                                    source: "weather_icon/up.png"
                                }
                                Text {
                                    text: weather.currect_temp_up + "°C"
                                    font.pointSize: 24
                                    color: weather.textColor
                                    font.family: castFont.name
                                }
                            }

                        }
                    }
                    Column{
                        x: 833
                        y: 22
                        Row{
                            Image {
                                width: 45
                                height: 45
                                source: "weather_icon/humidity.png"
                            }
                            Text {
                                text: qsTr("  ")
                                font.pointSize: 24
                                color: weather.textColor
                                font.family: castFont.name
                            }
                            Text {
                                text: weather.humidity
                                font.pointSize: 24
                                color: weather.textColor
                                font.family: castFont.name
                            }
                        }
                        Row{
                            Image {
                                width: 45
                                height: 45
                                source: "weather_icon/wind.png"
                            }
                            Text {
                                text: qsTr("  ")
                                font.pointSize: 24
                                color: weather.textColor
                                font.family: castFont.name
                            }
                            Text {
                                text: weather.wind
                                font.pointSize: 24
                                color: weather.textColor
                                font.family: castFont.name
                            }
                        }
                        Row{
                            Image {
                                width: 45
                                height: 45
                                source: "weather_icon/temp.png"
                            }
                            Text {
                                text: qsTr("  ")
                                font.pointSize: 24
                                color: weather.textColor
                                font.family: castFont.name
                            }
                            Text {
                                text: weather.non_temp
                                font.pointSize: 24
                                color: weather.textColor
                                font.family: castFont.name
                            }
                        }
                    }
                }
                Rectangle{
                    width: parent.width
                    height: 178
                    color: weather.backgroundColor
                    radius: 15
                }
                Rectangle{
                    width: parent.width
                    height: 178
                    color: weather.backgroundColor
                    radius: 15
                }
                Row{
                    spacing: 16
                    Column{
                        spacing: 16
                        Rectangle{
                            id: rectangle
                            width: 236
                            height: 81
                            color: weather.backgroundColor
                            radius: 15
                            Image {
                                width: 64
                                height: 64
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 12
                                source: "weather_icon/sunrise.png"
                                anchors.verticalCenterOffset: 0
                            }
                            Text {
                                text: weather.sunrise
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 12
                                font.pointSize: 36
                                color: weather.textColor
                                font.family: castFont.name
                            }

                        }
                        Rectangle{
                            id: rectangle1
                            width: 236
                            height: 81
                            color: weather.backgroundColor
                            radius: 15
                            Image {
                                width: 64
                                height: 64
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 12
                                source: "weather_icon/sunset.png"
                                anchors.verticalCenterOffset: 0
                            }
                            Text {
                                text: weather.sunset
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.right: parent.right
                                anchors.rightMargin: 12
                                font.pointSize: 36
                                color: weather.textColor
                                font.family: castFont.name
                            }
                        }
                    }
                    Rectangle{
                        id: rectangle2
                        width: 236
                        height: 178
                        color: weather.backgroundColor
                        radius: 15
                        Image {
                            anchors.left: parent.left
                            anchors.top: parent.top
                            anchors.leftMargin: 12
                            anchors.topMargin: 12
                            source: "weather_icon/dew_point.png"
                        }
                        Text {
                            text: weather.dew_point
                            anchors.right: parent.right
                            anchors.bottom: parent.bottom
                            anchors.rightMargin: 12
                            anchors.bottomMargin: 12
                            font.pointSize: 36
                            color: weather.textColor
                            font.family: castFont.name
                        }
                    }
                    Rectangle{
                        width: 236
                        height: 178
                        color: weather.backgroundColor
                        radius: 15
                        Image {
                            anchors.left: parent.left
                            anchors.top: parent.top
                            anchors.leftMargin: 12
                            anchors.topMargin: 12
                            source: "weather_icon/UV.png"
                        }
                        Text {
                            text: weather.uv
                            anchors.right: parent.right
                            anchors.bottom: parent.bottom
                            anchors.rightMargin: 12
                            anchors.bottomMargin: 12
                            font.pointSize: 36
                            color: weather.textColor
                            font.family: castFont.name
                        }
                    }
                    Rectangle{
                        width: 236
                        height: 178
                        color: weather.backgroundColor
                        radius: 15
                        Image {
                            anchors.left: parent.left
                            anchors.top: parent.top
                            anchors.leftMargin: 12
                            anchors.topMargin: 12
                            source: "weather_icon/rain_sensor.png"
                        }
                        Text {
                            text: weather.rain_sensor
                            anchors.right: parent.right
                            anchors.bottom: parent.bottom
                            anchors.rightMargin: 12
                            anchors.bottomMargin: 12
                            font.pointSize: 36
                            color: weather.textColor
                            font.family: castFont.name
                        }
                    }
                }

            }

        }
    }
}
