CONFIG += c++20

QT += quick
QT += quick network
QT += concurrent




SOURCES += \
    dht22sensor.cpp \
    general_func.cpp \
    linuxterminal.cpp \
    main.cpp \
    mqttclient.cpp \
    spotify.cpp \
    weather.cpp \

INCLUDEPATH+= C:/boost_1_87_0/
INCLUDEPATH+= C:/FireDaemonOpenSSL3/include/
INCLUDEPATH+= C:/boost_1_87_0/boost/asio/ssl/detail/
LIBS += -LC:/FireDaemonOpenSSL3/lib -lssl -lcrypto

LIBS += -lws2_32
# -lssl -lcrypto
HEADERS += \
    dht22sensor.h \
    general_func.h \
    linuxterminal.h \
    mqttclient.h \
    spotify.h \
    weather.h \

# QMAKE_CXXFLAGS += -Wa,-mbig-obj
# QMAKE_CFLAGS += -Wa,-mbig-obj
# QMAKE_CXXFLAGS += -Os

INCLUDEPATH += $$PWD/lib-mqtt5/include

resources.files = main.qml Clock.qml  Wi-Fi_Page.qml back.jpg icon_0.png icon_1.png icon_2.png icon_3.png icon_4.png icon_5.png back2.jpg Roboto-Light.ttf Roboto-Bold.ttf Roboto-Medium.ttf \
Bluetooth_Page.qml \
Color_Page.qml \
Date_and_time_Page.qml \
Settings_for_Alarm.qml \
Sound_Page.qml \
Storage_Page.qml \
InriaSans-Light.ttf \
ofont.ru_Monoid.ttf \
ofont.ru_Nunito.ttf \
Alarms.qml \
Sensors.qml \
mounts.jpg \
Weather.qml \
Settings_for_Alarm_copy.qml \
Status_bar.qml \
Test.qml \
InitialPage.qml \
russian_cities.json \
Big_Weather.qml \
weather_icon \
userdata.json \
loading.png \
weather_iconkit \
Big_Calendar.qml \
Wi-Fi \
Mini_Events.qml \
icon_6.png\
AlarmScreen.qml \
Kumkwat.png \
KumkwatNew.png \
Mini_Music.qml \
pyro.png \
events.json \
AlarmSetting_Popup.qml

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

DISTFILES += \
    About_Page.qml \
    AlarmSetting_Popup.qml \
    Alarm_Page.qml \
    Alarms.qml \
    Big_Calendar.qml \
    Big_Calendar.qml \
    Big_Weather.qml \
    Bluetooth_Page.qml \
    Color_Page.qml \
    Date_and_time_Page.qml \
    InitialPage.qml \
    Mini_Events.qml \
    Mini_Music.qml \
    Sensors.qml \
    Sound_Page.qml \
    Status_bar.qml \
    Storage_Page.qml \
    Test.qml \
    Big_Calendar.qml \
    Test_Poput.qml \
    humidity.png\
    temp.png\






