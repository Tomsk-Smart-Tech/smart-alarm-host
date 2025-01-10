import QtQuick 2.0
import QtQuick.Controls

Item {
    id: page
    property color backgroundColor: Qt.rgba(240 / 255, 240 / 255, 240 / 255, 1.0)
    property color textColor: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 1.0)
    property ListModel cityModel: ListModel {}

    Rectangle {
        id: rec
        anchors.fill: parent
        color: backgroundColor

        FontLoader {
            id: castFont
            source: "ofont.ru_Nunito.ttf"
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            text: "Дата и Время"
            font.family: castFont.name
            font.pointSize: 30
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
                    cityModel.clear();  // Очищаем модель городов

                    // Сбрасываем индекс выбранного города
                    // cityComboBox.currentIndex = -1;

                    if (currentIndex >= 0) {
                        var region = regionModel.get(currentIndex);
                        // console.log("Выбран регион:", JSON.stringify(region, null, 2));

                        // Преобразуем QQmlListModel в обычный массив
                        if (region.cities && region.cities.count) {
                            for (var i = 0; i < region.cities.count; i++) {
                                var city = region.cities.get(i); // Получаем объект города
                                if (city && city.name) {
                                    cityModel.append({ name: city.name });
                                } else {
                                    console.error("Некорректный объект города:", city);
                                }
                            }
                        } else {
                            console.error("Некорректные данные для городов:", region.cities);
                        }

                        console.log("Модель городов заполнена:", cityModel.count);

                    }
                }


            }

            // Выбор города
            ComboBox {
                id: cityComboBox
                width: 300
                textRole: "name"
                model: cityModel
                onCurrentIndexChanged: {
                    var city = page.cityModel.get(cityComboBox.currentIndex);
                    if (city) {
                        _text.text = "Выбран город: " + city.name;
                        weatherr.set_city(city.name)
                    } else {
                        _text.text = "Город не выбран";
                    }
                }
            }
        }

        Text {
            id: _text
            x: 252
            y: 340
            text: qsTr("Text")
            font.pixelSize: 12
        }

        Component.onCompleted: {
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "file:///C:/Users/kiril/Documents/raspberry_smart_alarm/russian_cities.json");
            xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
                    try {
                        var regions = JSON.parse(xhr.responseText);
                        console.log("Загруженные регионы (JSON):", JSON.stringify(regions, null, 2));
                        regions.forEach(function(region) {
                            // Преобразуем массив cities в массив объектов
                            var cityObjects = region.cities.map(function(city) {
                                return { name: city };
                            });

                            // Добавляем регион в модель
                            regionModel.append({
                                region: region.region,
                                cities: cityObjects
                            });
                        });
                        console.log("Модель регионов заполнена. Количество:", regionModel.count);
                    } catch (e) {
                        console.error("Ошибка при парсинге JSON:", e);
                    }
                } else if (xhr.readyState === XMLHttpRequest.DONE) {
                    console.error("Ошибка загрузки JSON. Статус:", xhr.status);
                }
            };
            xhr.send();
        }
    }
}
