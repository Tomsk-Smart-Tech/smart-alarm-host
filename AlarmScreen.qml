import QtQuick
import QtQuick.Controls
import QtMultimedia 6.0

Popup {
    id: alarmPopup
    modal: true
    dim: true
    focus: true
    closePolicy: Popup.NoAutoClose
    width:  1024
    height:  600

    background: Rectangle {
        color: "black"
        opacity: 0.8
    }

    Column {
        anchors.centerIn: parent
        spacing: 20

        Text {
            text: "Будильник сработал!"
            font.pixelSize: 36
            color: "white"
        }

        Button {
            text: "Выключить"

            onClicked:
            {
                alarmSound.stop();
                alarmPopup.close();
            }
        }
    }

    MediaPlayer {
        id: alarmSound
        audioOutput: audioOutput
        source: "file:///home/nikita/Downloads/alarmtest.mp3"
        loops: MediaPlayer.Infinite
    }
    AudioOutput {
        id: audioOutput  // Создание объекта AudioOutput
        volume: 1.0  // Начальная громкость
    }

    function show() {
        alarmPopup.open();
        alarmSound.play();
    }
}
