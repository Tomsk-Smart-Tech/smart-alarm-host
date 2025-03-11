import QtQuick 2.0
import QtQuick.Controls 2.15
import GlobalTime 1.0

Item {
    property color backgroundColor: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 0.3)
    property color widBackgroundColor: Qt.rgba(50/255, 50/255, 50/255, 0.5)
    property color textColor: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
    property color textColorSecond: Qt.rgba(200 / 255, 200 / 255, 200 / 255, 1.0)

    property var firstday_timestamp : new Date(new Date(GlobalTime.currentDateTime).setHours(0,0,0,0)).setDate(1)
    property var firstday :new Date(firstday_timestamp)


    id: calendar
    FontLoader {
        id: castFont
        source: "ofont.ru_Nunito.ttf"
    }

    function return_timestamp_of_day(date,days)
    {
        var newdate=new Date(date);
        newdate.setDate(newdate.getDate() + parseInt(days, 10));
        return newdate;
    }

    // Функция для получения первого дня месяца
    function getFirstDayOfWeek(date) {
        var firstDay = new Date(date.getFullYear(), date.getMonth(), 1).getDay();
        return firstDay === 0 ? 6 : firstDay - 1;
    }

    // Функция для получения количества дней в месяце
    function getDaysInMonth(date) {
        return new Date(date.getFullYear(), date.getMonth() + 1, 0).getDate();
    }

    function isCurrentDay(dayNumber) {
        var today = GlobalTime.currentDateTime;
        return (dayNumber === today.getDate() &&
                GlobalTime.currentDateTime.getMonth() === today.getMonth() &&
                GlobalTime.currentDateTime.getFullYear() === today.getFullYear());
    }
    function getMonthName(date)
    {
        var days = ["Январь", "Февраль", "Март", "Апрель", "Май", "Июнь", "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"];
        return days[date.getMonth()];
    }

    Rectangle{
        width: 1024 / 2
        height: 600
        color: calendar.widBackgroundColor
        Rectangle {
            x: 16
            y: 16
            height: 100 - 32
            width: 1024/2 - 32
            color: calendar.backgroundColor
            radius: 15
            Text {
                id: currentMonth
                anchors.centerIn: parent
                font.pixelSize: 36
                color: calendar.textColor
                text:{
                    getMonthName(firstday) + " " + firstday.getFullYear()
                }
                font.family: castFont.name
            }
            Rectangle {
                width: 50
                height: 50
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 10
                color: "transparent"

                Text {
                    anchors.centerIn: parent
                    text: "◀"
                    font.pixelSize: 36
                    color: calendar.textColor
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {}
                }
            }

            Rectangle {
                width: 50
                height: 50
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 10
                color: "transparent"

                Text {
                    anchors.centerIn: parent
                    text: "▶"
                    font.pixelSize: 36
                    color: calendar.textColor
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {}
                }
            }
        }
        Rectangle {
            x: 16
            y: 16 + 68 + 10
            height: 100 - 32 - 32
            width: 1024/2 - 32
            color: "transparent"
            Row{
                anchors.fill: parent
                spacing: 5
                Repeater{
                    model:ListModel {
                        ListElement { name: "ПН" }
                        ListElement { name: "ВТ" }
                        ListElement { name: "СР" }
                        ListElement { name: "ЧТ" }
                        ListElement { name: "ПТ" }
                        ListElement { name: "СБ" }
                        ListElement { name: "ВС" }
                    }
                    delegate: Rectangle {
                        width: (1024/2 - 32) / 7 - 5
                        height: parent.height
                        color: "transparent"

                        Text {
                            anchors.centerIn: parent
                            font.pixelSize: 20
                            color: index >= 5 ? Qt.rgba(250/ 255, 35/ 255, 40/ 255, 1.0) : calendar.textColor
                            text: model.name
                            font.family: castFont.name
                        }
                    }
                }
            }
        }
        Rectangle {
            y: 16 + 68 + 16
            x: 16
            width: 1024 / 2 - 32
            height: 600-100
            color: "transparent"
            Grid {
                id: grid
                columns: 7
                rows: 6
                spacing: 5
                anchors.centerIn: parent
                property int firstDay: getFirstDayOfWeek(firstday)
                property int daysInMonth: getDaysInMonth(firstday)
                Repeater {
                    id: rep
                    model: 42
                    Rectangle {
                        id: rectangle
                        width: 1024 / 2 /7 - 5 - 5
                        height: (600-100)/6 - 5 - 5 -5
                        color: calendar.backgroundColor
                        // color: rep.isCurrentItem ? Qt.rgba(100 / 255, 100 / 255, 100 / 255, 1.0) : "transparent"
                        radius: 15
                        Text {
                            id: dayText
                            anchors.centerIn: parent
                            font.pixelSize: 24
                            text: {
                                var dayNumber = index - parent.parent.firstDay + 1;
                                return (dayNumber > 0 && dayNumber <= parent.parent.daysInMonth) ? dayNumber: "";
                            }
                            color: calendar.textColor
                            font.family: castFont.name
                        }
                        Row{
                            visible: dayText.text !== ""
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 5
                            spacing: 5
                            Repeater{
                                model: mqttclient.check_eventOnDay(return_timestamp_of_day(firstday,dayText.text-1).getTime())
                                Rectangle{
                                    width: 40
                                    height: 10
                                    radius: 5
                                    border.color: "#bcccf7"
                                    border.width: 2
                                    color: "#739ef0"
                                }
                            }
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                if (dayText.text !== "") {
                                    mqttclient.get_events_onDay(return_timestamp_of_day(firstday,dayText.text-1).getTime())
                                    console.log("выбран день: " +return_timestamp_of_day(firstday,dayText.text-1).getTime()+" "+new Date(return_timestamp_of_day(firstday,dayText.text-1)).toLocaleDateString(Qt.locale("ru_RU"), "dd.MM.yyyy"))
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    Rectangle{
        id:rec
        x: 1024/2
        width: 1024/2
        height: 600
        color: calendar.widBackgroundColor

        ScrollView {
            id: scrollView
            x: parent.x
            contentWidth: 1024/2- 32
            anchors.fill: parent
            anchors.margins: 16
            ScrollBar.vertical.policy: ScrollBar.AlwaysOff
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            Column {
                width: parent.width
                spacing: 20
                Repeater {
                    id: repeater
                    //model: mqqtclient.events
                    model: mqttclient.events_onDay
                    delegate: Rectangle {
                        id: rectangle5
                        color: calendar.backgroundColor
                        radius: 15
                        width: parent.width
                        height: column.implicitHeight + 24
                        // Canvas{
                        //     id: canvas
                        //     width: parent.width
                        //     height: parent.height
                        //     onPaint: {
                        //         var ctx = canvas.getContext("2d");
                        //         ctx.strokeStyle = "#9DAEE4";
                        //         ctx.lineWidth = 2;
                        //         ctx.beginPath();
                        //         ctx.moveTo(12, 85);
                        //         ctx.lineTo(12 + 512 - 32*2 + 8, 85);
                        //         ctx.stroke();
                        //     }
                        // }
                        Column {
                            id: column
                            width: parent.width
                            anchors {
                                left: parent.left
                                right: parent.right
                                top: parent.top
                                margins: 12
                            }
                            spacing: 10

                            Row {
                                id: row
                                width: parent.width
                                spacing: 0

                                Column {
                                    width: parent.width

                                    Text {
                                        text: modelData["title"]
                                        font.pixelSize: 28
                                        horizontalAlignment: Text.AlignLeft
                                        color: calendar.textColor
                                        width: parent.width
                                        wrapMode: Text.Wrap
                                        font.bold: true
                                        font.family: castFont.name
                                    }

                                    Text {
                                        text: modelData["starttime"] + " - " + modelData["endtime"]
                                        font.pixelSize: 20
                                        color: calendar.textColorSecond
                                        width: parent.width
                                        wrapMode: Text.Wrap
                                        font.family: castFont.name
                                    }
                                    // "" "" ""
                                }

                                Column {
                                    id: column1
                                    width: parent.width / 2
                                    spacing: 5

                                    Text {
                                        text: modelData["location"]
                                        font.pixelSize: 20
                                        horizontalAlignment: Text.AlignRight
                                        color: calendar.textColorSecond
                                        width: parent.width
                                        wrapMode: Text.Wrap
                                        font.family: castFont.name
                                    }
                                }
                            }

                            Text {
                                id: description
                                width: parent.width
                                text:  modelData["desc"] !== "" ? modelData["location"] : "Нет описания"
                                wrapMode: Text.Wrap
                                color: calendar.textColor
                                font.pixelSize: 24
                                font.family: castFont.name
                            }
                        }
                    }
                }
            }
        }
    }
}
