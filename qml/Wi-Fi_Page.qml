import QtQuick 2.0

Item {
    id: wifi
    property color backgroundColor: Qt.rgba(240 / 255, 240 / 255, 240 / 255, 1.0)
    property color textColor: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 1.0)
    property color widColor: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
    property color textColorSecond: Qt.rgba(200 / 255, 200 / 255, 200 / 255, 1.0)

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
            color: wifi.widColor
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
                model: terminal.nets

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
                                var basePath = "resource_icon/Wi-Fi/";
                                var signalStrength = modelData["signal"];
                                var isLocked = model.lock ? "_lock" : "";
                                return basePath + "wifi" + signalStrength + isLocked + ".png";
                            }
                            smooth: true
                        }
                    }
                    Text {
                        text: modelData["name"]
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
