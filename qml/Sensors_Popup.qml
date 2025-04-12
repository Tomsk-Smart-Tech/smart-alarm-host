import QtQuick 2.15
import QtQuick.Controls 2.15

Popup {
    id: sensorsPopup
    modal: true
    dim: true
    closePolicy: Popup.CloseOnPressOutside
    width: 600
    height: 350
    parent: Overlay.overlay
    anchors.centerIn: Overlay.overlay

    property string tempreture: sensorss.temp
    property string humidity_text: sensorss.humidity
    property string voc_index:sensorss.voc_index

    property color backgroundColor: Qt.rgba(70 / 255, 70 / 255, 70 / 255, 1.0)
    property color widColor: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 0.22)

    property color textColor: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 1.0)
    property color textColorSecond: Qt.rgba(200 / 255, 200 / 255, 200 / 255, 1.0)

    function show(){
        sensorsPopup.open()
    }
    background: Rectangle {
        anchors.fill: parent
        color: sensorsPopup.backgroundColor
        radius: 15
    }

    contentItem: Item {
        anchors.fill: parent
        Rectangle{
            anchors.fill: parent
            color: sensorsPopup.backgroundColor
            radius: 15
            FontLoader {
                id: castFont
                source: "ofont.ru_Nunito.ttf"
            }
            Column {
                id: column
                anchors.fill: parent
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                anchors.topMargin: 10
                anchors.bottomMargin: 10
                spacing: 10

                Rectangle {
                    id: rectangle
                    width: column.width
                    height: column.height / 3 - 20 / 3
                    color: sensorsPopup.widColor
                    radius: 15
                    border.width: 0


                    Column {
                        id: column1
                        width: 160
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.leftMargin: 8
                        anchors.topMargin: 10
                        spacing: 0

                        Row {
                            id: row
                            width: column1.width
                            height: 51
                            spacing: 10

                            Image{
                                width: 50
                                height: 50
                                source: "resource_icon/sensors/temp.png"
                            }

                            Text {
                                id: _text1
                                width: 100
                                height: 50
                                color: sensorsPopup.textColor
                                text: sensorsPopup.tempreture + "°C"
                                font.pixelSize: 39
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.family: castFont.name
                            }
                        }

                        Text {
                            id: _text
                            y: 0
                            width: row.width
                            height: 32
                            color: sensorsPopup.textColorSecond
                            text: qsTr("Температура")
                            font.pixelSize: 24
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.family: castFont.name
                        }
                    }

                    Column {
                        id: column2
                        width: 390
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                        spacing: 0

                        Text {
                            id: _text2
                            width: 390
                            height: 32
                            color: sensorsPopup.textColorSecond
                            text: qsTr("Норма температуры в комнате: 18-26°C")
                            font.pixelSize: 20
                            horizontalAlignment: Text.AlignRight
                            wrapMode: Text.WordWrap
                            font.family: castFont.name
                        }

                        Row {
                            id: row1

                            Text {
                                id: _text3
                                width: 234
                                height: 35
                                color: sensorsPopup.textColor
                                text: qsTr("Текущее состояние:")
                                font.pixelSize: 23
                                horizontalAlignment: Text.AlignRight
                                verticalAlignment: Text.AlignVCenter
                                wrapMode: Text.WordWrap
                                font.family: castFont.name
                            }

                            Text {
                                id: _text4
                                width: 155
                                height: 35
                                color: {
                                    if (parseInt(sensorsPopup.tempreture) >= 18 && parseInt(sensorsPopup.tempreture) <= 26){
                                        "#82ff66"
                                    } else if(parseInt(sensorsPopup.tempreture) > 26){
                                        "#ff3f3f"
                                    } else {
                                        "#ff3f3f"
                                    }
                                }
                                text: {
                                    if (parseInt(sensorsPopup.tempreture) >= 18 && parseInt(sensorsPopup.tempreture) <= 26){
                                        "Норма"
                                    } else if(parseInt(sensorsPopup.tempreture) > 26){
                                        "Высокая"
                                    } else {
                                        "Низкая"
                                    }
                                }
                                font.pixelSize: 24
                                horizontalAlignment: Text.AlignRight
                                verticalAlignment: Text.AlignVCenter
                                wrapMode: Text.WordWrap
                                font.family: castFont.name
                            }
                        }
                    }
                }

                Rectangle {
                    id: rectangle1
                    width: column.width
                    height: column.height / 3 - 20 / 3
                    color: sensorsPopup.widColor
                    radius: 15
                    border.width: 0
                    Column {
                        id: column3
                        width: 160
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.leftMargin: 8
                        anchors.topMargin: 10
                        spacing: 0
                        Row {
                            id: row2
                            width: column3.width
                            height: 51
                            spacing: 10
                            Image {
                                width: 50
                                height: 50
                                source: "resource_icon/sensors/humidity.png"
                            }

                            Text {
                                id: _text5
                                width: 100
                                height: 50
                                color: sensorsPopup.textColor
                                text: sensorsPopup.humidity_text + "%"
                                font.pixelSize: 39
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.family: castFont.name
                            }
                        }

                        Text {
                            id: _text6
                            y: 0
                            width: row2.width
                            height: 32
                            color: sensorsPopup.textColorSecond
                            text: qsTr("Влажность")
                            font.pixelSize: 24
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.family: castFont.name
                        }
                    }

                    Column {
                        id: column4
                        width: 390
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                        spacing: 0
                        Text {
                            id: _text7
                            width: column4.width
                            height: 32
                            color: sensorsPopup.textColorSecond
                            text: qsTr("Норма влажности в комнате: 30-50%")
                            font.pixelSize: 20
                            horizontalAlignment: Text.AlignRight
                            wrapMode: Text.WordWrap
                            font.family: castFont.name
                        }

                        Row {
                            id: row3
                            Text {
                                id: _text8
                                width: 234
                                height: 35
                                color: sensorsPopup.textColor
                                text: qsTr("Текущее состояние:")
                                font.pixelSize: 23
                                horizontalAlignment: Text.AlignRight
                                verticalAlignment: Text.AlignVCenter
                                wrapMode: Text.WordWrap
                                font.family: castFont.name
                            }

                            Text {
                                id: _text9
                                width: 155
                                height: 35
                                color: {
                                    if (parseInt(sensorsPopup.humidity_text) >= 30 && parseInt(sensorsPopup.humidity_text) <= 50){
                                        "#82ff66"
                                    } else if(parseInt(sensorsPopup.humidity_text) > 50){
                                        "#ff3f3f"
                                    } else {
                                        "#ff3f3f"
                                    }
                                }
                                text: {
                                    if (parseInt(sensorsPopup.humidity_text) >= 30 && parseInt(sensorsPopup.humidity_text) <= 50){
                                        "Норма"
                                    } else if(parseInt(sensorsPopup.humidity_text) > 50){
                                        "Высокая"
                                    } else {
                                        "Низкая"
                                    }
                                }
                                font.pixelSize: 24
                                horizontalAlignment: Text.AlignRight
                                verticalAlignment: Text.AlignVCenter
                                wrapMode: Text.WordWrap
                                font.family: castFont.name
                            }
                        }
                    }
                }

                Rectangle {
                    id: rectangle2
                    width: column.width
                    height: column.height / 3 - 20 / 3
                    color: sensorsPopup.widColor
                    radius: 15
                    border.width: 0
                    Column {
                        id: column5
                        width: 160
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.leftMargin: 8
                        anchors.topMargin: 10
                        spacing: 0
                        Row {
                            id: row4
                            width: column5.width
                            height: 51
                            spacing: 10
                            Image {
                                width: 50
                                height: 50
                                source: "resource_icon/sensors/voc.png"
                            }

                            Text {
                                id: _text10
                                width: 100
                                height: 50
                                color: sensorsPopup.textColor
                                text: sensorsPopup.voc_index
                                font.pixelSize: 39
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.family: castFont.name
                            }
                        }

                        Text {
                            id: _text11
                            y: 0
                            width: row4.width
                            height: 32
                            color: sensorsPopup.textColorSecond
                            text: qsTr("Voc")
                            font.pixelSize: 24
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.family: castFont.name
                        }
                    }

                    Column {
                        id: column6
                        width: 390
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                        spacing: 0
                        Text {
                            id: _text12
                            width: 390
                            height: 32
                            color: sensorsPopup.textColorSecond
                            text: qsTr("Норма загрязнения в комнате: 80-120")
                            font.pixelSize: 20
                            horizontalAlignment: Text.AlignRight
                            wrapMode: Text.WordWrap
                            font.family: castFont.name
                        }

                        Row {
                            id: row5
                            Text {
                                id: _text13
                                width: 234
                                height: 35
                                color: sensorsPopup.textColor
                                text: qsTr("Текущее состояние:")
                                font.pixelSize: 23
                                horizontalAlignment: Text.AlignRight
                                verticalAlignment: Text.AlignVCenter
                                wrapMode: Text.WordWrap
                                font.family: castFont.name
                            }

                            Text {
                                id: _text14
                                width: 155
                                height: 35
                                color: {
                                    if (parseInt(sensorsPopup.voc_index) >= 0 && parseInt(sensorsPopup.voc_index) <= 120){
                                        "#82ff66"
                                    } else if(parseInt(sensorsPopup.voc_index) > 120){
                                        "#ff3f3f"
                                    } else {
                                        "#ff3f3f"
                                    }
                                }
                                text: {
                                    if (parseInt(sensorsPopup.voc_index) >= 0 && parseInt(sensorsPopup.voc_index) <= 120){
                                        "Норма"
                                    } else if(parseInt(sensorsPopup.voc_index) > 120){
                                        "Высокая"
                                    } else {
                                        "Да вы чисты"
                                    }
                                }

                                font.pixelSize: 24
                                horizontalAlignment: Text.AlignRight
                                verticalAlignment: Text.AlignVCenter
                                wrapMode: Text.WordWrap
                                font.family: castFont.name
                            }
                        }
                    }
                }
            }
        }
    }
    enter: Transition {
        PropertyAnimation {
            property: "scale"
            duration: 200
            from: 0.9
            to: 1.0
            easing.type: Easing.InBack
        }
    }
    exit: Transition {
        PropertyAnimation {
            property: "scale"
            duration: 200
            from: 1.0
            to: 0.9
            easing.type: Easing.InBack
        }
    }
}
