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

    qmlRegisterType<ApiLogin>("UI.Http", 1, 0, "ApiLogin");
    qmlRegisterType<ApiGetArticleList>("UI.Http", 1, 0, "ApiGetArticleList");
    qmlRegisterType<ApiGetWxArticleList>("UI.Http", 1, 0, "ApiGetWxArticleList");
    qmlRegisterType<ApiGetWxChapters>("UI.Http", 1, 0, "ApiGetWxChapters");
    qmlRegisterType<ApiGetTree>("UI.Http", 1, 0, "ApiGetTree");


}
