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

        FontLoader {
            id: castFont
            source: "ofont.ru_Nunito.ttf"
        }


        ScrollView {
            contentWidth: parent.width
            anchors.fill: parent
            anchors.topMargin: 16
            anchors.bottomMargin: 16
        }
    }
}
