import QtQuick 2.0
import QtQuick.Controls

Item {
    id: color_set
    property color backgroundColor: Qt.rgba(240 / 255, 240 / 255, 240 / 255, 1.0)
    property color widColor: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 0.22)

    property color textColor: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 1.0)
    property color textColorSecond: Qt.rgba(200 / 255, 200 / 255, 200 / 255, 1.0)

    property color choiceColor: Qt.rgba(100 / 255, 100 / 255, 100 / 255, 1.0)


    function findPhotoIndex(photoPath) {
        for (var i = 0; i < terminal.photos.length; i++) {
            if (terminal.photos[i]["photoPath"] === photoPath) {
                return i;
            }
        }
    }

    Rectangle{
        id:rec
        anchors.fill: parent
        color: color_set.backgroundColor
        FontLoader {
            id: castFont
            source: "ofont.ru_Nunito.ttf"
        }
        Text{
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            text:"Кастомизация"
            font.family: castFont.name
            font.pointSize:30
            color: color_set.textColor
        }
        ScrollView {
            id: scroll
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 20
            anchors.rightMargin: 20
            anchors.topMargin: 74
            anchors.bottomMargin: 20

            ScrollBar.vertical.policy: ScrollBar.AlwaysOff
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            Column{
                id: column
                width: scroll.width
                spacing: 10
                Text {
                    width: 327
                    height: 31
                    text: qsTr("Задний фон")
                    font.pixelSize: 24
                    font.family: castFont.name
                    color: color_set.textColor
                }
                Image{
                    id: back_image
                    // width: 350
                    // height: 184
                    width: parent.width
                    height: back_image.width / 1.77
                    source: terminal.cur_photo
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                ComboBox {
                    id: backComboBox
                    width: parent.width
                    height: 40
                    textRole: "photoName"
                    model: terminal.photos
                    currentIndex:findPhotoIndex(terminal.cur_photo);

                    background: Rectangle {
                        color: color_set.choiceColor
                        radius: 10
                    }

                    indicator: Rectangle {
                        width: 40
                        height: 40
                        radius: 10
                        color: color_set.textColor
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        Image{
                            anchors.fill: parent
                            source: "resource_icon/special/arrow_down"
                        }
                    }


                    contentItem: Text {
                        text: backComboBox.currentText
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                        color: color_set.textColor
                        font.pixelSize: 24
                        verticalAlignment: Text.AlignVCenter
                        font.family: castFont.name
                    }

                    delegate: Item {
                        width: column.width
                        height: 40

                        Rectangle {
                            width: parent.width
                            height: 40
                            color: color_set.highlightedIndex === index ? color_set.choiceColor : color_set.backgroundColor

                            Text {
                                // anchors.centerIn: parent
                                anchors.fill: parent
                                anchors.leftMargin: 8
                                text: modelData["photoName"]
                                color:  color_set.textColor
                                font.pixelSize: 24
                                font.family: castFont.name
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                backComboBox.currentIndex = index
                                //console.log(modelData["songPath"])
                                terminal.set_photo(modelData["photoPath"])
                                backComboBox.popup.close()
                            }
                        }
                    }
                }
            }
        }
    }
}
