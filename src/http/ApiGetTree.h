#ifndef WANANDROID_APIGETTREE_H
#define WANANDROID_APIGETTREE_H

#include <QObject>
#include "HttpClient.h"
#include "Api.h"

class ApiGetTree : public Api
{
    Q_OBJECT
public:

    explicit ApiGetTree(QObject *parent = nullptr){}

    ~ApiGetTree() override = default;

    QString getPath() override {
        return  "/tree/json";
    }

    Q_INVOKABLE void execute() override{
        HttpClient(getBaseUrl()+getPath())
                .success([this](const QString &response) {
                    handleResponse(response);
                }).get();
    }

};

#endif
