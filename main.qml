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
                        popup: alarmDialog
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

        }
    }

    Component.onCompleted: {
        ver_sv.currentIndex = 1
    }
    Popup {
        id: alarmDialog
        modal: true
        dim: true
        closePolicy: Popup.CloseOnPressOutside
        width: 800
        height: 500
        parent: Overlay.overlay
        anchors.centerIn: Overlay.overlay

        property var selectedDays: [] // Массив выбранных дней (например, ["Пн", "Ср", "Пт"])
        signal daysChanged(var days)

        background:    Rectangle {
            id: rectangle1
            anchors.fill: parent
            color: Qt.rgba(70 / 255, 70 / 255, 70 / 255, 1.0)
            radius: 15
            Column {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 4

                Text {
                    color: "#ffffff"
                    text: qsTr("Название")
                    font.pixelSize: 32
                    verticalAlignment: Text.AlignVCenter
                    font.family: castFont.name
                }
                Rectangle {
                    width: parent.width
                    height: 60
                    color: "#555555"
                    radius: 10
                    Text {
                        color: "#ffffff"
                        text: qsTr("Хуева хуйня")
                        anchors.fill: parent
                        anchors.leftMargin: 12
                        font.pixelSize: 32
                        verticalAlignment: Text.AlignVCenter
                        font.family: castFont.name
                    }
                }

                Text {
                    color: "#ffffff"
                    text: qsTr("Время")
                    font.pixelSize: 32
                    verticalAlignment: Text.AlignVCenter
                    font.family: castFont.name
                }
                Rectangle{
                    width: parent.width
                    height: 75
                    color: "#555555"
                    radius: 15
                    anchors.horizontalCenter: parent.horizontalCenter
                    Row {
                        id: row
                        height: 85
                        anchors.horizontalCenter: parent.horizontalCenter
                        Tumbler {
                            id: hoursTumbler
                            model: 24
                            width: 80
                            height: 75
                            visibleItemCount: 1
                            spacing: 5
                            delegate: Rectangle{
                                color:"transparent"
                                Text{
                                    text: modelData < 10 ? "0" + modelData : modelData
                                    color: "white"
                                    anchors.centerIn: parent
                                    font.pixelSize: 45
                                    font.family: castFont.name
                                    opacity: Math.max(0.3, 1.0 - Math.abs(Tumbler.displacement) * 0.5)
                                    Behavior on opacity {
                                        NumberAnimation { duration: 200 }
                                    }
                                }
                            }
                        }
                        Text {
                            height: 69
                            text: ":"
                            font.pixelSize: 45
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignTop
                            color: "white"
                            anchors.verticalCenter: parent.verticalCenter
                            font.family: castFont.name
                        }
                        Tumbler {
                            id: minutesTumbler
                            model: 60
                            width: 80
                            height: 75
                            visibleItemCount: 1
                            delegate: Rectangle{
                                color:"transparent"
                                Text{
                                    text: modelData < 10 ? "0" + modelData : modelData
                                    color: "white"
                                    anchors.centerIn: parent
                                    font.family: castFont.name
                                    font.pixelSize: 45
                                    opacity: Math.max(0.3, 1.0 - Math.abs(Tumbler.displacement) * 0.5)
                                    Behavior on opacity {
                                        NumberAnimation { duration: 200 }
                                    }
                                }
                            }
                        }
                    }
                }

                Text {
                    color: "#ffffff"
                    text: qsTr("Дни недели")
                    font.pixelSize: 32
                    verticalAlignment: Text.AlignVCenter
                    font.family: castFont.name
                }


                ListModel {
                    id: daysModel
                    ListElement { day: "Пн" }
                    ListElement { day: "Вт" }
                    ListElement { day: "Ср" }
                    ListElement { day: "Чт" }
                    ListElement { day: "Пт" }
                    ListElement { day: "Сб" }
                    ListElement { day: "Вс" }
                }
                Rectangle{
                    width: parent.width
                    height: 60
                    color: "#555555"
                    radius: 15
                    anchors.horizontalCenter: parent.horizontalCenter

                    Row {
                        anchors.fill: parent
                        anchors.margins: 7
                        spacing: 8
                        Repeater {
                            model: daysModel
                            Button {
                                id: dayButton
                                text: model.day
                                width: parent.width/7 - 7
                                height: parent.height
                                checkable: true
                                background: Rectangle {
                                    color: dayButton.checked ? "#cf8a29" : "#444"
                                    radius: 10
                                }
                                contentItem: Text {
                                    anchors.fill: parent
                                    text: parent.text
                                    font.pixelSize: 30
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    color: "white"
                                    font.family: castFont.name
                                }
                                onClicked: {
                                    if (checked) {
                                        alarmDialog.selectedDays.push(model.day)
                                    } else {
                                        alarmDialog.selectedDays = alarmDialog.selectedDays.filter(d => d !== model.day)
                                    }
                                    alarmDialog.daysChanged(alarmDialog.selectedDays) // Вызываем сигнал
                                    console.log("Выбранные дни:", alarmDialog.selectedDays)
                                }
                            }
                        }
                    }
                }
            }

            Rectangle {
                id: rectangle4
                width: 150
                height: 50
                color: "#67b145"
                radius: 15
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.rightMargin: 10
                anchors.bottomMargin: 10

                SequentialAnimation{
                    id: playAnimation1
                    PropertyAnimation {
                        target: rectangle4
                        property: "scale"
                        duration: 100
                        to: 0.8
                    }
                    PropertyAnimation {
                        target: rectangle4
                        property: "scale"
                        duration: 100
                        to: 1
                    }
                }

                Text {
                    id: _text
                    color: "#ffffff"
                    text: qsTr("Сохранить")
                    anchors.fill: parent
                    anchors.topMargin: 0
                    anchors.bottomMargin: 4
                    font.pixelSize: 27
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.family: castFont.name
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        playAnimation1.start()
                        alarmDialog.close()
                    }
                }
            }

            Rectangle {
                id: rectangle2
                width: 150
                height: 50
                color: "#b33b3b"
                radius: 15
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.rightMargin: 170
                anchors.bottomMargin: 10
                SequentialAnimation{
                    id: playAnimation2
                    PropertyAnimation {
                        target: rectangle2
                        property: "scale"
                        duration: 100
                        to: 0.8
                    }
                    PropertyAnimation {
                        target: rectangle2
                        property: "scale"
                        duration: 100
                        to: 1
                    }
                }
                Text {
                    id: _text1
                    color: "#ffffff"
                    text: qsTr("Удалить")
                    anchors.fill: parent
                    anchors.topMargin: 0
                    anchors.bottomMargin: 4
                    font.pixelSize: 27
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.family: castFont.name
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        playAnimation2.start()
                        alarmDialog.close()
                    }
                }
            }
        }
        enter: Transition {
            PropertyAnimation {
                property: "scale"
                duration: 200
                from: 0.9
                to: 1.0
                easing.type: Easing.InBack
            }
        }
        exit: Transition {
            PropertyAnimation {
                property: "scale"
                duration: 200
                from: 1.0
                to: 0.9
                easing.type: Easing.InBack
            }
        }
    }
}



