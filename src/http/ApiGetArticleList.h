#ifndef APIGETARTICLELIST_H
#define APIGETARTICLELIST_H

#include <QObject>
#include "HttpClient.h"
#include "src/utils/LogUtils.h"
#include "Api.h"

class ApiGetArticleList : public Api {
Q_OBJECT
    Q_PROPERTY(int page READ getPage WRITE setPage NOTIFY pageChanged)

public:

    explicit ApiGetArticleList(QObject *parent = nullptr) {}

    ~ApiGetArticleList() override {}

    QString getPath() override {
        return "/article/list/%1/json";
    }

    int getPage() {
        return m_page;
    }

    void setPage(int page) {
        m_page = page;
        Q_EMIT pageChanged(page);
    }

    Q_SIGNAL void pageChanged(int page);

    Q_INVOKABLE void execute() override {
        HttpClient(getBaseUrl() + getPath().arg(m_page))
                .success([this](const QString &response) {
                    handleResponse(response);
                    LOG(INFO) << response.toStdString();
                }).get();
    }

private:

    int m_page;

};

#endif
