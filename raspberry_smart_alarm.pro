QT += quick
QT += quick network
SOURCES += \
        main.cpp\
        weather.cpp\

HEADERS += \
        weather.h

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
cloud.png \
clouds.png \
sun.png \
lightning.png \
rain.png \
partly_sun_day.png \
Settings_for_Alarm_copy.qml \
Status_bar.qml \
Test.qml \
InitialPage.qml \
russian_cities.json \
Big_Weather.qml \
weather_icon \
userdata.json \
loading.png \
loaging.gif

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
    Alarms.qml \
    Big_Weather.qml \
    Bluetooth_Page.qml \
    Color_Page.qml \
    Date_and_time_Page.qml \
    InitialPage.qml \
    Sensors.qml \
    Settings_for_Alarm.qml \
    Settings_for_Alarm_copy.qml \
    Sound_Page.qml \
    Status_bar.qml \
    Storage_Page.qml \
    Test.qml \
    Wi-Fi_Page.qml \

