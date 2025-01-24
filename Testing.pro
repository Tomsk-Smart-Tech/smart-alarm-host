QT += quick
QT += quick network
SOURCES += \
        clientmqtt.cpp \
        linuxterminal.cpp \
        main.cpp \
        weather.cpp

resources.files = main.qml Clock.qml Settings_for_Alarm.qml Wi-Fi_Page.qml back.jpg icon_0.png icon_1.png icon_2.png icon_3.png icon_4.png icon_5.png back2.jpg Roboto-Light.ttf Roboto-Bold.ttf Roboto-Medium.ttf \
Bluetooth_Page.qml \
Color_Page.qml \
Date_and_time_Page.qml \
Settings_for_Alarm.qml \
Sound_Page.qml \
Storage_Page.qml \
Wi-Fi_Page.qml \
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
Big_Calendar.qml

resources.prefix = /$${TARGET}
RESOURCES += resources

INCLUDEPATH+=/home/nikita/paho.mqtt.cpp/include
LIBS += -L/usr/local/lib -lpaho-mqttpp3 -lpaho-mqtt3c -lpaho-mqtt3as

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    Alarms.qml \
    Big_Weather.qml \
    Bluetooth_Page.qml \
    Color_Page.qml \
    Date_and_time_Page.qml \
    Sensors.qml \
    Settings_for_Alarm.qml \
    Sound_Page.qml \
    Storage_Page.qml \
    Weather.qml \
    Wi-Fi_Page.qml

HEADERS += \
    clientmqtt.h \
    linuxterminal.h \
    weather.h



