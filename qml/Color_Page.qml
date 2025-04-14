import QtQuick 2.15
import QtQuick.Controls
import Themes 1.0


Item {
    id: color_set
    property color backgroundColor: Qt.rgba(31 / 255, 31 / 255, 35 / 255, 1.0)
    property color widColor: Qt.rgba(61 / 255, 60 / 255, 65 / 255, 1)

    property color textColor: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
    property color textColorSecond: Qt.rgba(200 / 255, 200 / 255, 200 / 255, 1.0)

    property color choiceColor: Qt.rgba(150 / 255, 150 / 255, 150 / 255, 1.0)

    signal pressOccurred()
    signal releaseOccurred()


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
                Column{
                    width: scroll.width
                    spacing: 24
                    Text {
                        width: 327
                        height: 31
                        text: qsTr("Настройки темы")
                        font.pixelSize: 26
                        font.family: castFont.name
                        color: color_set.textColor
                    }
                    Column{
                        id: column1
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.leftMargin: 50
                        anchors.rightMargin: 50
                        spacing: 8
                        Row{
                            height: 100
                            anchors.horizontalCenter: parent.horizontalCenter
                            spacing: (scroll.width - 155*3 - 100) / 2
                            Column{
                                width: 155
                                spacing: 8
                                Rectangle{
                                    width: 100
                                    height: 75
                                    radius: 15
                                    color: Qt.rgba(31 / 255, 31 / 255, 35 / 255, 1.0)
                                    border.color: Qt.rgba(61 / 255, 60 / 255, 65 / 255, 1)
                                    border.width: 3
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    Text{
                                        y: 8
                                        color: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
                                        text: "Aa"
                                        font.pixelSize: 24
                                        anchors.horizontalCenterOffset: -26
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        font.family: castFont.name
                                    }
                                    Text{
                                        y: 10
                                        color: Qt.rgba(200 / 255, 200 / 255, 200 / 255, 1.0)
                                        text: "Aa"
                                        font.pixelSize: 22
                                        anchors.horizontalCenterOffset: 27
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        font.family: castFont.name
                                    }
                                    Rectangle{
                                        x: 9
                                        y: 39
                                        width: 45
                                        height: 28
                                        color: Qt.rgba(61 / 255, 60 / 255, 65 / 255, 1)
                                        radius: 13
                                    }

                                    Rectangle {
                                        x: 63
                                        y: 39
                                        width: 28
                                        height: 28
                                        color: Qt.rgba(214 / 255, 174 / 255, 73 / 255, 1)
                                        radius: 13
                                    }
                                }
                                Text {
                                    text: "Темная тема"
                                    font.pixelSize: 24
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    font.family: castFont.name
                                    color: color_set.textColorSecond
                                }
                            }
                            Column{
                                width: 155
                                spacing: 8
                                Rectangle{
                                    width: 100
                                    height: 75
                                    radius: 15
                                    color: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
                                    border.color: Qt.rgba(200 / 255, 200 / 255, 200 / 255, 1)
                                    border.width: 3
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    Text{
                                        y: 8
                                        color: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 1.0)
                                        text: "Aa"
                                        font.pixelSize: 24
                                        anchors.horizontalCenterOffset: -26
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        font.family: castFont.name
                                    }
                                    Text{
                                        y: 10
                                        color: Qt.rgba(50 / 255, 50 / 255, 50 / 255, 1.0)
                                        text: "Aa"
                                        font.pixelSize: 22
                                        anchors.horizontalCenterOffset: 27
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        font.family: castFont.name
                                    }
                                    Rectangle{
                                        x: 9
                                        y: 39
                                        width: 45
                                        height: 28
                                        color: Qt.rgba(200 / 255, 200 / 255, 200 / 255, 1)
                                        radius: 13
                                    }

                                    Rectangle {
                                        x: 63
                                        y: 39
                                        width: 28
                                        height: 28
                                        color: Qt.rgba(214 / 255, 174 / 255, 73 / 255, 1)
                                        radius: 13
                                    }
                                }
                                Text {
                                    text: "Светлая тема"
                                    font.pixelSize: 24
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    font.family: castFont.name
                                    color: color_set.textColorSecond
                                }
                            }

                        }
                        Row{
                            anchors.horizontalCenter: parent.horizontalCenter
                            height: 60
                            spacing: 148
                            RadioButton {
                                anchors.verticalCenter: parent.verticalCenter
                                checked: Themes.currentThemeName === "dark"
                                onClicked: {
                                    Themes.setTheme("dark");
                                    user.set_theme("dark")
                                    color_set.backgroundColor = Themes.backgroundColor
                                    color_set.textColor = Themes.textColorSett
                                    color_set.textColorSecond = Themes.textColorSecondSett
                                    color_set.widColor = Themes.widColor
                                    color_set.choiceColor = Themes.choiceColor
                                }
                            }
                            RadioButton {
                                anchors.verticalCenter: parent.verticalCenter
                                checked: Themes.currentThemeName === "light"
                                onClicked: {
                                    Themes.setTheme("light");
                                    user.set_theme("light")
                                    color_set.backgroundColor = Themes.backgroundColor
                                    color_set.textColor = Themes.textColorSett
                                    color_set.textColorSecond = Themes.textColorSecondSett
                                    color_set.widColor = Themes.widColor
                                    color_set.choiceColor = Themes.choiceColor
                                }
                            }
                        }

                    }
                }
                Column{
                    width: scroll.width
                    spacing: 24
                    Text {
                        width: 327
                        height: 31
                        color: color_set.textColor
                        text: qsTr("Задний фон")
                        font.pixelSize: 26
                        font.family: castFont.name
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
                            color: color_set.widColor
                            radius: 10
                        }

                        indicator: Rectangle {
                            width: 40
                            height: 40
                            radius: 10
                            color: color_set.choiceColor
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
                                color: backComboBox.highlightedIndex === index ? color_set.widColor : color_set.backgroundColor

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
            TapHandler {
                acceptedButtons: Qt.AllButtons
                onPressedChanged: {
                    if (pressed) {
                        color_set.pressOccurred()
                    } else {
                        color_set.releaseOccurred()
                    }
                }
                // TapHandler не должен мешать скроллингу или кликам внутри делегата
            }
        }
    }
}
