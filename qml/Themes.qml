import QtQuick

pragma Singleton

QtObject {
    id: themeManager

    readonly property QtObject darkColors: QtObject {
        property color textColor: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
        property color textColorSecond: Qt.rgba(200 / 255, 200 / 255, 200 / 255, 1.0)
        // Для непрозрачных объектов
        property color backgroundColor: Qt.rgba(31 / 255, 31 / 255, 35 / 255, 1.0)
        property color widColor: Qt.rgba(61 / 255, 60 / 255, 65 / 255, 1)
        // Текст для непрозрачных объектов
        property color textColorSett: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
        property color textColorSecondSett: Qt.rgba(200 / 255, 200 / 255, 200 / 255, 1.0)
        // Специальные
        property color choiceColor: Qt.rgba(150 / 255, 150 / 255, 150 / 255, 1.0)
        property color separatorColor: Qt.rgba(90 / 255, 90 / 255, 90 / 255, 1.0)
        // Для прозрачных объектов (Alpha)
        property color backgroundColorAlpha: Qt.rgba(50/255, 50/255, 50/255, 0.5)
        property color widColorAlpha: Qt.rgba(10 / 255, 10 / 255, 15 / 255, 0.5)
        property color widColorAlphaFirst: Qt.rgba(10 / 255, 10 / 255, 15 / 255, 0.8)
        property color widColorAlphaSecond: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 0.22)
        // Специальные темовые цвета
        property color specialColor: Qt.rgba(20 / 255, 20 / 255, 25 / 255, 1.0)
        property color backProgress: Qt.rgba(80 / 255, 80 / 255, 80 / 255, 1)
        property color switchColor: Qt.rgba(214 / 255, 174 / 255, 73 / 255, 1)
    }

    readonly property QtObject lightColors: QtObject {
        property color textColor: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
        property color textColorSecond: Qt.rgba(220 / 255, 220 / 255, 220 / 255, 1.0)
        // Для непрозрачных объектов
        property color backgroundColor: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 1.0)
        property color widColor: Qt.rgba(200 / 255, 200 / 255, 200 / 255, 1)
        // Текст для непрозрачных объектов
        property color textColorSett: Qt.rgba(0 / 255, 0 / 255, 0 / 255, 1.0)
        property color textColorSecondSett: Qt.rgba(50 / 255, 50 / 255, 50 / 255, 1.0)
        // Специальные
        property color choiceColor: Qt.rgba(150 / 255, 150 / 255, 150 / 255, 1.0)
        property color separatorColor: Qt.rgba(90 / 255, 90 / 255, 90 / 255, 1.0)
        // Для прозрачных объектов (Alpha)
        property color backgroundColorAlpha: Qt.rgba(50/255, 50/255, 50/255, 0.5)
        property color widColorAlpha: Qt.rgba(100 / 255, 100 / 255, 105 / 255, 0.8)
        property color widColorAlphaFirst: Qt.rgba(100 / 255, 100 / 255, 105 / 255, 0.8)
        property color widColorAlphaSecond: Qt.rgba(255 / 255, 255 / 255, 255 / 255, 0.3)
        // Специальные темовые цвета
        property color specialColor: Qt.rgba(20 / 255, 20 / 255, 25 / 255, 1.0)
        property color backProgress: Qt.rgba(80 / 255, 80 / 255, 80 / 255, 1)
        // Для переключателей
        property color switchColor: Qt.rgba(214 / 255, 174 / 255, 73 / 255, 1)
    }


    property string currentThemeName: "dark"

    readonly property color textColor:             currentThemeName === "light" ? lightColors.textColor : darkColors.textColor
    readonly property color textColorSecond:       currentThemeName === "light" ? lightColors.textColorSecond : darkColors.textColorSecond

    // Фоны и виджеты (непрозрачные)
    readonly property color backgroundColor:       currentThemeName === "light" ? lightColors.backgroundColor : darkColors.backgroundColor
    readonly property color widColor:              currentThemeName === "light" ? lightColors.widColor : darkColors.widColor

    // Текст для непрозрачных фонов
    readonly property color textColorSett:         currentThemeName === "light" ? lightColors.textColorSett : darkColors.textColorSett
    readonly property color textColorSecondSett:   currentThemeName === "light" ? lightColors.textColorSecondSett : darkColors.textColorSecondSett

    // Специальные элементы UI
    readonly property color choiceColor:           currentThemeName === "light" ? lightColors.choiceColor : darkColors.choiceColor
    readonly property color separatorColor:        currentThemeName === "light" ? lightColors.separatorColor : darkColors.separatorColor

    // Фоны и виджеты (полупрозрачные - Alpha)
    readonly property color backgroundColorAlpha:  currentThemeName === "light" ? lightColors.backgroundColorAlpha : darkColors.backgroundColorAlpha
    readonly property color widColorAlpha:         currentThemeName === "light" ? lightColors.widColorAlpha : darkColors.widColorAlpha
    readonly property color widColorAlphaFirst:    currentThemeName === "light" ? lightColors.widColorAlphaFirst : darkColors.widColorAlphaFirst
    readonly property color widColorAlphaSecond:   currentThemeName === "light" ? lightColors.widColorAlphaSecond : darkColors.widColorAlphaSecond

    // Другие специальные цвета
    readonly property color specialColor:          currentThemeName === "light" ? lightColors.specialColor : darkColors.specialColor
    readonly property color backProgress:          currentThemeName === "light" ? lightColors.backProgress : darkColors.backProgress
    readonly property color switchColor:           currentThemeName === "light" ? lightColors.switchColor : darkColors.switchColor


    function toggleTheme() {
        if (currentThemeName === "light") {
            currentThemeName = "dark";
        } else {
            currentThemeName = "light";
        }
        console.log("Switched theme to:", currentThemeName);
    }


    // --- Функция для установки конкретной темы ---
    function setTheme(themeName) {
        if (themeName === "light" || themeName === "dark") {
            if (currentThemeName !== themeName) {
                currentThemeName = themeName;
                console.log("Set theme to:", currentThemeName);
                // Settings.setValue("theme", currentThemeName);
            }
        } else {
            console.warn("Attempted to set invalid theme name:", themeName);
        }
    }
}
