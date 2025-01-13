import QtQuick 2.0
import QtQuick.Controls 2.15

Item {
    property color backgroundColor: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.3)
    property color textColor: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
    property color textColorSecond: Qt.rgba(200 / 255, 200 / 255, 200 / 255, 1.0)
    id: calendar
    Rectangle{
        id:rec
        width: 1024
        height: 600
        color: Qt.rgba(50/255, 50/255, 50/255, 0.5)

        ScrollView {
            id: scrollView
            contentWidth: 1024 - 32
            anchors.fill: parent
            anchors.margins: 16
            ScrollBar.vertical.policy: ScrollBar.AlwaysOff
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            Column {
                width: parent.width
                spacing: 20
                Repeater {
                    id: repeater
                    //model: mqqtclient.events
                    model: mqttclient.events
                    delegate: Rectangle {
                        id: rectangle5
                        color: calendar.backgroundColor
                        radius: 15
                        width: parent.width
                        height: column.implicitHeight + 24
                        FontLoader {
                            id: castFont
                            source: "ofont.ru_Nunito.ttf"
                        }
                        Column {
                            id: column
                            width: parent.width
                            anchors {
                                left: parent.left
                                right: parent.right
                                top: parent.top
                                margins: 12
                            }
                            spacing: 10

                            Row {
                                id: row
                                width: parent.width
                                spacing: 0

                                Column {
                                    width: parent.width / 2

                                    Text {
                                        text: modelData["title"]
                                        font.pixelSize: 32
                                        horizontalAlignment: Text.AlignLeft
                                        color: calendar.textColor
                                        width: parent.width
                                        wrapMode: Text.Wrap
                                        font.bold: true
                                        font.family: castFont.name
                                    }

                                    Text {
                                        text: modelData["starttime"] + " - " + modelData["endtime"]
                                        font.pixelSize: 24
                                        color: calendar.textColorSecond
                                        width: parent.width
                                        wrapMode: Text.Wrap
                                        font.family: castFont.name
                                    }

                                    Text {
                                        text: "Огранизатор: " + modelData["organizer"]
                                        font.pixelSize: 24
                                        color: calendar.textColorSecond
                                        width: parent.width
                                        wrapMode: Text.Wrap
                                        font.family: castFont.name
                                    }
                                }

                                Column {
                                    id: column1
                                    width: parent.width / 2
                                    spacing: 5

                                    Text {
                                        text: modelData["location"]
                                        font.pixelSize: 24
                                        horizontalAlignment: Text.AlignRight
                                        color: calendar.textColorSecond
                                        width: parent.width
                                        wrapMode: Text.Wrap
                                        font.family: castFont.name
                                    }
                                }
                            }

                            Text {
                                id: description
                                width: parent.width
                                text: modelData["description"]
                                wrapMode: Text.Wrap
                                color: calendar.textColor
                                font.pixelSize: 24
                                font.family: castFont.name
                            }
                        }
                    }
                }
            }
        }
    }
}
