CONFIG += c++20

QT += quick
QT += network
QT += concurrent
QT += quickcontrols2

SOURCES += \
    src/audioplayer.cpp \
    src/general_func.cpp \
    src/linuxterminal.cpp \
    src/main.cpp \
    src/mqttclient.cpp \
    src/sensors.cpp \
    src/spotify.cpp \
    src/user.cpp \
    src/weather.cpp \

HEADERS += \
    headers/audioplayer.h \
    headers/general_func.h \
    headers/linuxterminal.h \
    headers/mqttclient.h \
    headers/sensors.h \
    headers/spotify.h \
    headers/user.h \
    headers/weather.h \


DISTFILES += \
    qml/AlarmScreen.qml \
    qml/Big_Weather.qml \
    qml/About_Page.qml \
    qml/Alarm_Page.qml \
    qml/Music.qml\
    qml/Themes.qml


resources.files = \
    qml/main.qml \
    qml/Clock.qml \
    qml/Settings_for_Alarm.qml \
    qml/Wi-Fi_Page.qml \
    qml/Bluetooth_Page.qml \
    qml/Color_Page.qml \
    qml/Date_and_time_Page.qml \
    qml/Sound_Page.qml \
    qml/Storage_Page.qml \
    qml/ofont.ru_Nunito.ttf \
    qml/Alarms.qml \
    qml/Sensors.qml \
    qml/Weather.qml \
    qml/Big_Calendar.qml\
    qml/Status_bar.qml\
    qml/Mini_Events.qml\
    qml/Mini_Music.qml\
    qml/GlobalTime.qml \
    qml/AlarmSettings_Popup.qml \
    russian_cities.json \
    userdata.json \
    qml/resource_icon \
    qml/qmldir \
    qml/Themes.qml



TARGET = smart-alarm-host

resources.prefix = /$${TARGET}
RESOURCES += resources

INCLUDEPATH += $$PWD/headers

#mqtt
INCLUDEPATH += $$PWD/lib-mqtt5/include
INCLUDEPATH += /usr/include/openssl
LIBS += -L/usr/lib -lssl -lcrypto

CONFIG += link_pkgconfig
PKGCONFIG += sdl2 SDL2_mixer

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target


