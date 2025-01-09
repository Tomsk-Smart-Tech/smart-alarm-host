import QtQuick 2.0

Item {
    id:settings
    property int x_pos: 0
    property int y_pos: 0


    Rectangle{
        id: panel
        x: 16
        y: 16
        width:1024 - 32
        height:600 - 32
        color:Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.0)

        Loader{
            id:loader
            x:16*2 + 1024/3 - 16*2
            y:0
            width:1024 - 32 - 1024/3 - 16 + 16
            height:600 - 32
        }

        Rectangle{
            id:left_panel
            x:panel.x - 16
            y:panel.y + 70
            width:1024/3 - 16
            height:panel.height - 70 - 16
            radius: 15
            color:Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.6)

            ListView{

                id:listSettings
                visible: true

                anchors.margins: 15
                focus: false
                antialiasing: false
                smooth: true
                anchors.fill: parent
                spacing:5
                clip: true


                model:ListModel
                {
                    // ListElement{name:"General settings"}
                    ListElement{name:"Wi-fi"}
                    ListElement{name:"Bluetooth"}
                    ListElement{name:"Звук"}
                    ListElement{name:"Дата и время"}
                    ListElement{name:"Кастомизация"}
                    ListElement{name:"Хранилище"}
                }
                delegate: Rectangle{
                    id:rect

                    width: ListView.view.width
                    height: ListView.view.height/6

                    radius: 15
                    color: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 0.2)

                    anchors.margins:15


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
                        color: "white"
                        font.family: castFont.name
                        // font.bold:true
                        anchors.left: parent.left
                        anchors.leftMargin: 90
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if (model.name === "Wi-fi") {
                                loader.source = "Wi-Fi_Page.qml";
                            } else if (model.name === "Bluetooth") {
                                loader.source = "Bluetooth_Page.qml";
                            } else if (model.name === "Звук") {
                                loader.source = "Sound_Page.qml";
                            } else if (model.name === "Дата и время") {
                                loader.source = "Date_and_time_Page.qml";
                            } else if (model.name === "Кастомизация") {
                                loader.source = "Color_Page.qml";
                            } else if (model.name === "Хранилище") {
                                loader.source = "Storage_Page.qml";
                            }
                        }
                    }
                }
            }
        }
        Rectangle{
            x:settings.x_pos
            y:settings.y_pos
            radius : 15
            width:1024/3 - 16
            height:70
            color:Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.6)
            FontLoader {
                id: castFont1
                source: "ofont.ru_Nunito.ttf"
            }
            Text {
                font.family: castFont1.name
                text: "Настройки"
                font.pointSize: 30
                color: "white"
                anchors.centerIn:parent
            }
        }

        // Rectangle{
        //     x:settings.x_pos + 1024/3
        //     y:settings.y_pos
        //     width:2
        //     height:600
        //     color:Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1)
        // }

        // Rectangle{
        //     x:settings.x_pos
        //     y:settings.y_pos + 600
        //     width:1024/3
        //     height:2
        //     color:Qt.rgba(150 / 255, 150 / 255, 150 / 255, 1)
        // }
        // Rectangle{
        //     x:settings.x_pos
        //     y:settings.y_pos + 100
        //     width:1024/3
        //     height:2
        //     color:Qt.rgba(150 / 255, 150 / 255, 150 / 255, 1)
        // }


    }
}

