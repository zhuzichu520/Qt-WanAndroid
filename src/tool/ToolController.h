#ifndef SIMPLE_TOOLCONTROLLER_H
#define SIMPLE_TOOLCONTROLLER_H

#include "src/base/BaseController.h"
#include <QString>
#include <qdebug.h>
#include <QNetworkReply>
#include <QObject>
#include "src/application/Application.h"

class ToolController : public BaseController {
Q_OBJECT
public:
    explicit ToolController(QObject *parent = nullptr);

    ~ToolController() override;

};

#endif
