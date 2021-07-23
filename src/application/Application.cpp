#include "Application.h"

Q_GLOBAL_STATIC(Application, application)

Application *Application::instance() {
    return application();
}

void Application::init(int argc, char *argv[]) {
    LogUtils logUtils(argv);
    registerQmlType();
}

void Application::registerQmlType() {
    qmlRegisterType<LoginController>("UI.Controller", 1, 0, "LoginController");
    qmlRegisterType<HomeController>("UI.Controller", 1, 0, "HomeController");
    qmlRegisterType<ToolController>("UI.Controller", 1, 0, "ToolController");
    qmlRegisterType<SettingController>("UI.Controller", 1, 0, "SettingController");
    qmlRegisterType<WebController>("UI.Controller", 1, 0, "WebController");

    qmlRegisterType<ApiLogin>("UI.Http", 1, 0, "ApiLogin");
    qmlRegisterType<ApiGetArticleList>("UI.Http", 1, 0, "ApiGetArticleList");
}
