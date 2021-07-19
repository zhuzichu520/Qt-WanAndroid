#ifndef SIMPLE_LOGINCONTROLLER_H
#define SIMPLE_LOGINCONTROLLER_H

#include "src/base/BaseController.h"

class LoginController : public BaseController {
Q_OBJECT
public:
    explicit LoginController(QObject *parent = nullptr);
};

#endif
