// /raspberry_smart_alarm/Status_bar.qml
#include <QtQml/qqmlprivate.h>
#include <QtCore/qdatetime.h>
#include <QtCore/qobject.h>
#include <QtCore/qstring.h>
#include <QtCore/qstringlist.h>
#include <QtCore/qtimezone.h>
#include <QtCore/qurl.h>
#include <QtCore/qvariant.h>
#include <QtQml/qjsengine.h>
#include <QtQml/qjsprimitivevalue.h>
#include <QtQml/qjsvalue.h>
#include <QtQml/qqmlcomponent.h>
#include <QtQml/qqmlcontext.h>
#include <QtQml/qqmlengine.h>
#include <QtQml/qqmllist.h>
#include <type_traits>
namespace QmlCacheGeneratedCode {
namespace _raspberry_smart_alarm_Status_bar_qml {
extern const unsigned char qmlData alignas(16) [];
extern const unsigned char qmlData alignas(16) [] = {

0x71,0x76,0x34,0x63,0x64,0x61,0x74,0x61,
0x42,0x0,0x0,0x0,0x0,0x8,0x6,0x0,
0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
0xc4,0x5,0x0,0x0,0x62,0x37,0x65,0x61,
0x36,0x62,0x37,0x61,0x37,0x38,0x66,0x65,
0x33,0x62,0x66,0x37,0x31,0x66,0x34,0x61,
0x38,0x34,0x37,0x35,0x35,0x39,0x37,0x63,
0x61,0x35,0x39,0x66,0x34,0x62,0x31,0x32,
0x39,0x33,0x35,0x64,0x0,0x0,0x0,0x0,
0x0,0x0,0x0,0x0,0x12,0x55,0xac,0x25,
0xf8,0x20,0xf1,0x11,0xf7,0x9a,0xf7,0xc,
0xa5,0xa4,0xd,0xef,0x0,0x0,0x0,0x0,
0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
0x0,0x0,0x0,0x0,0x23,0x0,0x0,0x0,
0x11,0x0,0x0,0x0,0x68,0x2,0x0,0x0,
0x3,0x0,0x0,0x0,0xf8,0x0,0x0,0x0,
0x0,0x0,0x0,0x0,0x4,0x1,0x0,0x0,
0x0,0x0,0x0,0x0,0x4,0x1,0x0,0x0,
0x0,0x0,0x0,0x0,0x4,0x1,0x0,0x0,
0x6,0x0,0x0,0x0,0x4,0x1,0x0,0x0,
0x0,0x0,0x0,0x0,0x1c,0x1,0x0,0x0,
0x5,0x0,0x0,0x0,0x20,0x1,0x0,0x0,
0x0,0x0,0x0,0x0,0x48,0x1,0x0,0x0,
0x0,0x0,0x0,0x0,0x48,0x1,0x0,0x0,
0x0,0x0,0x0,0x0,0x48,0x1,0x0,0x0,
0x0,0x0,0x0,0x0,0x48,0x1,0x0,0x0,
0x0,0x0,0x0,0x0,0x48,0x1,0x0,0x0,
0x0,0x0,0x0,0x0,0x48,0x1,0x0,0x0,
0x0,0x0,0x0,0x0,0x48,0x1,0x0,0x0,
0xff,0xff,0xff,0xff,0x0,0x0,0x0,0x0,
0x0,0x0,0x0,0x0,0x10,0x4,0x0,0x0,
0x48,0x1,0x0,0x0,0x98,0x1,0x0,0x0,
0xe8,0x1,0x0,0x0,0x33,0x0,0x0,0x0,
0x40,0x0,0x0,0x0,0x33,0x0,0x0,0x0,
0x50,0x0,0x0,0x0,0xf3,0x0,0x0,0x0,
0x4,0x1,0x0,0x0,0x0,0x0,0x0,0x0,
0x0,0x0,0x0,0x0,0x0,0x40,0xf5,0x7f,
0x0,0x0,0x0,0x0,0x0,0x40,0x65,0x3f,
0x0,0x0,0x0,0x0,0x0,0x40,0xbc,0x3f,
0xf0,0x0,0x0,0x0,0x0,0xc0,0x3,0x0,
0x1,0x0,0x0,0x0,0x0,0xc0,0x3,0x0,
0x44,0x0,0x0,0x0,0x7,0x0,0x0,0x0,
0x8,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
0x38,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
0x38,0x0,0x0,0x0,0x0,0x0,0x1,0x0,
0xff,0xff,0xff,0xff,0x7,0x0,0x0,0x0,
0x8,0x0,0x90,0x0,0x0,0x0,0x0,0x0,
0x0,0x0,0x7,0x0,0x0,0x0,0x0,0x0,
0x0,0x0,0x0,0x0,0x8,0x0,0x0,0x0,
0x1,0x0,0x0,0x0,0x2e,0x0,0x3c,0x1,
0x18,0x6,0x2,0x0,0x0,0x0,0x0,0x0,
0x44,0x0,0x0,0x0,0x7,0x0,0x0,0x0,
0xa,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
0x38,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
0x38,0x0,0x0,0x0,0x0,0x0,0x1,0x0,
0xff,0xff,0xff,0xff,0x7,0x0,0x0,0x0,
0x9,0x0,0x90,0x0,0x0,0x0,0x0,0x0,
0x0,0x0,0x7,0x0,0x0,0x0,0x0,0x0,
0x0,0x0,0x0,0x0,0x9,0x0,0x0,0x0,
0x1,0x0,0x0,0x0,0x2e,0x2,0x3c,0x3,
0x18,0x6,0x2,0x0,0x0,0x0,0x0,0x0,
0x44,0x0,0x0,0x0,0x33,0x0,0x0,0x0,
0xe,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
0x38,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
0x38,0x0,0x0,0x0,0x0,0x0,0x1,0x0,
0xff,0xff,0xff,0xff,0xf,0x0,0x0,0x0,
0xc,0x0,0x90,0x0,0x0,0x0,0x0,0x0,
0x0,0x0,0x7,0x0,0x0,0x0,0x0,0x0,
0x0,0x0,0x0,0x0,0xc,0x0,0x0,0x0,
0x1,0x0,0x0,0x0,0x2e,0x4,0x18,0x7,
0x14,0x3,0xe,0x11,0xff,0x0,0x0,0x0,
0x9e,0xe,0x18,0xa,0x14,0x3,0xe,0x11,
0xff,0x0,0x0,0x0,0x9e,0xe,0x18,0xb,
0x14,0x3,0xe,0x11,0xff,0x0,0x0,0x0,
0x9e,0xe,0x18,0xc,0x14,0x4,0xd,0xac,
0x5,0x7,0x4,0xa,0x18,0x6,0x2,0x0,
0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
0xb0,0x2,0x0,0x0,0xb8,0x2,0x0,0x0,
0xd0,0x2,0x0,0x0,0xe0,0x2,0x0,0x0,
0xf0,0x2,0x0,0x0,0x0,0x3,0x0,0x0,
0x10,0x3,0x0,0x0,0x28,0x3,0x0,0x0,
0x30,0x3,0x0,0x0,0x58,0x3,0x0,0x0,
0x60,0x3,0x0,0x0,0x88,0x3,0x0,0x0,
0x98,0x3,0x0,0x0,0xb0,0x3,0x0,0x0,
0xc0,0x3,0x0,0x0,0xf0,0x3,0x0,0x0,
0x0,0x4,0x0,0x0,0x0,0x0,0x0,0x0,
0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
0x7,0x0,0x0,0x0,0x51,0x0,0x74,0x0,
0x51,0x0,0x75,0x0,0x69,0x0,0x63,0x0,
0x6b,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
0x4,0x0,0x0,0x0,0x49,0x0,0x74,0x0,
0x65,0x0,0x6d,0x0,0x0,0x0,0x0,0x0,
0x3,0x0,0x0,0x0,0x62,0x0,0x61,0x0,
0x72,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
0x5,0x0,0x0,0x0,0x78,0x0,0x5f,0x0,
0x70,0x0,0x6f,0x0,0x73,0x0,0x0,0x0,
0x5,0x0,0x0,0x0,0x79,0x0,0x5f,0x0,
0x70,0x0,0x6f,0x0,0x73,0x0,0x0,0x0,
0x9,0x0,0x0,0x0,0x52,0x0,0x65,0x0,
0x63,0x0,0x74,0x0,0x61,0x0,0x6e,0x0,
0x67,0x0,0x6c,0x0,0x65,0x0,0x0,0x0,
0x1,0x0,0x0,0x0,0x78,0x0,0x0,0x0,
0x10,0x0,0x0,0x0,0x65,0x0,0x78,0x0,
0x70,0x0,0x72,0x0,0x65,0x0,0x73,0x0,
0x73,0x0,0x69,0x0,0x6f,0x0,0x6e,0x0,
0x20,0x0,0x66,0x0,0x6f,0x0,0x72,0x0,
0x20,0x0,0x78,0x0,0x0,0x0,0x0,0x0,
0x1,0x0,0x0,0x0,0x79,0x0,0x0,0x0,
0x10,0x0,0x0,0x0,0x65,0x0,0x78,0x0,
0x70,0x0,0x72,0x0,0x65,0x0,0x73,0x0,
0x73,0x0,0x69,0x0,0x6f,0x0,0x6e,0x0,
0x20,0x0,0x66,0x0,0x6f,0x0,0x72,0x0,
0x20,0x0,0x79,0x0,0x0,0x0,0x0,0x0,
0x5,0x0,0x0,0x0,0x77,0x0,0x69,0x0,
0x64,0x0,0x74,0x0,0x68,0x0,0x0,0x0,
0x6,0x0,0x0,0x0,0x68,0x0,0x65,0x0,
0x69,0x0,0x67,0x0,0x68,0x0,0x74,0x0,
0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
0x5,0x0,0x0,0x0,0x63,0x0,0x6f,0x0,
0x6c,0x0,0x6f,0x0,0x72,0x0,0x0,0x0,
0x14,0x0,0x0,0x0,0x65,0x0,0x78,0x0,
0x70,0x0,0x72,0x0,0x65,0x0,0x73,0x0,
0x73,0x0,0x69,0x0,0x6f,0x0,0x6e,0x0,
0x20,0x0,0x66,0x0,0x6f,0x0,0x72,0x0,
0x20,0x0,0x63,0x0,0x6f,0x0,0x6c,0x0,
0x6f,0x0,0x72,0x0,0x0,0x0,0x0,0x0,
0x2,0x0,0x0,0x0,0x51,0x0,0x74,0x0,
0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
0x4,0x0,0x0,0x0,0x72,0x0,0x67,0x0,
0x62,0x0,0x61,0x0,0x0,0x0,0x0,0x0,
0x1,0x0,0x0,0x0,0x10,0x0,0x0,0x0,
0x2,0x0,0x0,0x0,0x24,0x0,0x0,0x0,
0x1,0x0,0x0,0x0,0x1,0x0,0x0,0x0,
0x0,0x0,0x0,0x0,0x1,0x0,0x10,0x0,
0x0,0x2,0x0,0x0,0x2c,0x0,0x0,0x0,
0xe4,0x0,0x0,0x0,0x2,0x0,0x0,0x0,
0x3,0x0,0x0,0x0,0x0,0x0,0xff,0xff,
0xff,0xff,0xff,0xff,0x0,0x0,0x2,0x0,
0x54,0x0,0x0,0x0,0x54,0x0,0x0,0x0,
0x6c,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
0x6c,0x0,0x0,0x0,0x6c,0x0,0x0,0x0,
0x0,0x0,0x3,0x0,0x6c,0x0,0x0,0x0,
0x0,0x0,0x0,0x0,0xb4,0x0,0x0,0x0,
0x3,0x0,0x10,0x0,0x4,0x0,0x50,0x0,
0xb4,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
0xb4,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
0x4,0x0,0x0,0x0,0x2,0x0,0x0,0x20,
0x5,0x0,0x50,0x0,0x5,0x0,0x0,0x0,
0x2,0x0,0x0,0x20,0x6,0x0,0x50,0x0,
0x5,0x0,0x0,0x0,0x0,0x0,0x2,0x0,
0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
0x6,0x0,0x20,0x1,0x6,0x0,0x90,0x1,
0x4,0x0,0x0,0x0,0x0,0x0,0x2,0x0,
0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
0x5,0x0,0x20,0x1,0x5,0x0,0x90,0x1,
0x0,0x0,0x0,0x0,0x0,0x0,0x8,0x0,
0x1,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
0x7,0x0,0x50,0x0,0x7,0x0,0x50,0x0,
0x0,0x0,0x0,0x0,0x6,0x0,0x0,0x0,
0x0,0x0,0x0,0x0,0x0,0x0,0xff,0xff,
0xff,0xff,0xff,0xff,0x0,0x0,0x0,0x0,
0x54,0x0,0x0,0x0,0x54,0x0,0x0,0x0,
0x54,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
0x54,0x0,0x0,0x0,0x54,0x0,0x0,0x0,
0x0,0x0,0x5,0x0,0x54,0x0,0x0,0x0,
0x0,0x0,0x0,0x0,0xcc,0x0,0x0,0x0,
0x7,0x0,0x50,0x0,0x0,0x0,0x0,0x0,
0xcc,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
0xcc,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
0xd,0x0,0x0,0x0,0x0,0x0,0x7,0x0,
0x2,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
0xc,0x0,0x90,0x0,0xc,0x0,0x0,0x1,
0xc,0x0,0x0,0x0,0x0,0x0,0x2,0x0,
0x2,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
0xb,0x0,0x90,0x0,0xb,0x0,0x10,0x1,
0xb,0x0,0x0,0x0,0x0,0x0,0x2,0x0,
0x1,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
0xa,0x0,0x90,0x0,0xa,0x0,0x0,0x1,
0x9,0x0,0x0,0x0,0x0,0x0,0x7,0x0,
0x1,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
0x9,0x0,0x90,0x0,0x9,0x0,0xc0,0x0,
0x7,0x0,0x0,0x0,0x0,0x0,0x7,0x0,
0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
0x8,0x0,0x90,0x0,0x8,0x0,0xc0,0x0,
0x0,0x0,0x0,0x0
};
QT_WARNING_PUSH
QT_WARNING_DISABLE_MSVC(4573)
extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[] = {
{ 0, 0, [](QV4::ExecutableCompilationUnit *unit, QMetaType *argTypes) {
    struct { QV4::ExecutableCompilationUnit *compilationUnit; } c { unit };
    const auto *aotContext = &c;
    Q_UNUSED(aotContext);
    argTypes[0] = QMetaType::fromType<double>();
}, 
    [](const QQmlPrivate::AOTCompiledContext *aotContext, void **argv) {
Q_UNUSED(aotContext)
Q_UNUSED(argv)
// expression for x at line 8, column 9
QObject *r2_0;
double r2_1;
// generate_LoadQmlContextPropertyLookup
#ifndef QT_NO_DEBUG
aotContext->setInstructionPointer(2);
#endif
while (!aotContext->loadContextIdLookup(0, &r2_0)) {
#ifdef QT_NO_DEBUG
aotContext->setInstructionPointer(2);
#endif
aotContext->initLoadContextIdLookup(0);
if (aotContext->engine->hasError()) {
aotContext->setReturnValueUndefined();
if (argv[0]) {
    *static_cast<double *>(argv[0]) = double();
}
return;
}
}
{
}
// generate_GetLookup
{
int retrieved;
#ifndef QT_NO_DEBUG
aotContext->setInstructionPointer(4);
#endif
while (!aotContext->getObjectLookup(1, r2_0, &retrieved)) {
#ifdef QT_NO_DEBUG
aotContext->setInstructionPointer(4);
#endif
aotContext->initGetObjectLookup(1, r2_0, QMetaType::fromType<int>());
if (aotContext->engine->hasError()) {
aotContext->setReturnValueUndefined();
if (argv[0]) {
    *static_cast<double *>(argv[0]) = double();
}
return;
}
}
r2_1 = double(std::move(retrieved));
}
{
}
{
}
// generate_Ret
if (argv[0]) {
    *static_cast<double *>(argv[0]) = r2_1;
}
return;
}
 },{ 1, 0, [](QV4::ExecutableCompilationUnit *unit, QMetaType *argTypes) {
    struct { QV4::ExecutableCompilationUnit *compilationUnit; } c { unit };
    const auto *aotContext = &c;
    Q_UNUSED(aotContext);
    argTypes[0] = QMetaType::fromType<double>();
}, 
    [](const QQmlPrivate::AOTCompiledContext *aotContext, void **argv) {
Q_UNUSED(aotContext)
Q_UNUSED(argv)
// expression for y at line 9, column 9
QObject *r2_0;
double r2_1;
// generate_LoadQmlContextPropertyLookup
#ifndef QT_NO_DEBUG
aotContext->setInstructionPointer(2);
#endif
while (!aotContext->loadContextIdLookup(2, &r2_0)) {
#ifdef QT_NO_DEBUG
aotContext->setInstructionPointer(2);
#endif
aotContext->initLoadContextIdLookup(2);
if (aotContext->engine->hasError()) {
aotContext->setReturnValueUndefined();
if (argv[0]) {
    *static_cast<double *>(argv[0]) = double();
}
return;
}
}
{
}
// generate_GetLookup
{
int retrieved;
#ifndef QT_NO_DEBUG
aotContext->setInstructionPointer(4);
#endif
while (!aotContext->getObjectLookup(3, r2_0, &retrieved)) {
#ifdef QT_NO_DEBUG
aotContext->setInstructionPointer(4);
#endif
aotContext->initGetObjectLookup(3, r2_0, QMetaType::fromType<int>());
if (aotContext->engine->hasError()) {
aotContext->setReturnValueUndefined();
if (argv[0]) {
    *static_cast<double *>(argv[0]) = double();
}
return;
}
}
r2_1 = double(std::move(retrieved));
}
{
}
{
}
// generate_Ret
if (argv[0]) {
    *static_cast<double *>(argv[0]) = r2_1;
}
return;
}
 },{ 0, 0, nullptr, nullptr }};
QT_WARNING_POP
}
}
