import QtQuick 2.0
import QtQuick.Controls

Item {
    id: alarm
    property int x_pos: 0
    property int y_pos: 0
    property ListModel alarms: ListModel{}

    Rectangle {
        id: rec2
        x: alarm.x_pos
        y: alarm.y_pos
        width: 236
        height: 488
        radius: 15
        color: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.6)
        Column {
            anchors.fill: parent
            anchors.margins: 10
            spacing: 10

            Rectangle {
                id: header
                width: parent.width
                height: 50
                radius: 15
                color: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 0.22)

                FontLoader {
                    id: castFont
                    source: "ofont.ru_Nunito.ttf"
                }

                Text {
                    anchors.centerIn: parent
                    text: "Через 3ч 55мин"
                    font.pointSize: 14
                    font.family: castFont.name
                    color: "white"
                }
            }

            Rectangle{
                id: rec_page
                width: parent.width
                height: parent.height - 60
                visible: true
                color: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 0.0)
                ListView {
                    id: listView
                    anchors.fill: parent
                    spacing: 10
                    clip: true
                    model: alarm.alarms
                    delegate: Rectangle {
                        id:rect
                        width: parent.width
                        height: 94
                        radius: 15
                        color: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 0.22)

                        FontLoader {
                            id: castFont1
                            source: "ofont.ru_Nunito.ttf"
                        }
                        Text {
                            anchors.left: parent.left
                            anchors.top: parent.top
                            anchors.leftMargin: 10
                            text: model.time
                            font.pointSize: 30
                            font.family: castFont1.name
                            color: "white"
                        }
                        Switch {
                            id: list_switch
                            x: 140
                            y: 20
                            checked: model.activate
                            indicator : Rectangle{
                                anchors.centerIn: parent
                                implicitWidth: 50
                                implicitHeight: 30
                                radius:15
                                color: list_switch.checked ? Qt.rgba(180 / 255, 180 / 255, 180 / 255, 1) : Qt.rgba(50 / 255, 50 / 255, 50 / 255, 1)
                                // border.color: Qt.rgba(50 / 255, 50 / 255, 50 / 255, 1)
                                // border.width: 2


                                Rectangle{
                                    x: list_switch.checked ? parent.width - width - 2 : 2
                                    y: 2
                                    width:26
                                    height:26
                                    radius:13

                                    color: list_switch.down ? Qt.rgba(255 / 255, 255 / 255, 255 / 255, 0.5) : Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1)

                                }
                            }
                        }
                        Text {
                            // x: 10
                            // y: 60
                            anchors.left: parent.left
                            anchors.bottom: parent.bottom
                            anchors.leftMargin: 10
                            text: model.description
                            font.pointSize: 18
                            font.family: castFont1.name
                            color: "white"
                            elide: Text.ElideRight
                            width: parent.width - 10
                        }

                    }


                }
            }
        }
    }
}









