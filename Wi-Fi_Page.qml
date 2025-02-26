import QtQuick 2.0

Item {
    id: wifi
    property color backgroundColor: Qt.rgba(240 / 255, 240 / 255, 240 / 255, 1.0)
    property color textColor: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 1.0)

    Rectangle {
        id: rec
        color: wifi.backgroundColor
        anchors.fill: parent

        FontLoader {
            id: castFont
            source: "ofont.ru_Nunito.ttf"
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            text: "Wi-Fi"
            font.family: castFont.name
            font.pointSize: 30
            color: wifi.textColor
        }

        Rectangle {
            id: rectangle
            // color: "transparent"
            radius: 15
            color: Qt.rgba(60 / 255, 60 / 255, 60 / 255, 1.0)
            anchors.fill: parent
            anchors.leftMargin: 25
            anchors.rightMargin: 25
            anchors.topMargin: 75
            anchors.bottomMargin: 25
            clip: true

            ListView {
                id: list111
                anchors.fill: parent
                clip: true
                model: ListModel {
                    ListElement { wifiName: "Wi-Fi 1"; signal: "1"; lock: true }
                    ListElement { wifiName: "Wi-Fi 2"; signal: "2"; lock: true }
                    ListElement { wifiName: "Wi-Fi 3"; signal: "1"; lock: false }
                    ListElement { wifiName: "Wi-Fi 4"; signal: "3"; lock: false }
                    ListElement { wifiName: "Wi-Fi 5"; signal: "3"; lock: true }
                    ListElement { wifiName: "Wi-Fi 6"; signal: "1"; lock: false }
                    ListElement { wifiName: "Wi-Fi 7"; signal: "1"; lock: true }
                    ListElement { wifiName: "Wi-Fi 8"; signal: "2"; lock: true }
                    ListElement { wifiName: "Wi-Fi 9"; signal: "1"; lock: false }
                    ListElement { wifiName: "Wi-Fi 10"; signal: "3"; lock: false }
                    ListElement { wifiName: "Wi-Fi 11"; signal: "3"; lock: true }
                    ListElement { wifiName: "Wi-Fi 12"; signal: "1"; lock: false }

                }

                delegate: Rectangle {
                    width: ListView.view.width
                    height: 72
                    color: "transparent"
                    Rectangle{
                        width: parent.width
                        height: parent.height
                        color: "transparent"
                        anchors.topMargin: 15
                        anchors.leftMargin: 15
                        Image {
                            id: wifiIcon
                            anchors.leftMargin: 15
                            anchors.topMargin: 15
                            width: 42
                            height: 42
                            anchors.left: parent.left
                            anchors.top: parent.top
                            source: {
                                var basePath = "Wi-Fi/";
                                var signalStrength = model.signal;
                                var isLocked = model.lock ? "_lock" : "";
                                return basePath + "wifi" + signalStrength + isLocked + ".png";
                            }
                            smooth: true
                        }
                    }
                    Text {
                        text: model.wifiName
                        anchors.centerIn: parent
                        font.pointSize: 24
                        font.family: castFont.name
                        color: wifi.textColor
                    }

                    Rectangle {
                        x: 15
                        width: parent.width - 30
                        height: 1
                        color: Qt.rgba(100 / 255, 100 / 255, 100 / 255, 1.0)
                        anchors.bottom: parent.bottom
                        visible: model.index < list111.model.count - 1
                        clip: true

                    }
                }
            }
        }
    }
}
