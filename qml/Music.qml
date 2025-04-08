import QtQuick 2.0
import Qt5Compat.GraphicalEffects
import QtQuick.Controls

Item {
    id: music
    property int x_pos: 0
    property int y_pos: 0

    property bool currentlyPlaying: false
    signal playPauseClicked()

    property color textColor: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
    property color textColorSecond: Qt.rgba(200 / 255, 200 / 255, 200 / 255, 1.0)

    property color backgroundColor: Qt.rgba(31 / 255, 31 / 255, 35 / 255, 1.0)
    property color widColor: Qt.rgba(61 / 255, 60 / 255, 65 / 255, 1)

    property color backProgress: Qt.rgba(80 / 255, 80 / 255, 80 / 255, 1.0)

    property color choiceColor: Qt.rgba(150 / 255, 150 / 255, 150 / 255, 1.0)

    property color specialColor: Qt.rgba(20 / 255, 20 / 255, 25 / 255, 1.0)

    FontLoader {
        id: castFont
        source: "ofont.ru_Nunito.ttf"
    }

    Rectangle{
        id: rectangle
        width: 1024
        height: 600
        color: music.backgroundColor
        Image{
            width: 50
            height: 50
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 10
            anchors.topMargin: 10
            source: "resource_icon/music_icon/spotify.png"
        }
        Rectangle {
            id: rectangle1
            width: 1024/4 * 2+ 16
            height: 600 - 32
            color: music.specialColor
            radius: 15
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 16
            anchors.topMargin: 16
            clip: true
            Rectangle{
                width: 1
                height: parent.height - 20
                x: parent.width/2
                y: 10
                color: music.backProgress
            }
            Rectangle{
                width: parent.width/2
                height: parent.height
                x:0
                color: "transparent"
                Rectangle{
                    anchors.fill: parent
                    anchors.margins: 10
                    radius: 15
                    color: "transparent"
                    Row{
                        id: row2
                        width: parent.width
                        height: 32
                        spacing: 5
                        Image{
                            source: "resource_icon/music_icon/playlist.png"
                            width: 32
                            height: 32
                        }
                        Text{
                            height: 32
                            text: "Библитотека"
                            anchors.verticalCenter: parent.verticalCenter
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                            font.bold: true
                            font.pointSize: 16
                            color: music.textColorSecond
                            font.family: castFont.name
                        }
                    }
                    Rectangle{
                        height: 1
                        width: parent.width
                        y: 36
                        color: music.backProgress
                    }
                    ListView{
                        id: playlists
                        y: 46
                        width: parent.width
                        height: parent.height - 46
                        spacing: 3
                        clip: true
                        snapMode: ListView.SnapToItem
                        // model: ListModel {
                        //     ListElement { name: "mea maxima culpa"; autor: "pyrokinesis"; image: "pyro.png"}
                        // }
                        model:spotify.playlists_list
                        delegate: Rectangle {
                            id: delegateRect
                            height: 60
                            width: parent.width
                            color: ListView.isCurrentItem ? music.choiceColor : "transparent"
                            radius: 10

                            Row {
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.leftMargin: 5
                                anchors.rightMargin: 5
                                spacing: 10

                                OpacityMask {
                                    id: roundedImageEffect2
                                    width: 50
                                    height: 50
                                    anchors.verticalCenter: parent.verticalCenter
                                    source: Image {
                                        id: imageSource2
                                        width: roundedImageEffect2.width
                                        height: roundedImageEffect2.height
                                        source: modelData["icon"]
                                        fillMode: Image.PreserveAspectCrop
                                        visible: false
                                    }
                                    maskSource: Rectangle {
                                        id: imageMaskShape2
                                        width: roundedImageEffect2.width
                                        height: roundedImageEffect2.height
                                        radius: 8
                                        visible: false
                                    }
                                }

                                Column {
                                    id: textColumn
                                    anchors.verticalCenter: parent.verticalCenter
                                    spacing: -5
                                    Text {
                                        text: modelData["name"]
                                        font.pointSize: 16
                                        color: music.textColor
                                        font.family: castFont.name
                                        elide: Text.ElideRight
                                        width: delegateRect.width - roundedImageEffect2.width - parent.spacing - 10
                                    }
                                    Text {
                                        text: modelData["artists"]
                                        font.pointSize: 14
                                        color: music.textColorSecond
                                        font.family: castFont.name
                                        elide: Text.ElideRight
                                        width: delegateRect1.width - roundedImageEffect1.width - parent.spacing - 10
                                    }
                                }
                            }
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    playlists.currentIndex = index;
                                    spotify.scan_playlist_tracks(modelData["id"])
                                }
                            }
                        }
                    }
                }
            }

            Rectangle{
                width: parent.width/2
                height: parent.height
                x: parent.width/2
                color: "transparent"
                Rectangle{
                    id: rectangle2
                    anchors.fill: parent
                    anchors.margins: 10
                    radius: 15
                    color: "transparent"
                    Row{
                        id: row3
                        width: parent.width
                        height: 32
                        spacing: 5
                        Image{
                            source: "resource_icon/music_icon/lib.png"
                            width: 32
                            height: 32
                        }
                        Text{
                            height: 32
                            text: "Треки"
                            anchors.verticalCenter: parent.verticalCenter
                            verticalAlignment: Text.AlignVCenter
                            font.bold: true
                            font.pointSize: 16
                            color: music.textColorSecond
                            font.family: castFont.name
                        }
                    }
                    Rectangle{
                        height: 1
                        width: parent.width
                        y: 36
                        color: music.backProgress
                    }
                    ListView{
                        id: songs
                        y: 46
                        width: parent.width
                        height: parent.height - 46
                        spacing: 3
                        clip: true
                        snapMode: ListView.SnapToItem
                        // model: ListModel {
                        //     ListElement { name: "моя великая вина"; autor: "pyrokinesis"; image: "pyro.png"}
                        //     ListElement { name: "темная сторона Бога"; autor: "pyrokinesis"; image: "pyro.png"}
                        //     ListElement { name: "похвала бичам"; autor: "pyrokinesis"; image: "pyro.png"}
                        //     ListElement { name: "ее влюбенные глаза"; autor: "pyrokinesis"; image: "pyro.png"}
                        //     ListElement { name: "день рождение наоборот"; autor: "pyrokinesis"; image: "pyro.png"}
                        //     ListElement { name: "50 на 50"; autor: "pyrokinesis"; image: "pyro.png"}
                        //     ListElement { name: "Апокалипсис Андрея"; autor: "pyrokinesis"; image: "pyro.png"}
                        //     ListElement { name: "mea maxima culpa"; autor: "pyrokinesis"; image: "pyro.png"}
                        //     ListElement { name: "дьявол в деталях"; autor: "pyrokinesis"; image: "pyro.png"}
                        // }
                        model:spotify.tracks
                        delegate: Rectangle {
                            id: delegateRect1
                            height: 60
                            width: parent.width
                            color: ListView.isCurrentItem ? music.choiceColor: "transparent"
                            radius: 10
                            Row {
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.leftMargin: 5
                                anchors.rightMargin: 5
                                spacing: 10
                                OpacityMask {
                                    id: roundedImageEffect1
                                    width: 50
                                    height: 50

                                    anchors.verticalCenter: parent.verticalCenter
                                    source: Image {
                                        id: imageSource1
                                        width: roundedImageEffect1.width
                                        height: roundedImageEffect1.height
                                        source: modelData["icon"]
                                        fillMode: Image.PreserveAspectCrop
                                        visible: false
                                    }
                                    maskSource: Rectangle {
                                        id: imageMaskShape1
                                        width: roundedImageEffect1.width
                                        height: roundedImageEffect1.height
                                        radius: 8
                                        visible: false
                                    }
                                }

                                Column {
                                    id: textColumn1
                                    anchors.verticalCenter: parent.verticalCenter
                                    spacing: -5
                                    Text {
                                        text: modelData["name"]
                                        font.pointSize: 16
                                        color: music.textColor
                                        font.family: castFont.name
                                        elide: Text.ElideRight
                                        width: delegateRect1.width - roundedImageEffect1.width - parent.spacing - 10
                                    }
                                    Text {
                                        text: modelData["artists"]
                                        font.pointSize: 14
                                        color: music.textColorSecond
                                        font.family: castFont.name
                                        elide: Text.ElideRight
                                        width: delegateRect1.width - roundedImageEffect1.width - parent.spacing - 10
                                    }
                                }
                            }
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    songs.currentIndex = index;
                                    spotify.set_track(modelData["id"])
                                }
                            }
                        }
                    }
                }
            }
        }
        Column{
            id: column
            width: 1024 - 1024/4*2 - 16* 4
            // height: 600 - 16*2
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 16
            spacing: 20
            // Image {
            //     id: imageSource
            //     width: 250
            //     height: 250
            //     source: spotify.current["icon"]
            //     fillMode: Image.PreserveAspectCrop
            //     anchors.horizontalCenter: parent.horizontalCenter
            //     visible: true
            // }
            OpacityMask {
                id: roundedImageEffect
                width: 250
                height: 250
                anchors.horizontalCenter: parent.horizontalCenter
                source: Image {
                    id: imageSource
                    width: roundedImageEffect.width
                    height: roundedImageEffect.height
                    source: spotify.current["icon"]
                    fillMode: Image.PreserveAspectCrop
                    visible: false
                }
                maskSource: Rectangle {
                    id: imageMaskShape
                    width: roundedImageEffect.width
                    height: roundedImageEffect.height
                    radius: 15
                    visible: false
                }
            }


            Column{
                spacing: -5
                anchors.horizontalCenter: parent.horizontalCenter
                Text{
                    id: name
                    font.pixelSize: 32
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: spotify.current["name"]//"темная сторона Бога"
                    font.family: castFont.name
                    color: music.textColor
                }
                Text{
                    id: autor
                    font.pixelSize: 24
                    anchors.horizontalCenter: parent.horizontalCenter
                    text:spotify.current["artists"] //"pyrokinesis"
                    font.family: castFont.name
                    color: music.textColorSecond
                }
            }

            Row{
                spacing: 5
                anchors.horizontalCenter: parent.horizontalCenter
                Rectangle {
                    id: rectangle6
                    width: 80
                    height: 80
                    color: "transparent"
                    anchors.verticalCenter: parent.verticalCenter
                    Image{
                        width: 40
                        height: 40
                        anchors.verticalCenter: parent.verticalCenter
                        source:"resource_icon/music_icon/shaffle_off.png"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    SequentialAnimation {
                        id: playAnimation6
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
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            playAnimation6.start()
                        }
                    }
                }
                Rectangle {
                    id: rectangle4
                    width: 80
                    height: 80
                    color: "transparent"
                    anchors.verticalCenter: parent.verticalCenter
                    Image{
                        width: 60
                        height: 60
                        anchors.verticalCenter: parent.verticalCenter
                        source:"resource_icon/music_icon/rewind.png"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    SequentialAnimation {
                        id: playAnimation1
                        PropertyAnimation {
                            target: rectangle4
                            property: "scale"
                            duration: 100
                            to: 0.8
                        }

                        PropertyAnimation {
                            target: rectangle4
                            property: "scale"
                            duration: 100
                            to: 1
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            playAnimation1.start()
                        }
                    }
                }
                Rectangle {
                    id: rectangle3
                    width: 80
                    height: 80
                    color: music.specialColor
                    radius: 50
                    Image{
                        width: 60
                        height: 60
                        anchors.verticalCenter: parent.verticalCenter
                        source:music.currentlyPlaying ? "resource_icon/music_icon/pause.png" : "resource_icon/music_icon/play.png"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    SequentialAnimation {
                        id: playAnimation
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
                    MouseArea {
                        anchors.fill: parent
                        anchors.topMargin: 0
                        onClicked: {
                            spotify.change_track_status()
                            music.playPauseClicked()
                            playAnimation.start()
                        }
                    }
                }
                Rectangle {
                    id: rectangle5
                    width: 80
                    height: 80
                    color: "transparent"
                    anchors.verticalCenter: parent.verticalCenter
                    Image{
                        width: 60
                        height: 60
                        anchors.verticalCenter: parent.verticalCenter
                        source:"resource_icon/music_icon/next.png"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    SequentialAnimation {
                        id: playAnimation2
                        PropertyAnimation {
                            target: rectangle5
                            property: "scale"
                            duration: 100
                            to: 0.8
                        }
                        PropertyAnimation {
                            target: rectangle5
                            property: "scale"
                            duration: 100
                            to: 1
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        anchors.topMargin: 0
                        onClicked: {
                            playAnimation2.start()
                            spotify.next_track()
                        }
                    }
                }
                Rectangle {
                    id: rectangle8
                    width: 80
                    height: 80
                    color: "transparent"
                    anchors.verticalCenter: parent.verticalCenter
                    Image{
                        width: 40
                        height: 40
                        anchors.verticalCenter: parent.verticalCenter
                        source:"resource_icon/music_icon/repeat_off.png"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    SequentialAnimation {
                        id: playAnimation8
                        PropertyAnimation {
                            target: rectangle8
                            property: "scale"
                            duration: 100
                            to: 0.8
                        }

                        PropertyAnimation {
                            target: rectangle8
                            property: "scale"
                            duration: 100
                            to: 1
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            playAnimation8.start()
                        }
                    }
                }
            }
            Row{
                id: row1
                spacing: 10
                anchors.horizontalCenter: parent.horizontalCenter
                Text{
                    height: 28
                    font.pixelSize: 20
                    text: "0:52"
                    anchors.verticalCenter: parent.verticalCenter
                    font.family: castFont.name
                    color: music.textColor
                }
                ProgressBar {
                    id: progressBar
                    to: 100
                    value: 34
                    anchors.verticalCenter: parent.verticalCenter
                    background: Rectangle {
                        implicitWidth: 300
                        implicitHeight: 10
                        color: music.backProgress
                        radius: 5
                    }

                    contentItem: Item {
                        implicitWidth: 300
                        implicitHeight: 10
                        Rectangle {
                            width: progressBar.visualPosition * parent.width
                            height: parent.height
                            radius: 5
                            color: music.textColor
                        }
                    }
                }
                Text{
                    font.pixelSize: 20
                    text: "2:32"
                    anchors.verticalCenter: parent.verticalCenter
                    font.family: castFont.name
                    color: music.textColor
                }
            }
        }
    }

}
