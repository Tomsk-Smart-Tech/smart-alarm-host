import QtQuick 2.0
import QtQuick.Controls
import QtQuick.VirtualKeyboard

Item {
    id: bar
    property color textColor: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
    property color textColorSecond: Qt.rgba(200 / 255, 200 / 255, 200 / 255, 1.0)

    property color backColor: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
    property color backColorSecond: Qt.rgba(200 / 255, 200 / 255, 200 / 255, 1.0)
    property color backColorThird: Qt.rgba(200 / 255, 200 / 255, 200 / 255, 0.1)

    property color barColor: Qt.rgba(30 / 255, 30 / 255, 30 / 255, 0.4)


    property color widColor: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.6)
    property color widColorSecond: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 0.22)

    property color specialColor: Qt.rgba(70 / 255, 70 / 255, 70 / 255, 0.5)

    property int x_pos: 0
    property int y_pos: 0
    Rectangle{
        id: rectangle
        x: bar.x_pos
        y: bar.y_pos
        width: 1024
        height: 40
        color: bar.barColor
        Rectangle{
            id: connection
            width: 20
            height: 20
            radius: 10
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.rightMargin: 10
            anchors.bottomMargin: 10
            border.color: bar.textColorSecond
            color : Qt.rgba(242/255, 73/255, 84/255, 1.0)
            // source: window.connection_status === 1 ? "connection/phone_connection.png" : "connection/no_phone_connection.png"
            Connections {
                target: mqttclient
                function onConnectionStatusChanged() {
                    if (mqttclient.connectionStatus=== 1) {
                        console.log("city ->", weatherr.city);
                        connection.color = Qt.rgba(154/255, 247/255, 134/255, 1.0);
                        weatherr.request_position()
                    }
                }
            }
        }
        // Rectangle {
        //     id: downArrowButton
        //     width: 80
        //     height: 40
        //     color: "transparent"
        //     anchors.left: parent.left
        //     anchors.top: parent.top

        //     // Анимация движения вверх и вниз
        //     SequentialAnimation {
        //         id: bounceAnimation
        //         running: true
        //         loops: Animation.Infinite

        //         NumberAnimation {
        //             target: downArrowButton
        //             property: "y"
        //             from: downArrowButton.y
        //             to: downArrowButton.y - 8
        //             duration: 800
        //             easing.type: Easing.OutQuad
        //         }

        //         NumberAnimation {
        //             target: downArrowButton
        //             property: "y"
        //             from: downArrowButton.y - 8
        //             to: downArrowButton.y
        //             duration: 800
        //             easing.type: Easing.InQuad
        //         }
        //     }

        //     // Стрелка вниз
        //     Canvas {
        //         id: arrowCanvas
        //         anchors.fill: parent
        //         opacity: 0.7 // Полупрозрачность

        //         onPaint: {
        //             var ctx = getContext("2d");
        //             ctx.reset();
        //             ctx.strokeStyle = "#FFFFFF";
        //             ctx.lineWidth = 6;
        //             ctx.lineCap = "round";

        //             // Рисуем стрелку вниз (просто как линия)
        //             ctx.beginPath();
        //             ctx.moveTo(width * 0.3, height * 0.4);
        //             ctx.lineTo(width * 0.5, height * 0.6);
        //             ctx.lineTo(width * 0.7, height * 0.4);
        //             ctx.stroke();
        //         }
        //     }

        //     // Обработка кликов
        //     MouseArea {
        //         id: mouseArea
        //         anchors.fill: parent
        //         hoverEnabled: true
        //         onClicked: {
        //             console.log("Кнопка со стрелкой вниз нажата")
        //             // Здесь можно добавить дополнительные действия при нажатии
        //         }
        //     }

        //     // Эффект нажатия
        //     states: [
        //         State {
        //             name: "pressed"
        //             when: mouseArea.pressed
        //             PropertyChanges {
        //                 target: downArrowButton
        //                 scale: 0.9
        //             }
        //         }
        //     ]

        //     transitions: [
        //         Transition {
        //             from: ""
        //             to: "pressed"
        //             NumberAnimation {
        //                 properties: "scale"
        //                 duration: 100
        //             }
        //         },
        //         Transition {
        //             from: "pressed"
        //             to: ""
        //             NumberAnimation {
        //                 properties: "scale"
        //                 duration: 100
        //             }
        //         }
        //     ]
        // }

    }
}
