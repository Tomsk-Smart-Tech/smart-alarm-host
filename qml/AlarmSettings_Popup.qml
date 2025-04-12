import QtQuick 2.15
import QtQuick.Controls 2.15
import QtMultimedia 6.0
import GlobalTime 1.0
import QtQuick.Layouts 1.15

Popup {
    id: alarmDialog
    modal: true
    dim: true
    closePolicy: Popup.CloseOnPressOutside
    width: 800
    height: 500
    parent: Overlay.overlay
    anchors.centerIn: Overlay.overlay

    property color backgroundColor: Qt.rgba(70 / 255, 70 / 255, 70 / 255, 1.0)
    property color widColor: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 0.22)

    property color textColor: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 1.0)
    property color textColorSecond: Qt.rgba(200 / 255, 200 / 255, 200 / 255, 1.0)

    property color choiceColor: Qt.rgba(100 / 255, 100 / 255, 100 / 255, 1.0)

    property color switchColor: Qt.rgba(245/ 255, 178/ 255, 12/ 255, 1)

    property var volume :user.volume
    property int alarm_min
    property int alarm_hours
    property bool delete_after:false
    property var alarm_id
    property var alarm_name:""
    property var alarm_song:""
    property var selectedDays

    signal daysChanged(var days)


    function findSongIndex(songPath) {
        for (var i = 0; i < terminal.songs.length; i++) {
            if (terminal.songs[i]["songPath"] === songPath) {
                return i;
            }
        }
        if(terminal.songs.length===0)
        {
            return 0;
        }
    }

    function updateDayButtons() {
        for (var i = 0; i < day_selector_repeater.count; i++) {
            var btn = day_selector_repeater.itemAt(i);
            if (btn) {
                btn.checked = selectedDays[btn.index];
            }
        }
    }

    function show(selected_alarm)
    {
        terminal.scanSongs(songsPath);
        selectedDays=selected_alarm["repeatDays"].slice()
        alarm_name=selected_alarm["label"]
        var time_parts=selected_alarm["time"].split(":")
        updateDayButtons()
        alarm_hours=parseInt(time_parts[0])
        alarm_min=parseInt(time_parts[1])
        alarm_id=selected_alarm["id"]
        alarm_song=selected_alarm["song"]
        delete_after=selected_alarm["delete_after"]
        Qt.callLater(function() {
            list_switch.checked = delete_after;
        });
        melodyButoon.checked = false;
        soundComboBox.currentIndex=findSongIndex(alarm_song);
        alarmDialog.open();

        rectangle7.visible = false
        rectangle6.visible = true

        rectangle3.visible = true
    }

    function add_show()
    {
        terminal.scanSongs(songsPath);
        selectedDays=[false,false,false,false,false,false,false]
        updateDayButtons()
        alarm_min=GlobalTime.currentDateTime.getMinutes()
        alarm_hours=GlobalTime.currentDateTime.getHours()
        delete_after=false
        Qt.callLater(function() {
            list_switch.checked = delete_after;
        });
        alarm_song=terminal.cur_song
        soundComboBox.currentIndex=findSongIndex(alarm_song);
        alarm_name="Быстрый будильник"
        melodyButoon.checked = false;
        rectangle3.visible = false
        alarmDialog.open();

        rectangle6.visible = false
        rectangle7.visible = true
    }


    onClosed:{alarmSound.stop()}

    background: Rectangle {
        id: rectangle1
        anchors.fill: parent
        color:alarmDialog.backgroundColor
        radius: 15
    }

    contentItem: Item {
        anchors.fill: parent
        Column {
            anchors.fill: parent
            anchors.margins: 10
            spacing: 3

            Text {
                color: alarmDialog.textColorSecond
                text: qsTr("Название")
                font.pixelSize: 28
                verticalAlignment: Text.AlignVCenter
                font.family: castFont.name
            }
            Rectangle {
                width: parent.width
                height: 44
                color: alarmDialog.widColor
                radius: 10
                Text {
                    color: alarmDialog.textColor
                    text: alarmDialog.alarm_name
                    anchors.fill: parent
                    anchors.leftMargin: 12
                    font.pixelSize: 28
                    verticalAlignment: Text.AlignVCenter
                    font.family: castFont.name
                }
            }

            Text {
                color: alarmDialog.textColorSecond
                text: qsTr("Время")
                font.pixelSize: 28
                verticalAlignment: Text.AlignVCenter
                font.family: castFont.name
            }
            Rectangle{
                width: parent.width
                height: 70
                color: alarmDialog.widColor
                radius: 15
                anchors.horizontalCenter: parent.horizontalCenter
                clip: true
                Row {
                    id: row
                    height: 70
                    anchors.horizontalCenter: parent.horizontalCenter
                    Tumbler {
                        id: hoursTumbler
                        model: 24
                        currentIndex:alarmDialog.alarm_hours
                        width: 80
                        height: 75
                        visibleItemCount: 1
                        spacing: 5
                        onCurrentIndexChanged: {
                            alarmDialog.alarm_hours = currentIndex
                        }
                        delegate: Rectangle{
                            color:"transparent"
                            Text{
                                text: modelData < 10 ? "0" + modelData : modelData
                                color: alarmDialog.textColor
                                anchors.centerIn: parent
                                font.pixelSize: 45
                                font.family: castFont.name
                                opacity: Math.max(0.3, 1.0 - Math.abs(Tumbler.displacement) * 0.5)
                                Behavior on opacity {
                                    NumberAnimation { duration: 200 }
                                }
                            }
                        }
                    }
                    Text {
                        height: 69
                        text: ":"
                        font.pixelSize: 45
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignTop
                        color: alarmDialog.textColor
                        anchors.verticalCenter: parent.verticalCenter
                        font.family: castFont.name
                    }
                    Tumbler {
                        id: minutesTumbler
                        model: 60
                        width: 80
                        height: 75
                        currentIndex:alarmDialog.alarm_min
                        visibleItemCount: 1
                        onCurrentIndexChanged: {
                            alarmDialog.alarm_min = currentIndex
                        }
                        delegate: Rectangle{
                            color:"transparent"
                            Text{
                                text: modelData < 10 ? "0" + modelData : modelData
                                color: alarmDialog.textColor
                                anchors.centerIn: parent
                                font.family: castFont.name
                                font.pixelSize: 45
                                opacity: Math.max(0.3, 1.0 - Math.abs(Tumbler.displacement) * 0.5)
                                Behavior on opacity {
                                    NumberAnimation { duration: 200 }
                                }
                            }
                        }
                    }
                }
            }

            Text {
                color: alarmDialog.textColorSecond
                text: qsTr("Дни недели")
                font.pixelSize: 28
                verticalAlignment: Text.AlignVCenter
                font.family: castFont.name
            }


            ListModel {
                id: daysModel
                ListElement { day: "Пн" }
                ListElement { day: "Вт" }
                ListElement { day: "Ср" }
                ListElement { day: "Чт" }
                ListElement { day: "Пт" }
                ListElement { day: "Сб" }
                ListElement { day: "Вс" }
            }
            Rectangle{
                width: parent.width
                height: 60
                color: alarmDialog.widColor
                radius: 15
                anchors.horizontalCenter: parent.horizontalCenter

                Row {
                    anchors.fill: parent
                    anchors.margins: 7
                    spacing: 8
                    Repeater {
                        id:day_selector_repeater
                        model: daysModel
                        Button {
                            id: dayButton
                            text: model.day
                            width: parent.width/7 - 7
                            height: parent.height
                            checkable: true
                            property int index:model.index
                            checked: selectedDays[index]
                            //checked:false
                            // Component.onCompleted: {
                            //     checked = popup.selectedDays[index];
                            // }
                            background: Rectangle {
                                id: rec
                                // color: dayButton.checked ? "#cf8a29" : "#444"
                                color: dayButton.checked ? alarmDialog.switchColor : alarmDialog.backgroundColor
                                radius: 10
                            }
                            SequentialAnimation{
                                id: playAnimation
                                PropertyAnimation {
                                    target: dayButton
                                    property: "scale"
                                    duration: 100
                                    to: 0.8
                                }
                                PropertyAnimation {
                                    target: dayButton
                                    property: "scale"
                                    duration: 100
                                    to: 1
                                }
                            }
                            contentItem: Text {
                                anchors.fill: parent
                                text: parent.text
                                font.pixelSize: 30
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                color: alarmDialog.textColor
                                font.family: castFont.name
                            }
                            MouseArea {
                                id: playPauseButton2
                                anchors.fill: parent
                                onClicked: {
                                    playAnimation.start();
                                    dayButton.checked = !dayButton.checked;
                                    selectedDays[index] = dayButton.checked;
                                }
                            }
                        }
                    }
                }
            }

            Text {
                color: alarmDialog.textColorSecond
                text: qsTr("Мелодия")
                font.pixelSize: 28
                verticalAlignment: Text.AlignVCenter
                font.family: castFont.name
            }
            Row{
                id: row1
                spacing: 20
                ComboBox {
                    id: soundComboBox
                    width: 650 + 30
                    height: 40
                    model: terminal.songs
                    textRole: "songName"
                    // Component.onCompleted: {
                    //     for (var i = 0; i < terminal.songs.length; i++) {
                    //         if (terminal.songs[i]["songPath"] === alarm_song) {
                    //             soundComboBox.currentIndex = i;
                    //             break;
                    //         }
                    //     }
                    // }
                    // displayText:terminal.songs[soundComboBox.currentIndex]["songName"]



                    background: Rectangle {
                        color: alarmDialog.widColor
                        radius: 10
                    }

                    indicator: Rectangle {
                        width: 40
                        height: 40
                        radius: 10
                        color: alarmDialog.choiceColor
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        Image{
                            anchors.fill: parent
                            source: "resource_icon/special/arrow_down"
                        }
                    }

                    contentItem: Text {
                        text: soundComboBox.currentText
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                        color: alarmDialog.textColor
                        font.pixelSize: 24
                        verticalAlignment: Text.AlignVCenter
                        font.family: castFont.name
                    }

                    delegate: Item {
                        width: soundComboBox.width
                        height: 40
                        Rectangle {
                            width: parent.width
                            height: 40
                            color: soundComboBox.highlightedIndex === index ? alarmDialog.choiceColor : alarmDialog.backgroundColor

                            Text {
                                // anchors.centerIn: parent
                                anchors.fill: parent
                                anchors.leftMargin: 8
                                text: modelData["songName"]
                                color: alarmDialog.textColor
                                font.pixelSize: 24
                                font.family: castFont.name
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                soundComboBox.currentIndex = index
                                //console.log(modelData["songPath"])
                                alarm_song=modelData["songPath"]
                                terminal.set_song(modelData["songPath"])
                                soundComboBox.popup.close()
                            }
                        }
                    }
                }
                Button{
                    id: melodyButoon
                    width: 80
                    height: 40
                    checked: false
                    anchors.verticalCenter: parent.verticalCenter
                    background: Rectangle{
                        radius: 10
                        color: alarmDialog.widColor
                        Image{
                            width: 40
                            height: 40
                            anchors.centerIn: parent
                            source:melodyButoon.checked ? "resource_icon/music_icon/pause.png" : "resource_icon/music_icon/play.png"
                        }
                        // Text{
                        //     color: alarmDialog.textColor
                        //     anchors.fill: parent
                        //     horizontalAlignment: Text.AlignHCenter
                        //     verticalAlignment: Text.AlignVCenter
                        //     font.pointSize: 14
                        //     // text: melodyButoon.checked ? "▐ ▌" : "►"

                        //     font.family: castFont.name
                        // }
                    }
                    SequentialAnimation{
                        id: playAnimation4
                        PropertyAnimation {
                            target: melodyButoon
                            property: "scale"
                            duration: 100
                            to: 0.8
                        }
                        PropertyAnimation {
                            target: melodyButoon
                            property: "scale"
                            duration: 100
                            to: 1
                        }
                    }
                    MouseArea {
                        id: playPauseButton1
                        anchors.fill: parent
                        onClicked: {
                            playAnimation4.start();
                            melodyButoon.checked = !melodyButoon.checked;
                            if(melodyButoon.checked===true)
                            {
                                alarmSound.play()
                            }
                            else
                            {
                                alarmSound.pause()
                            }


                        }
                    }
                }
            }


            Row{
                width: 373
                spacing: 8
                Text {
                    color: alarmDialog.textColorSecond
                    text: qsTr("Удалить после проигрывания")
                    font.pixelSize: 28
                    verticalAlignment: Text.AlignVCenter
                    font.family: castFont.name
                }
                Switch {
                    id: list_switch
                    checked: false
                    indicator : Rectangle{
                        anchors.centerIn: parent
                        implicitWidth: 50
                        implicitHeight: 30
                        radius:15
                        color: list_switch.checked ? alarmDialog.switchColor : alarmDialog.choiceColor
                        Rectangle{
                            x: list_switch.checked ? parent.width - width - 2 : 2
                            y: 2
                            width:26
                            height:26
                            radius:13
                            color: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
                        }
                    }
                    onCheckedChanged: {
                        alarmDialog.delete_after = checked
                    }
                }
            }
        }

        Rectangle {
            id: rectangle6
            width: 150
            height: 40
            color: "#67b145"
            radius: 15
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.rightMargin: 10
            anchors.bottomMargin: 10

            SequentialAnimation{
                id: playAnimation1
                PropertyAnimation {
                    target: rectangle6
                    property: "scale"
                    duration: 100
                    to: 0.8
                }
                PropertyAnimation {
                    target: rectangle6
                    property: "scale"
                    duration: 100
                    to: 1
                }
            }

            Text {
                id: _text
                color: alarmDialog.textColor
                text: qsTr("Сохранить")
                anchors.fill: parent
                anchors.topMargin: 0
                anchors.bottomMargin: 4
                font.pixelSize: 27
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: castFont.name
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    playAnimation1.start()
                    mqttclient.change_alarm(alarm_id,alarm_min,alarm_hours,alarm_song,delete_after,selectedDays)
                    alarmDialog.close()

                }
            }
        }
        Rectangle {
            id: rectangle7
            width: 150
            height: 40
            color: "#67b145"
            radius: 15
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.rightMargin: 10
            anchors.bottomMargin: 10

            SequentialAnimation{
                id: playAnimation7
                PropertyAnimation {
                    target: rectangle7
                    property: "scale"
                    duration: 100
                    to: 0.8
                }
                PropertyAnimation {
                    target: rectangle7
                    property: "scale"
                    duration: 100
                    to: 1
                }
            }

            Text {
                id: _text12
                color: alarmDialog.textColor
                text: qsTr("Создать")
                anchors.fill: parent
                anchors.topMargin: 0
                anchors.bottomMargin: 4
                font.pixelSize: 27
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: castFont.name
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    mqttclient.create_alarm(0,alarm_min,alarm_hours,alarm_song,delete_after,selectedDays,alarm_name,false)
                    playAnimation1.start()

                    alarmDialog.close()

                }
            }
        }

        Rectangle {
            id: rectangle2
            width: 145
            height: 40
            color: "#767676"
            radius: 15
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.rightMargin: 170
            anchors.bottomMargin: 10
            SequentialAnimation{
                id: playAnimation2
                PropertyAnimation {
                    target: rectangle2
                    property: "scale"
                    duration: 100
                    to: 0.8
                }
                PropertyAnimation {
                    target: rectangle2
                    property: "scale"
                    duration: 100
                    to: 1
                }
            }
            Text {
                id: _text1
                color: alarmDialog.textColor
                text: qsTr("Отменить")
                anchors.fill: parent
                anchors.topMargin: 0
                anchors.bottomMargin: 4
                font.pixelSize: 27
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: castFont.name
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    playAnimation2.start()
                    alarmDialog.close()

                }
            }
        }

        Rectangle {
            id: rectangle3
            width: 145
            height: 40
            color: "#b33b3b"
            radius: 15
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.leftMargin: 10
            anchors.bottomMargin: 10
            SequentialAnimation {
                id: playAnimation3
                PropertyAnimation {
                    target: rectangle3
                    property: "scale"
                    duration: 100
                    to: 0.8
                }

                PropertyAnimation {
                    target: rectangle3
                    property: "scale"
                    duration: 100
                    to: 1
                }
            }

            Text {
                id: _text2
                color: alarmDialog.textColor
                text: qsTr("Удалить")
                anchors.fill: parent
                anchors.topMargin: 0
                anchors.bottomMargin: 4
                font.pixelSize: 27
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: castFont.name
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    playAnimation3.start()
                    mqttclient.delete_alarm(alarm_id)
                    alarmDialog.close()

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

    MediaPlayer {
        id: alarmSound
        audioOutput: audioOutput
        source: "file://"+alarmDialog.alarm_song
        loops: MediaPlayer.Infinite
    }
    AudioOutput {
        id: audioOutput
        volume: alarmDialog.volume/100
    }
}
