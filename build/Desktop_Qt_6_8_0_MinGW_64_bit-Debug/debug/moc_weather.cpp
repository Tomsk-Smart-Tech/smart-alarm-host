/****************************************************************************
** Meta object code from reading C++ file 'weather.h'
**
** Created by: The Qt Meta Object Compiler version 68 (Qt 6.8.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../weather.h"
#include <QtNetwork/QSslError>
#include <QtCore/qmetatype.h>

#include <QtCore/qtmochelpers.h>

#include <memory>


#include <QtCore/qxptype_traits.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'weather.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 68
#error "This file was generated using the moc from 6.8.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

#ifndef Q_CONSTINIT
#define Q_CONSTINIT
#endif

QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
QT_WARNING_DISABLE_GCC("-Wuseless-cast")
namespace {

#ifdef QT_MOC_HAS_STRINGDATA
struct qt_meta_stringdata_CLASSWeatherENDCLASS_t {};
constexpr auto qt_meta_stringdata_CLASSWeatherENDCLASS = QtMocHelpers::stringData(
    "Weather",
    "city_changed",
    "",
    "coordinates_changed",
    "data_changed",
    "h_weather_changed",
    "handleReply_pos",
    "handleReply_time",
    "handleReply_weather",
    "set_city",
    "value",
    "request_position",
    "request_data",
    "request_weather",
    "city",
    "latitude",
    "longitude",
    "unixtime",
    "cur_weather",
    "QVariantMap"
);
#else  // !QT_MOC_HAS_STRINGDATA
#error "qtmochelpers.h not found or too old."
#endif // !QT_MOC_HAS_STRINGDATA
} // unnamed namespace

Q_CONSTINIT static const uint qt_meta_data_CLASSWeatherENDCLASS[] = {

 // content:
      12,       // revision
       0,       // classname
       0,    0, // classinfo
      11,   14, // methods
       5,   93, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       4,       // signalCount

 // signals: name, argc, parameters, tag, flags, initial metatype offsets
       1,    0,   80,    2, 0x06,    6 /* Public */,
       3,    0,   81,    2, 0x06,    7 /* Public */,
       4,    0,   82,    2, 0x06,    8 /* Public */,
       5,    0,   83,    2, 0x06,    9 /* Public */,

 // slots: name, argc, parameters, tag, flags, initial metatype offsets
       6,    0,   84,    2, 0x08,   10 /* Private */,
       7,    0,   85,    2, 0x08,   11 /* Private */,
       8,    0,   86,    2, 0x08,   12 /* Private */,

 // methods: name, argc, parameters, tag, flags, initial metatype offsets
       9,    1,   87,    2, 0x02,   13 /* Public */,
      11,    0,   90,    2, 0x02,   15 /* Public */,
      12,    0,   91,    2, 0x02,   16 /* Public */,
      13,    0,   92,    2, 0x02,   17 /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

 // methods: parameters
    QMetaType::Void, QMetaType::QString,   10,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

 // properties: name, type, flags, notifyId, revision
      14, QMetaType::QString, 0x00015001, uint(0), 0,
      15, QMetaType::QString, 0x00015001, uint(1), 0,
      16, QMetaType::QString, 0x00015001, uint(1), 0,
      17, QMetaType::ULongLong, 0x00015001, uint(2), 0,
      18, 0x80000000 | 19, 0x00015009, uint(3), 0,

       0        // eod
};

Q_CONSTINIT const QMetaObject Weather::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_CLASSWeatherENDCLASS.offsetsAndSizes,
    qt_meta_data_CLASSWeatherENDCLASS,
    qt_static_metacall,
    nullptr,
    qt_incomplete_metaTypeArray<qt_meta_stringdata_CLASSWeatherENDCLASS_t,
        // property 'city'
        QtPrivate::TypeAndForceComplete<QString, std::true_type>,
        // property 'latitude'
        QtPrivate::TypeAndForceComplete<QString, std::true_type>,
        // property 'longitude'
        QtPrivate::TypeAndForceComplete<QString, std::true_type>,
        // property 'unixtime'
        QtPrivate::TypeAndForceComplete<quint64, std::true_type>,
        // property 'cur_weather'
        QtPrivate::TypeAndForceComplete<QVariantMap, std::true_type>,
        // Q_OBJECT / Q_GADGET
        QtPrivate::TypeAndForceComplete<Weather, std::true_type>,
        // method 'city_changed'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'coordinates_changed'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'data_changed'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'h_weather_changed'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'handleReply_pos'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'handleReply_time'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'handleReply_weather'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'set_city'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        // method 'request_position'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'request_data'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'request_weather'
        QtPrivate::TypeAndForceComplete<void, std::false_type>
    >,
    nullptr
} };

void Weather::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<Weather *>(_o);
        (void)_t;
        switch (_id) {
        case 0: _t->city_changed(); break;
        case 1: _t->coordinates_changed(); break;
        case 2: _t->data_changed(); break;
        case 3: _t->h_weather_changed(); break;
        case 4: _t->handleReply_pos(); break;
        case 5: _t->handleReply_time(); break;
        case 6: _t->handleReply_weather(); break;
        case 7: _t->set_city((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 8: _t->request_position(); break;
        case 9: _t->request_data(); break;
        case 10: _t->request_weather(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (Weather::*)();
            if (_t _q_method = &Weather::city_changed; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (Weather::*)();
            if (_t _q_method = &Weather::coordinates_changed; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (Weather::*)();
            if (_t _q_method = &Weather::data_changed; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 2;
                return;
            }
        }
        {
            using _t = void (Weather::*)();
            if (_t _q_method = &Weather::h_weather_changed; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 3;
                return;
            }
        }
    } else if (_c == QMetaObject::ReadProperty) {
        auto *_t = static_cast<Weather *>(_o);
        (void)_t;
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QString*>(_v) = _t->get_city(); break;
        case 1: *reinterpret_cast< QString*>(_v) = _t->get_latitude(); break;
        case 2: *reinterpret_cast< QString*>(_v) = _t->get_longitude(); break;
        case 3: *reinterpret_cast< quint64*>(_v) = _t->get_time(); break;
        case 4: *reinterpret_cast< QVariantMap*>(_v) = _t->get_cur_forecast(); break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
    } else if (_c == QMetaObject::ResetProperty) {
    } else if (_c == QMetaObject::BindableProperty) {
    }
}

const QMetaObject *Weather::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *Weather::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_CLASSWeatherENDCLASS.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int Weather::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 11)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 11;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 11)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 11;
    }else if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::BindableProperty
            || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 5;
    }
    return _id;
}

// SIGNAL 0
void Weather::city_changed()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void Weather::coordinates_changed()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void Weather::data_changed()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}

// SIGNAL 3
void Weather::h_weather_changed()
{
    QMetaObject::activate(this, &staticMetaObject, 3, nullptr);
}
QT_WARNING_POP
