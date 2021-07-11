#ifndef SIMPLE_HOMECONTROLLER_H
#define SIMPLE_HOMECONTROLLER_H

#include "src/base/BaseController.h"
#include <QString>
#include <qdebug.h>
#include <QNetworkReply>
#include <QObject>
#include "src/application/Application.h"
#include "src/http/HttpClient.h"

class HomeController : public BaseController {
Q_OBJECT
public:
    explicit HomeController(QObject *parent = nullptr);

    ~HomeController() override;

    Q_INVOKABLE void loadData(int page);

    void onLazy() override;

};

#endif
