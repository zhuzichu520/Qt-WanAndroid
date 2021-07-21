#ifndef SIMPLE_WEBCONTROLLER_H
#define SIMPLE_WEBCONTROLLER_H

#include "src/base/BaseController.h"
#include <QString>
#include <qdebug.h>
#include <QNetworkReply>
#include <QObject>
#include "src/application/Application.h"

class WebController : public BaseController {
Q_OBJECT
public:
    explicit WebController(QObject *parent = nullptr);

    ~WebController() override;

};

#endif
