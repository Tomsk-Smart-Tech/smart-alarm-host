import QtQuick

Item {
    id: root

    property var horizontalSwipeView: null
    property var verticalSwipeView: null

    property int edgeSize: 50
    property int swipeThreshold: 30

    property bool horizontalEnabled: true
    property bool verticalEnabled: true

    // Приоритеты свайпов
    property bool horizontalPriority: true

    MouseArea {
        id: touchArea
        anchors.fill: parent
        propagateComposedEvents: true

        property point startPos
        property bool swiping: false
        property bool horizontalSwipe: false
        property bool verticalSwipe: false

        onPressed: {
            startPos = Qt.point(mouse.x, mouse.y)
            swiping = false
            horizontalSwipe = false
            verticalSwipe = false

            // Проверка краевой зоны для авто-определения направления
            if (root.horizontalEnabled && (mouse.x < root.edgeSize || mouse.x > width - root.edgeSize)) {
                if (root.horizontalSwipeView) {
                    root.horizontalSwipeView.interactive = true
                }
                horizontalSwipe = true
                mouse.accepted = false
            } else if (root.verticalEnabled && (mouse.y < root.edgeSize || mouse.y > height - root.edgeSize)) {
                if (root.verticalSwipeView) {
                    root.verticalSwipeView.interactive = true
                }
                verticalSwipe = true
                mouse.accepted = false
            } else {
                // По умолчанию отключаем свайпы до определения направления
                if (root.horizontalSwipeView) {
                    root.horizontalSwipeView.interactive = false
                }
                if (root.verticalSwipeView) {
                    root.verticalSwipeView.interactive = false
                }
                mouse.accepted = true
            }
        }

        onPositionChanged: {
            if (!swiping) {
                var deltaX = mouse.x - startPos.x
                var deltaY = mouse.y - startPos.y

                // Определение направления свайпа на основе расстояния
                if (Math.abs(deltaX) > root.swipeThreshold || Math.abs(deltaY) > root.swipeThreshold) {
                    swiping = true

                    // Определяем преобладающее направление
                    if (Math.abs(deltaX) > Math.abs(deltaY)) {
                        horizontalSwipe = true
                        verticalSwipe = false

                        if (root.horizontalEnabled && root.horizontalSwipeView) {
                            root.horizontalSwipeView.interactive = true
                            if (root.verticalSwipeView) {
                                root.verticalSwipeView.interactive = false
                            }
                        }
                    } else {
                        horizontalSwipe = false
                        verticalSwipe = true

                        if (root.verticalEnabled && root.verticalSwipeView) {
                            root.verticalSwipeView.interactive = true
                            if (root.horizontalSwipeView) {
                                root.horizontalSwipeView.interactive = false
                            }
                        }
                    }

                    // Приоритет при равных условиях
                    if (Math.abs(deltaX) === Math.abs(deltaY)) {
                        if (root.horizontalPriority) {
                            horizontalSwipe = true
                            verticalSwipe = false
                            if (root.horizontalSwipeView) {
                                root.horizontalSwipeView.interactive = true
                            }
                            if (root.verticalSwipeView) {
                                root.verticalSwipeView.interactive = false
                            }
                        } else {
                            horizontalSwipe = false
                            verticalSwipe = true
                            if (root.verticalSwipeView) {
                                root.verticalSwipeView.interactive = true
                            }
                            if (root.horizontalSwipeView) {
                                root.horizontalSwipeView.interactive = false
                            }
                        }
                    }

                    mouse.accepted = false
                }
            }
        }

        onReleased: {
            // Возвращаем состояния по умолчанию
            swiping = false

            // Можно оставить интерактивность после свайпа
            // или вернуть изначальные состояния
            if (root.horizontalSwipeView) {
                root.horizontalSwipeView.interactive = false
            }
            if (root.verticalSwipeView) {
                root.verticalSwipeView.interactive = false
            }

            mouse.accepted = false
        }
    }

    // Методы для ручного управления
    function enableHorizontalSwipe(enable) {
        root.horizontalEnabled = enable
        if (root.horizontalSwipeView) {
            root.horizontalSwipeView.interactive = enable
        }
    }

    function enableVerticalSwipe(enable) {
        root.verticalEnabled = enable
        if (root.verticalSwipeView) {
            root.verticalSwipeView.interactive = enable
        }
    }

    function lockAllSwipes() {
        enableHorizontalSwipe(false)
        enableVerticalSwipe(false)
    }

    function unlockAllSwipes() {
        enableHorizontalSwipe(true)
        enableVerticalSwipe(true)
    }
}
