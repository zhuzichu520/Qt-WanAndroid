#include <QtGui/qguiapplication.h>
#include <QtQml/qqmlapplicationengine.h>
#include <QtQuickControls2/qquickstyle.h>
#include <QtQuick/qquickwindow.h>
#include <QtWebEngine/qtwebengineglobal.h>
#include <QQuickImageProvider>
#include <QQmlContext>
#include "src/hotkey/QHotkey.h"
#include "src/hotkey/ViewHotkey.h"
#include "src/login/LoginController.h"
#include "src/tools/PictureController.h"
#include "src/http/ApiLogin.h"
#include "src/http/ApiGetArticleList.h"
#include "src/http/ApiGetWxChapters.h"
#include "src/http/ApiGetWxArticleList.h"
#include "src/http/ApiGetTree.h"
#include "src/tools/PictureItem.h"
#include "src/tools/VideoItem.h"

int main(int argc, char *argv[]) {
//    qputenv("QSG_RENDER_LOOP", "basic" );
    LogUtils logUtils(argv);
    QtWebEngine::initialize();
    QGuiApplication::setAttribute(Qt::AA_DontCreateNativeWidgetSiblings);
#if (QT_VERSION < QT_VERSION_CHECK(6, 0, 0))
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication::setAttribute(Qt::AA_UseHighDpiPixmaps);
#if (QT_VERSION >= QT_VERSION_CHECK(5, 14, 0))
    QGuiApplication::setHighDpiScaleFactorRoundingPolicy(Qt::HighDpiScaleFactorRoundingPolicy::PassThrough);
#endif
#endif
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
#if (QT_VERSION >= QT_VERSION_CHECK(6, 0, 0))
    QQuickWindow::setGraphicsApi(QSGRendererInterface::Software);
    QQuickStyle::setStyle(QStringLiteral("Basic"));
#else
//    QQuickWindow::setSceneGraphBackend(QSGRendererInterface::Software);
    QQuickStyle::setStyle("Default");
#endif
    QFont font;
    font.setFamily("Microsoft YaHei");
    font.setWeight(QFont::Normal);
    QGuiApplication::setFont(font);
    QGuiApplication::setOrganizationName("ZhuZiChu");
    QGuiApplication::setOrganizationDomain("zhuzichu.com");
    QGuiApplication::setApplicationName("WanAndroid");

    ViewHotkey viewHotkey;
    engine.rootContext()->setContextProperty("viewHotkey", &viewHotkey);
    auto hotkey = new QHotkey(QKeySequence("ctrl+alt+Q"), true, &app);
    QObject::connect(hotkey, &QHotkey::activated, qApp, [&]() {
        qApp->quit();
    });
    hotkey = new QHotkey(QKeySequence("ctrl+alt+A"), true, &app);
    QObject::connect(hotkey, &QHotkey::activated, qApp, [&]() {
        Q_EMIT viewHotkey.hotKeyActivated("ctrl+alt+A");
    });

    qmlRegisterType<PictureItem>("UI.View", 1, 0, "PictureItem");
    qmlRegisterType<VideoItem>("UI.View", 1, 0, "VideoItem");

    qmlRegisterType<LoginController>("UI.Controller", 1, 0, "LoginController");
    qmlRegisterType<PictureController>("UI.Controller", 1, 0, "PictureController");

    qmlRegisterType<ApiLogin>("UI.Http", 1, 0, "ApiLogin");
    qmlRegisterType<ApiGetArticleList>("UI.Http", 1, 0, "ApiGetArticleList");
    qmlRegisterType<ApiGetWxArticleList>("UI.Http", 1, 0, "ApiGetWxArticleList");
    qmlRegisterType<ApiGetWxChapters>("UI.Http", 1, 0, "ApiGetWxChapters");
    qmlRegisterType<ApiGetTree>("UI.Http", 1, 0, "ApiGetTree");

    const QUrl mainQmlUrl("qrc:/layout/ActivityMain.qml");
    const QMetaObject::Connection connection = QObject::connect(
                &engine,
                &QQmlApplicationEngine::objectCreated,
                &app,
                [&mainQmlUrl, &connection](QObject *object, const QUrl &url) {
        if (url != mainQmlUrl) {
            return;
        }
        if (!object) {
            QGuiApplication::exit(-1);
        } else {
            QObject::disconnect(connection);
        }
    },
    Qt::QueuedConnection);
    engine.load(mainQmlUrl);
    return QGuiApplication::exec();
}
