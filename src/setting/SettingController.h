#ifndef SIMPLE_SETTINGCONTROLLER_H
#define SIMPLE_SETTINGCONTROLLER_H

#include "src/base/BaseController.h"
#include <QString>
#include <qdebug.h>
#include <QNetworkReply>
#include <QObject>
#include "src/application/Application.h"

class SettingController : public BaseController {
Q_OBJECT
public:
    explicit SettingController(QObject *parent = nullptr);

    ~SettingController() override;

};

#endif
