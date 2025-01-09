
import QtQuick 2.0

Item {
        width: 400
        height: 300

        ListView {
            id: settingsList
            anchors.fill: parent
            model: ListModel {
                ListElement { name: "Wi-Fi" }
                ListElement { name: "Bluetooth" }
                ListElement { name: "Звук" }
                ListElement { name: "Дата и время" }
                ListElement { name: "Кастомизация" }
                ListElement { name: "Хранилище" }
            }

            delegate: Rectangle {
                id: rect
                width: parent.width
                height: 50
                color: ListView.isCurrentItem ? "#2196F3" : "transparent" // Синий фон для выбранного элемента
                border.color: ListView.isCurrentItem ? "#1976D2" : "#E0E0E0" // Бордюр для выбранного элемента
                radius: 5
                anchors.horizontalCenter: parent.horizontalCenter

                Row {
                    anchors.fill: parent
                    spacing: 10


                    Text {
                        text: model.name
                        color: ListView.isCurrentItem ? "white" : "#333333" // Белый цвет текста для выбранного
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        settingsList.currentIndex = index // Установить выбранный элемент
                    }
                }
            }

            highlight: Rectangle { // Эффект подсветки при смене
                color: "transparent"
            }
        }
}
