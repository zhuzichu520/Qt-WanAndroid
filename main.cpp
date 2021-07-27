#include <QtGui/qguiapplication.h>
#include <QtQml/qqmlapplicationengine.h>
#include <QtQuickControls2/qquickstyle.h>
#include <QtQuick/qquickwindow.h>
#include <src/application/Application.h>
#include <QFont>
#include <QtWebEngine/qtwebengineglobal.h>

int main(int argc, char *argv[]) {
    //    qputenv("QSG_RENDER_LOOP", "basic" );
    QtWebEngine::initialize();
    QGuiApplication::setAttribute(Qt::AA_DontCreateNativeWidgetSiblings);
#if (QT_VERSION < QT_VERSION_CHECK(6, 0, 0))
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication::setAttribute(Qt::AA_UseHighDpiPixmaps);
#if (QT_VERSION >= QT_VERSION_CHECK(5, 14, 0))
    QGuiApplication::setHighDpiScaleFactorRoundingPolicy(Qt::HighDpiScaleFactorRoundingPolicy::PassThrough);
#endif
#endif
    QGuiApplication application(argc, argv);
    QQmlApplicationEngine engine;
#if (QT_VERSION >= QT_VERSION_CHECK(6, 0, 0))
    QQuickWindow::setGraphicsApi(QSGRendererInterface::Software);
    QQuickStyle::setStyle(QStringLiteral("Basic"));
#else
    QQuickWindow::setSceneGraphBackend(QSGRendererInterface::Software);
    QQuickStyle::setStyle("Default");
#endif

    QFont font;
    font.setFamily("Microsoft YaHei");
    font.setWeight(QFont::Normal);
    application.setFont(font);

    //    QGuiApplication::setQuitOnLastWindowClosed(false);
    QGuiApplication::setOrganizationName("ZhuZiChu");
    QGuiApplication::setOrganizationDomain("zhuzichu.com");
    QGuiApplication::setApplicationName("WanAndroid");

    const QUrl mainQmlUrl("qrc:/layout/ActivityMain.qml");
    const QMetaObject::Connection connection = QObject::connect(
                &engine,
                &QQmlApplicationEngine::objectCreated,
                &application,
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
    APP->init(argc, argv);
    engine.load(mainQmlUrl);
    return QGuiApplication::exec();
}
