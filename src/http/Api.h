#ifndef WANANDROID_API_H
#define WANANDROID_API_H

#include <QObject>
#include <QJsonDocument>
#include <QJsonObject>
#include "src/utils/LogUtils.h"

class Api : public QObject {
Q_OBJECT
public:

    explicit Api(QObject *parent = nullptr);

    ~Api() override;

    QString getBaseUrl() {
        return  "https://www.wanandroid.com";
    }

    virtual QString getPath() = 0;

    virtual void execute() = 0;

    void handleResponse(const QString &response);

    Q_SIGNAL void success(const QVariant &data);
    Q_SIGNAL void error(int errorCode,const QString &errorMsg);
    Q_SIGNAL void finish();
};

#endif
