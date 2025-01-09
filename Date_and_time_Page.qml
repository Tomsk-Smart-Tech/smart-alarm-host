import QtQuick 2.0
import QtQuick.Controls

Item {
    property color backgroundColor: Qt.rgba(240 / 255, 240 / 255, 240 / 255, 1.0)
    property color textColor: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 1.0)
    Rectangle{
        id:rec
        anchors.fill: parent
        color: backgroundColor
        FontLoader {
            id: castFont
            source: "ofont.ru_Nunito.ttf"
        }
        Text{
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            text:"Дата и Время"
            font.family: castFont.name
            font.pointSize:30
            color: textColor
        }
        Column {
            anchors.centerIn: parent
            spacing: 20

             // Выбор региона
            ComboBox {
                id: regionComboBox
                width: 300
                textRole: "region"
                model: ListModel {
                    id: regionModel
                }

                onCurrentIndexChanged: {
                    // Очищаем список городов
                    cityModel.clear();

                    // Получаем список городов для выбранного региона
                    if (currentIndex >= 0) {
                        var cities = regionModel.get(currentIndex).cities;
                        cities.forEach(function(city) {
                            cityModel.append({ name: city });
                        });
                    }
                }
            }

                // Выбор города
            ComboBox {
                id: cityComboBox
                width: 300
                textRole: "name"
                model: ListModel {
                    id: cityModel
                }

                onCurrentIndexChanged: {
                    console.log("Выбран город:", currentText);
                }
            }
        }
        Component.onCompleted: {
                // Загружаем области и города из JSON
                var xhr = new XMLHttpRequest();
                xhr.open("GET", "C:\Users\kiril\Documents\raspberry_smart_alarm\russian_cities.json");
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === XMLHttpRequest.DONE) {
                        var regions = JSON.parse(xhr.responseText);
                        regions.forEach(function(region) {
                            regionModel.append(region);
                        });
                    }
                }
                xhr.send();
            }
    }
}
