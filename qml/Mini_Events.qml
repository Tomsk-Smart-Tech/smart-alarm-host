import QtQuick 2.0
import Qt5Compat.GraphicalEffects

Item {
    id: miniEvents

    property int x_pos: 10
    property int y_pos: 10

    property color textColor: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
    property color textColorSecond: Qt.rgba(200 / 255, 200 / 255, 200 / 255, 1.0)

    property color widColorAlphaFirst: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.6)
    property color widColorAlphaSecond: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 0.22)

    property Image background: valueOf
    property int blur: 20

    FontLoader {
        id: castFont
        source: "ofont.ru_Nunito.ttf"
    }

    Rectangle {
        id: blurRect
        x: miniEvents.x_pos
        y: miniEvents.y_pos
        width: 236
        height: 236
        radius : 15
        color: miniEvents.widColorAlphaFirst
        layer.enabled: true
        ListView{
            anchors.fill: parent
            anchors.margins: 10
            model: mqttclient.events.slice(0, 5)
            width: 236 - 10* 2
            clip: true
            spacing: 10
            snapMode: ListView.SnapToItem
            delegate: Rectangle{
                color: miniEvents.widColorAlphaSecond
                width: 236 - 10* 2
                // height: 120
                height: (236-20-20)/3
                radius: 15
                Column{
                    id: column
                    anchors.fill: parent
                    anchors.margins: 7
                    width: 236 - 10* 2
                    Text{
                        text:modelData["title"]
                        font.family: castFont.name
                        font.pixelSize: 22
                        color: miniEvents.textColor
                        wrapMode: Text.NoWrap
                        elide: Text.ElideRight
                        width: parent.width
                    }
                    Text{
                        text:modelData["starttime"] + " - " + modelData["endtime"]
                        font.family: castFont.name
                        font.pixelSize: 16
                        color: miniEvents.textColorSecond
                        wrapMode: Text.Wrap
                    }
                }
            }
        }
    }
}
