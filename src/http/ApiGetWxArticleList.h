#ifndef WANANDROID_APIGETWXARTICLELIST_H
#define WANANDROID_APIGETWXARTICLELIST_H

#include <QObject>
#include "HttpClient.h"
#include "Api.h"

class ApiGetWxArticleList : public Api
{
    Q_OBJECT
    Q_PROPERTY(int userId READ getUserId WRITE setUserId NOTIFY userIdChanged)
    Q_PROPERTY(int page READ getPage WRITE setPage NOTIFY pageChanged)

public:

    explicit ApiGetWxArticleList(QObject *parent = nullptr){}

    ~ApiGetWxArticleList() override = default;

    QString getPath() override {
        return  "/wxarticle/list/%1/%2/json";
    }

    int getPage() {
        return m_page;
    }

    void setPage(int page) {
        m_page = page;
        Q_EMIT pageChanged(page);
    }

    Q_SIGNAL void pageChanged(int page);

    int getUserId() {
        return m_user_id;
    }

    void setUserId(int userId) {
        m_user_id = userId;
        Q_EMIT userIdChanged(userId);
    }

    Q_SIGNAL void userIdChanged(int userId);

    Q_INVOKABLE void execute() override{
        HttpClient(getBaseUrl()+getPath().arg(m_user_id).arg(m_page))
                .success([this](const QString &response) {
                    handleResponse(response);
                }).get();
    }
private:

    int m_page;
    int m_user_id;
};

#endif
