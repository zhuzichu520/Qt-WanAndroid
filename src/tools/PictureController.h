#ifndef WANANDROID_PICTURECONTROLLER_H
#define WANANDROID_PICTURECONTROLLER_H

#include "src/base/BaseController.h"

class PictureController : public BaseController {
Q_OBJECT
public:
    explicit PictureController(QObject *parent = nullptr);

    void initView() override {

    }

};

#endif
