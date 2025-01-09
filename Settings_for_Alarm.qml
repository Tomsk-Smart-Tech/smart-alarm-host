import QtQuick 2.0

Item {
    id: settings
    property int x_pos: 0
    property int y_pos: 0
    property color backgroundColor: Qt.rgba(240 / 255, 240 / 255, 240 / 255, 1.0)
    property color textColor: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 1.0)

    Rectangle {
        id: left_panel
        x: settings.x_pos
        y: settings.y_pos + 100
        width: 1024 / 3
        height: 600 - 100
        color: settings.backgroundColor

        ListView {
            id: listSettings
            visible: true
            anchors.margins: 15
            anchors.fill: parent
            spacing: 5
            clip: true

            model: ListModel {
                ListElement { name: "Wi-fi" }
                ListElement { name: "Bluetooth" }
                ListElement { name: "Звук" }
                ListElement { name: "Дата и время" }
                ListElement { name: "Кастомизация" }
                ListElement { name: "Хранилище" }
            }

            delegate: Rectangle {
                id: rect

                width: ListView.view.width
                height: ListView.view.height / 6
                radius: 15
                color: ListView.isCurrentItem ? Qt.rgba(200 / 255, 200 / 255, 200 / 255, 1.0) : "transparent"

                anchors.margins: 15

                Image {
                    id: image
                    source: "icon_" + index + ".png"
                    width: 50
                    height: 50
                    fillMode: Image.PreserveAspectFit
                    x: 15
                    y: 15
                }

                FontLoader {
                    id: castFont
                    source: "ofont.ru_Nunito.ttf"
                }

                Text {
                    text: model.name
                    font.pointSize: 20
                    color: settings.textColor
                    font.family: castFont.name
                    anchors.left: parent.left
                    anchors.leftMargin: 90
                    anchors.verticalCenter: parent.verticalCenter
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        listSettings.currentIndex = index // Установить выбранный элемент
                        if (model.name === "Wi-fi") {
                            loader.source = "Wi-Fi_Page.qml";
                            loader.item.backgroundColor = backgroundColor
                            loader.item.textColor = textColor
                        } else if (model.name === "Bluetooth") {
                            loader.source = "Bluetooth_Page.qml";
                            loader.item.backgroundColor = backgroundColor
                            loader.item.textColor = textColor
                        } else if (model.name === "Звук") {
                            loader.source = "Sound_Page.qml";
                            loader.item.backgroundColor = backgroundColor
                            loader.item.textColor = textColor
                        } else if (model.name === "Дата и время") {
                            loader.source = "Date_and_time_Page.qml";
                            loader.item.backgroundColor = backgroundColor
                            loader.item.textColor = textColor
                        } else if (model.name === "Кастомизация") {
                            loader.source = "Color_Page.qml";
                            loader.item.backgroundColor = backgroundColor
                            loader.item.textColor = textColor
                        } else if (model.name === "Хранилище") {
                            loader.source = "Storage_Page.qml";
                            loader.item.backgroundColor = backgroundColor
                            loader.item.textColor = textColor
                        }
                    }
                }
            }
        }
    }

    Rectangle {
        x: settings.x_pos
        y: settings.y_pos
        width: 1024 / 3
        height: 100
        color: settings.backgroundColor

        FontLoader {
            id: castFont1
            source: "ofont.ru_Nunito.ttf"
        }

        Text {
            font.family: castFont1.name
            text: "Настройки"
            font.pointSize: 30
            color: settings.textColor
            anchors.centerIn: parent
        }
    }

    // Rectangle {
    //     x: settings.x_pos + 1024 / 3
    //     y: settings.y_pos
    //     width: 2
    //     height: 600
    //     color: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1)
    // }

    Loader {
        id: loader
        x: 1024 / 3
        y: 0
        width: 1024 - 1024 / 3
        height: 600
        source: "InitialPage.qml"
    }
}
