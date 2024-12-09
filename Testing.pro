QT += quick

SOURCES += \
        main.cpp

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

DISTFILES += \
    Alarms.qml \
    Bluetooth_Page.qml \
    Color_Page.qml \
    Date_and_time_Page.qml \
    Sensors.qml \
    Settings_for_Alarm.qml \
    Sound_Page.qml \
    Storage_Page.qml \
    Weather.qml \
    Wi-Fi_Page.qml



