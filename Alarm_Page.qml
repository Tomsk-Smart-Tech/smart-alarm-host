import QtQuick 2.0
import QtQuick.Controls 2.15

Item {
    id: page
    property color backgroundColor: Qt.rgba(50 / 255, 50 / 255, 50 / 255, 1.0)
    property color textColor: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)

    property color widColorSecond: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 0.22)
    Rectangle{
        id:rec
        anchors.fill: parent
        color:page.backgroundColor
        FontLoader {
            id: castFont
            source: "ofont.ru_Nunito.ttf"
        }
        Text{
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            text:"Умные будильники"
            font.family: castFont.name
            font.pointSize:30
            color: page.textColor
        }
        Column{
            id: column
            anchors.fill: parent
            anchors.leftMargin: 20
            anchors.rightMargin: 20
            anchors.topMargin: 74
            anchors.bottomMargin: 20
            spacing: 15
            Rectangle{
                id: rectangle
                width: parent.width
                height: 60
                color: page.widColorSecond
                anchors.margins: 10
                anchors.horizontalCenter: parent.horizontalCenter
                radius: 15
                clip: true
                    Row{
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        Text {
                            text: qsTr("Откладывать будильник на: ")
                            anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: 24
                            font.family: castFont.name
                            color: page.textColor
                        }
                        Tumbler {
                            id: minutesTumbler
                            model: 61
                            width: 80
                            height: 64
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.verticalCenterOffset: 0
                            visibleItemCount: 1
                            spacing: 5
                            delegate: Rectangle{
                                color:"transparent"
                                Text{
                                    text: modelData < 10 ? "0" + modelData : modelData
                                    color: page.textColor
                                    anchors.centerIn: parent
                                    font.pixelSize: 38
                                    font.family: castFont.name
                                    opacity: Math.max(0.3, 1.0 - Math.abs(Tumbler.displacement) * 0.5)
                                    Behavior on opacity {
                                        NumberAnimation { duration: 50 }
                                    }
                                }
                            }
                        }
                        Text {
                            text: qsTr("минут")
                            anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: 24
                            font.family: castFont.name
                            color: page.textColor
                        }
                    }

                    Row{
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                        Rectangle {
                            id: button
                            color: "transparent"
                            Text{
                                anchors.centerIn: parent
                                text: "▲"
                                font.pixelSize: 24
                                color: page.textColor
                            }

                            SequentialAnimation{
                                id: playAnimation
                                PropertyAnimation {
                                    target: button
                                    property: "scale"
                                    duration: 100
                                    to: 0.8
                                }
                                PropertyAnimation {
                                    target: button
                                    property: "scale"
                                    duration: 100
                                    to: 1
                                }
                            }

                            width: 50
                            height: 50
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    playAnimation.start()
                                    if (minutesTumbler.currentIndex < minutesTumbler.model - 1)
                                        minutesTumbler.currentIndex++
                                }
                            }

                        }
                        Rectangle {
                            id: button1
                            color: "transparent"
                            Text{
                                text: "▼"
                                anchors.centerIn: parent
                                font.pixelSize: 24
                                color: page.textColor
                            }
                            width: 50
                            height: 50

                            SequentialAnimation{
                                id: playAnimation1
                                PropertyAnimation {
                                    target: button1
                                    property: "scale"
                                    duration: 100
                                    to: 0.8
                                }
                                PropertyAnimation {
                                    target: button1
                                    property: "scale"
                                    duration: 100
                                    to: 1
                                }
                            }

                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    playAnimation1.start()
                                    if (minutesTumbler.currentIndex > 0)
                                        minutesTumbler.currentIndex--
                                }
                            }
                        }
                    }

            }
        }
    }
}
