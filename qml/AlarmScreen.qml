import QtQuick 2.15
import QtQuick.Controls 2.15 // Указываем версию явно
import QtMultimedia 6.0
import QtQuick.Layouts 1.15 // Будем использовать Layouts
import GlobalTime 1.0 // Предполагаем, что он доступен
// import mqttclient // Предполагаем, что он доступен
// import user // Предполагаем, что он доступен
// import spotify // Предполагаем, что он доступен

Popup {
    id: alarmPopup
    modal: true
    dim: true
    focus: true
    closePolicy: Popup.NoAutoClose
    width: 1024
    height: 600


    property var cur_date : GlobalTime.currentDateTime.getDate()+" "+getMonthName(GlobalTime.currentDateTime)
    property var cur_time: "00:00" // Инициализируем
    property var label: "Будильник" // Инициализируем
    property var delay : mqttclient.get_alarm_delay()
    property var song_path: "" // Инициализируем
    property var volume : user.volume
    property var smooth_sound: user.smooth_sound

    // Загрузчик шрифтов лучше объявить один раз здесь
    FontLoader { id: castFont; source: "ofont.ru_Nunito.ttf" }

    function show(first_alarm) {
        if (!first_alarm) {
            console.error("AlarmPopup.show called with invalid data");
            return;
        }
        cur_time = first_alarm.time || "00:00";
        label = first_alarm.label || "Будильник";
        song_path = first_alarm.song || "";
        // Обновляем дату при показе, если нужно
        cur_date = GlobalTime.currentDateTime.getDate()+" "+getMonthName(GlobalTime.currentDateTime);
        // Обновляем громкость/плавность, если они могли измениться
        volume = user.volume;
        smooth_sound = user.smooth_sound;
        delay = mqttclient.get_alarm_delay();

        alarmSound.source = "file://" + song_path; // Устанавливаем источник перед открытием/воспроизведением
        alarmPopup.open();
        // Воспроизведение начнется в onOpened или по событию MediaPlayer
        // alarmSound.play(); // Можно начать здесь или в onOpened
    }

    function getMonthName(date) {
        // Проверка на валидность date, если нужно
        var days = ["Января", "Февраля", "Марта", "Апреля", "Мая", "Июня", "Июля", "Августа", "Сентября", "Октября", "Ноября", "Декабря"];
        return days[date.getMonth()];
    }

    onOpened: {
        forceActiveFocus();
    }

    onClosed: {
        alarmSound.stop(); // Останавливаем звук
        volumechanger.stop(); // Останавливаем анимацию громкости
        spotify.play_track(); // Воспроизводим Spotify
        console.log("AlarmPopup closed");
    }

    // Фон остается простым Rectangle
    background: Rectangle {
        // Не нужно id: rectangle2
        anchors.fill: parent
        color: Qt.rgba(0, 0, 0, 0.6) // Можно просто 0, 0, 0
    }

    // --- ВЕСЬ КОНТЕНТ ТЕПЕРЬ ЗДЕСЬ ---
    contentItem: Item { // Используем Item как контейнер для сложной компоновки, если нужно, или сразу Layout
        anchors.fill: parent

        // Основная колонка с использованием Layouts
        ColumnLayout {
            anchors.centerIn: parent
            width: parent.width * 0.8 // Ограничим ширину для больших экранов
            spacing: 40 // Уменьшим spacing между группами

            // Верхняя часть (Дата и Время)
            ColumnLayout {
                Layout.alignment: Qt.AlignHCenter // Центрируем эту группу
                Layout.bottomMargin: 30 // Отступ снизу до лейбла
                spacing: 5

                Text {
                    text: alarmPopup.cur_date
                    color: "#aaaaaa"
                    font.pixelSize: 30
                    font.family: castFont.name
                    Layout.alignment: Qt.AlignHCenter
                }
                Text {
                    text: alarmPopup.cur_time
                    color: "#ffffff"
                    font.pixelSize: 60
                    font.family: castFont.name
                    Layout.alignment: Qt.AlignHCenter
                }
            }

            // Лейбл
            Text {
                text: alarmPopup.label
                color: "white"
                font.pixelSize: 50
                font.family: castFont.name
                Layout.alignment: Qt.AlignHCenter
                elide: Text.ElideRight
                Layout.maximumWidth: parent.width // Ограничим ширину лейбла
            }

            // Кнопки (в своей колонке)
            ColumnLayout {
                Layout.alignment: Qt.AlignHCenter // Центрируем кнопки
                spacing: 15

                // --- Кнопка "Отложить" ---
                Button {
                    // Не нужно id: rectangle
                    text: "Отложить на " + alarmPopup.delay + " минут"
                    font.pixelSize: 25 // Подбираем размер шрифта
                    font.family: castFont.name
                    Layout.preferredWidth: 350 // Задаем желаемую ширину
                    Layout.preferredHeight: 60 // Задаем желаемую высоту
                    Layout.alignment: Qt.AlignHCenter

                    onClicked: {
                        // Проверка, что cur_time корректный
                        let timeParts = cur_time.split(":");
                        if (timeParts.length === 2) {
                            let hours = parseInt(timeParts[0], 10);
                            let minutes = parseInt(timeParts[1], 10);
                            if (!isNaN(hours) && !isNaN(minutes)) {
                                mqttclient.create_alarm(delay, minutes, hours, song_path, true, [false,false,false,false,false,false,false], label, true);
                                alarmPopup.close(); // Закрытие вызовет onClosed -> stop/play_track
                            } else {
                                console.error("Invalid cur_time format for snooze:", cur_time);
                            }
                        } else {
                             console.error("Invalid cur_time format for snooze:", cur_time);
                        }
                    }

                    background: Rectangle {
                        color: parent.pressed ? Qt.darker("#545454") : "#545454"
                        radius: 25
                    }

                    contentItem: Text {
                        text: parent.text
                        color: "#ffffff"
                        font: parent.font // Наследуем шрифт кнопки
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                // --- Кнопка "Остановить" ---
                Button {
                    // Не нужно id: rectangle1
                    text: qsTr("Остановить")
                    font.pixelSize: 25
                    font.family: castFont.name
                    Layout.preferredWidth: 300
                    Layout.preferredHeight: 60
                    Layout.alignment: Qt.AlignHCenter

                    onClicked: {
                        alarmPopup.close(); // Закрытие вызовет onClosed -> stop/play_track
                    }

                    background: Rectangle {
                        color: parent.pressed ? Qt.darker("#944f1a") : "#944f1a"
                        radius: 25
                    }

                    contentItem: Text {
                        text: parent.text
                        color: "#e4e4e4"
                        font: parent.font
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            } // Конец ColumnLayout для кнопок
        } // Конец основного ColumnLayout
    } // --- КОНЕЦ contentItem ---

    // --- MediaPlayer и AudioOutput остаются без изменений ---
    MediaPlayer {
        id: alarmSound
        audioOutput: audioOutput
        // source устанавливается в show()
        loops: MediaPlayer.Infinite // Повторять
        onPlaybackStateChanged: {
            if (playbackState === MediaPlayer.PlayingState) {
                 console.log("MediaPlayer Playing");
                if (alarmPopup.smooth_sound) {
                    console.log("Starting smooth volume increase...");
                    audioOutput.volume = 0 // Начинаем с 0
                    volumechanger.restart() // Запускаем анимацию
                } else {
                    audioOutput.volume = alarmPopup.volume / 100.0 // Устанавливаем сразу, используем 100.0 для деления с плавающей точкой
                     console.log("Setting volume directly to:", audioOutput.volume);
                }
            } else if (playbackState === MediaPlayer.StoppedState) {
                console.log("MediaPlayer Stopped");
                volumechanger.stop(); // Останавливаем анимацию на всякий случай
            }
        }
        onErrorChanged: {
            console.error("MediaPlayer Error:", error, errorString);
        }
    }

    AudioOutput {
        id: audioOutput
        volume: 0 // Начальная громкость 0, будет установлена при проигрывании
    }

    NumberAnimation {
        id: volumechanger
        target: audioOutput
        property: "volume"
        from: 0
        to: alarmPopup.volume / 100.0 // Используем 100.0
        duration: 15000 // 15 секунд
        easing.type: Easing.InQuad // Плавное начало
        running: false // Не запускать автоматически
        // Добавим лог по завершению
        onStopped: console.log("Volume animation stopped. Current volume:", audioOutput.volume)
    }
}
