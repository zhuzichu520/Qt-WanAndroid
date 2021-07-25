#ifndef WANANDROID_APIGETWXCHAPTERS_H
#define WANANDROID_APIGETWXCHAPTERS_H

#include <QObject>
#include "HttpClient.h"
#include "Api.h"

class ApiGetWxChapters : public Api
{
    Q_OBJECT
public:

    explicit ApiGetWxChapters(QObject *parent = nullptr){}

    ~ApiGetWxChapters() override = default;

    QString getPath() override {
        return  "/wxarticle/chapters/json";
    }

    Q_INVOKABLE void execute() override{
        HttpClient(getBaseUrl()+getPath())
                .success([this](const QString &response) {
                    handleResponse(response);
                }).get();
    }

};

#endif
