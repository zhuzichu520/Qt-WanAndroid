#ifndef SIMPLE_APPLICATION_H
#define SIMPLE_APPLICATION_H

#include <QGlobalStatic>
#include <QQmlApplicationEngine>
#include <QGuiApplication>
#include "src/login/LoginController.h"
#include "src/home/HomeController.h"
#include "src/tool/ToolController.h"
#include "src/setting/SettingController.h"
#include "src/web/WebController.h"
#include "src/utils/LogUtils.h"

#include "src/http/ApiLogin.h"
#include "src/http/ApiGetArticleList.h"

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
