import QtQuick 2.0
import QtQuick.Controls

Item {
    id: page
    property color backgroundColor: Qt.rgba(240 / 255, 240 / 255, 240 / 255, 1.0)
    property color textColor: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 1.0)
    property color textColorSecond: Qt.rgba(200 / 255, 200 / 255, 200 / 255, 1.0)
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

        ScrollView {
            anchors.fill: parent
            anchors.leftMargin: 12
            anchors.rightMargin: 12
            anchors.topMargin: 74

            ScrollBar.vertical.policy: ScrollBar.AlwaysOff
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            Column {
                anchors.fill: parent
                spacing: 20

                Text {
                    width: parent.width
                    text: "Выбор города"
                    font.family: castFont.name
                    font.pixelSize: 26
                    color: page.textColor
                }

                Row {
                    id: row
                    width: parent.width
                    height: 40
                    Text {
                        text: qsTr("Регион:")
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 24
                        font.family: castFont.name
                        color: page.textColorSecond
                    }
                    ComboBox {
                        id: regionComboBox
                        width: 500
                        height: 40
                        anchors.right: parent.right
                        textRole: "region"
                        model: ListModel {
                            id: regionModel
                        }

                        background: Rectangle {
                            color: Qt.rgba(100 / 255, 100 / 255, 100 / 255, 1.0)
                            radius: 10
                        }

                        indicator: Rectangle {
                            width: 40
                            height: 40
                            radius: 10
                            color: "#e5e5e5"
                            anchors.right: parent.right
                            anchors.top: parent.top

                            Text {
                                anchors.centerIn: parent
                                text: "▼"
                                color: Qt.rgba(100 / 255, 100 / 255, 100 / 255, 1.0)
                                font.family: castFont.name
                                font.pixelSize: 24
                            }
                        }

                        contentItem: Text {
                            text: regionComboBox.currentText
                            color: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
                            font.pixelSize: 24
                            verticalAlignment: Text.AlignVCenter
                            font.family: castFont.name
                        }

                        delegate: Item {
                            width: 500
                            height: 40
                            Rectangle {
                                anchors.fill: parent
                                color: Qt.rgba(100 / 255, 100 / 255, 100 / 255, 1.0)

                                Row {
                                    spacing: 10
                                    anchors.verticalCenter: parent.verticalCenter

                                    Text {
                                        text: model.region // Отображаем имя региона
                                        color: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
                                        font.pixelSize: 24
                                        verticalAlignment: Text.AlignVCenter
                                        font.family: castFont.name
                                    }
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        regionComboBox.currentIndex = index
                                        regionComboBox.popup.close()
                                    }
                                }
                            }
                        }

                        onCurrentIndexChanged: {
                            cityModel.clear();  // Очищаем модель городов

                            if (currentIndex >= 0) {
                                var region = regionModel.get(currentIndex);

                                if (region.cities && region.cities.count) {
                                    for (var i = 0; i < region.cities.count; i++) {
                                        var city = region.cities.get(i);
                                        if (city && city.name) {
                                            cityModel.append({ name: city.name });
                                        } else {
                                            console.error("Некорректный объект города:", city);
                                        }
                                    }
                                } else {
                                    console.error("Некорректные данные для городов:", region.cities);
                                }
                            }
                        }
                    }
                }
                Row {
                    id: row1
                    width: parent.width
                    height: 40
                    Text {
                        text: qsTr("Город:")
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 24
                        font.family: castFont.name
                        color: page.textColorSecond
                    }
                    ComboBox {
                        id: cityComboBox
                        width: 500
                        height: 40
                        anchors.right: parent.right
                        textRole: "name"
                        model: cityModel

                        background: Rectangle {
                            color: Qt.rgba(100 / 255, 100 / 255, 100 / 255, 1.0)
                            radius: 10
                        }

                        indicator: Rectangle {
                            width: 40
                            height: 40
                            radius: 10
                            color: "#e5e5e5"
                            anchors.right: parent.right
                            anchors.top: parent.top

                            Text {
                                anchors.centerIn: parent
                                text: "▼"
                                color: Qt.rgba(100 / 255, 100 / 255, 100 / 255, 1.0)
                                font.family: castFont.name
                                font.pixelSize: 24
                            }
                        }

                        contentItem: Text {
                            text: cityComboBox.currentText
                            color: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
                            font.pixelSize: 24
                            verticalAlignment: Text.AlignVCenter
                            font.family: castFont.name
                        }

                        delegate: Item {
                            width: 500
                            height: 40
                            Rectangle {
                                anchors.fill: parent
                                color: Qt.rgba(100 / 255, 100 / 255, 100 / 255, 1.0)

                                Row {
                                    spacing: 10
                                    anchors.verticalCenter: parent.verticalCenter

                                    Text {
                                        text: model.name // Отображаем имя города
                                        color: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
                                        font.pixelSize: 24
                                        verticalAlignment: Text.AlignVCenter
                                        font.family: castFont.name
                                    }
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        cityComboBox.currentIndex = index
                                        cityComboBox.popup.close()
                                    }
                                }
                            }
                        }

                        onCurrentIndexChanged: {
                            var city = cityModel.get(cityComboBox.currentIndex);
                            if (city) {
                                weatherr.set_city(city.name);
                            }
                        }
                    }
                }


            }
        }

        Component.onCompleted: {
            var xhr = new XMLHttpRequest();
            //absolute ways
            //xhr.open("GET", "file:///C:/Users/kiril/Documents/raspberry_smart_alarm/russian_cities.json");
            //xhr.open("GET", "file:////home/nikita/fromgit/smart-alarm-host/russian_cities.json");
            xhr.open("GET", Qt.resolvedUrl("russian_cities.json"));
            xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
                    try {
                        var regions = JSON.parse(xhr.responseText);
                        // console.log("Загруженные регионы (JSON):", JSON.stringify(regions, null, 2));
                        regions.forEach(function(region) {
                            var cityObjects = region.cities.map(function(city) {
                                return { name: city };
                            });

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
