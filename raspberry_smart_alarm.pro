CONFIG += c++20

QT += quick
QT += quick network
QT += concurrent

SOURCES += \
    src/general_func.cpp \
    src/linuxterminal.cpp \
    src/main.cpp \
    src/mqttclient.cpp \
    src/sensors.cpp \
    src/spotify.cpp \
    src/user.cpp \
    src/weather.cpp \

HEADERS += \
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

TARGET = smart-alarm-host

INCLUDEPATH+= C:/boost_1_87_0/
INCLUDEPATH+= C:/FireDaemonOpenSSL3/include/
INCLUDEPATH+= C:/boost_1_87_0/boost/asio/ssl/detail/
LIBS += -LC:/FireDaemonOpenSSL3/lib -lssl -lcrypto

LIBS += -lws2_32
# -lssl -lcrypto


# QMAKE_CXXFLAGS += -Wa,-mbig-obj
# QMAKE_CFLAGS += -Wa,-mbig-obj
# QMAKE_CXXFLAGS += -Os

INCLUDEPATH += $$PWD/lib-mqtt5/include
INCLUDEPATH += $$PWD/headers


resources.prefix = /$${TARGET}
RESOURCES += resources

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =


# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
QT += quickcontrols2
QT += core gui opengl






