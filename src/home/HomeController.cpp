#include "HomeController.h"
#include <QJsonParseError>
#include <QJsonObject>
#include <QJsonArray>

HomeController::HomeController(QObject *parent) : BaseController(parent) {

}

HomeController::~HomeController() {

}

void HomeController::loadData(int page) {
    HttpClient(QString("https://www.wanandroid.com/article/list/%1/json").arg(page)).success(
            [this](const QString &response) {

            }).get();
}

void HomeController::onLazy() {
    loadData(1);
}
