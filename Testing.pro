CONFIG += c++20

QT += quick
QT += quick network
QT += concurrent
QT += quickcontrols2

SOURCES += \
    dht22sensor.cpp \
    general_func.cpp \
    linuxterminal.cpp \
    main.cpp \
    mqttclient.cpp \
    spotify.cpp \
    weather.cpp \

resources.files = \
    main.qml \
    Clock.qml \
    Settings_for_Alarm.qml \
    Wi-Fi_Page.qml \
    back.jpg \
    icon_0.png icon_1.png icon_2.png icon_3.png icon_4.png icon_5.png \
    back2.jpg \
    Roboto-Light.ttf \
    Roboto-Bold.ttf \
    Roboto-Medium.ttf \
    Bluetooth_Page.qml \
    Color_Page.qml \
    Date_and_time_Page.qml \
    Sound_Page.qml \
    Storage_Page.qml \
    InriaSans-Light.ttf \
    ofont.ru_Monoid.ttf \
    ofont.ru_Nunito.ttf \
    Alarms.qml \
    Sensors.qml \
    mounts.jpg \
    Weather.qml \
    russian_cities.json \
    userdata.json \
    weather_icon \
    weather_iconkit \
    connection \
    Big_Calendar.qml\
    Status_bar.qml\
    Mini_Events.qml\
    Wi-Fi \
    Mini_Music.qml\
    icon_6.png\


resources.prefix = /$${TARGET}
RESOURCES += resources

#mqtt
INCLUDEPATH += $$PWD/lib-mqtt5/include
INCLUDEPATH += /usr/include/openssl
LIBS += -L/usr/lib -lssl -lcrypto

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    AlarmScreen.qml \
    Big_Weather.qml \
    GlobalTime.qml \
    About_Page.qml \
    Alarm_Page.qml \

HEADERS += \
    dht22sensor.h \
    general_func.h \
    linuxterminal.h \
    mqttclient.h \
    spotify.h \
    weather.h \
