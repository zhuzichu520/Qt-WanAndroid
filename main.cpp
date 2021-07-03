#include <QtGui/qguiapplication.h>
#include <QtQml/qqmlapplicationengine.h>
#include <QtQuickControls2/qquickstyle.h>
#include <QtQuick/qquickwindow.h>

int main(int argc, char *argv[]) {
    QCoreApplication::setAttribute(Qt::AA_DontCreateNativeWidgetSiblings);
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
    QQuickStyle::setStyle(QStringLiteral("Default"));
#endif
    const QUrl mainQmlUrl(QStringLiteral("qrc:/layout/main.qml"));
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
    engine.load(mainQmlUrl);
    return QGuiApplication::exec();
}
