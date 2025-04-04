import QtQuick 2.0

Item {
    id: settings
    property int x_pos: 0
    property int y_pos: 0
    property color backgroundColor: Qt.rgba(240 / 255, 240 / 255, 240 / 255, 1.0)
    property color textColor: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
    property color separatorColor: Qt.rgba(90 / 255, 90 / 255, 90 / 255, 1.0)

    Rectangle {
        id: left_panel
        x: settings.x_pos
        y: settings.y_pos + 50
        width: 1024 / 3
        height: 600 - 50
        color: settings.backgroundColor

        ListView {
            id: listSettings
            visible: true
            anchors.margins: 15
            anchors.bottomMargin: 15
            anchors.fill: parent
            spacing: 5
            clip: true

            model: ListModel {
                ListElement { name: "Wi-fi" }
                ListElement { name: "Звук" }
                ListElement { name: "Дата и время" }
                ListElement { name: "Кастомизация" }
                ListElement { name: "Хранилище" }
                ListElement { name: "Спец. настройки" }
                ListElement { name: "Об устройстве" }
            }

            delegate: Rectangle {
                width: ListView.view.width
                height: (ListView.view.height-35) / 7
                radius: 15
                color: ListView.isCurrentItem ? Qt.rgba(100 / 255, 100 / 255, 100 / 255, 1.0) : "transparent"

                anchors.margins: 8

                Image {
                    id: image
                    source: "icon_" + index + ".png"
                    width: 50
                    height: 50
                    fillMode: Image.PreserveAspectFit
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                }

                FontLoader {
                    id: castFont
                    source: "ofont.ru_Nunito.ttf"
                }

                Text {
                    text: model.name
                    font.pointSize: 18
                    color: settings.textColor
                    font.family: castFont.name
                    anchors.left: parent.left
                    anchors.leftMargin: 75
                    anchors.verticalCenter: parent.verticalCenter
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        listSettings.currentIndex = index;
                        let pages = {
                            "Wi-fi": "Wi-Fi_Page.qml",
                            "Звук": "Sound_Page.qml",
                            "Дата и время": "Date_and_time_Page.qml",
                            "Кастомизация": "Color_Page.qml",
                            "Хранилище": "Storage_Page.qml",
                            "Спец. настройки": "Alarm_Page.qml",
                            "Об устройстве": "About_Page.qml"
                        };

                        if (model.name in pages) {
                            loader.source = pages[model.name];
                            loader.item.backgroundColor = backgroundColor;
                            loader.item.textColor = textColor;

                            if (model.name === "Wi-fi") {
                                terminal.scanNets();
                            }
                            else if(model.name === "Звук"){
                                terminal.scanSongs(songsPath);
                            }
                        }
                    }
                }
            }
        }
    }



    Rectangle {
        x: 0
        y: 0
        width: 1024 / 3
        height: 55
        color: settings.backgroundColor

        FontLoader {
            id: castFont1
            source: "ofont.ru_Nunito.ttf"
        }

        Text {
            font.family: castFont1.name
            text: "Настройки"
            font.pointSize: 27
            color: settings.textColor
            anchors.centerIn: parent
        }
    }

    Loader {
        id: loader
        x: 1024 / 3
        y: 0
        width: 1024 - 1024 / 3
        height: 600
        source: "InitialPage.qml"

    }

    Rectangle {
        x: 1024/3
        y: 0
        width: 2
        height: 600
        color: settings.separatorColor
    }

}
