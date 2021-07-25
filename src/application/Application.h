#ifndef SIMPLE_APPLICATION_H
#define SIMPLE_APPLICATION_H

#include <QGlobalStatic>
#include <QQmlApplicationEngine>
#include <QGuiApplication>
#include "src/login/LoginController.h"
#include "src/utils/LogUtils.h"

#include "src/http/ApiLogin.h"
#include "src/http/ApiGetArticleList.h"
#include "src/http/ApiGetWxChapters.h"
#include "src/http/ApiGetWxArticleList.h"

#define APP Application::instance()

class Application {
public:

    Application() = default;

    virtual ~Application() = default;

    static Application *instance();

    void init(int argc, char *argv[]);

private:
    void registerQmlType();
};

#endif
