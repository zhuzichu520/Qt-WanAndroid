#ifndef WANANDROID_APIGETARTICLELIST_H
#define WANANDROID_APIGETARTICLELIST_H

#include <QObject>
#include "HttpClient.h"
#include "src/utils/LogUtils.h"
#include "Api.h"

class ApiGetArticleList : public Api {
Q_OBJECT
    Q_PROPERTY(int page READ getPage WRITE setPage NOTIFY pageChanged)
    Q_PROPERTY(int cid READ getCid WRITE setCid NOTIFY cidChanged)
public:

    explicit ApiGetArticleList(QObject *parent = nullptr) {}

    ~ApiGetArticleList() override = default;

    QString getPath() override {
        return "/article/list/%1/json";
    }

    int getPage() const {
        return m_page;
    }

    void setPage(int page) {
        m_page = page;
        Q_EMIT pageChanged(page);
    }

    Q_SIGNAL void pageChanged(int page);

    int getCid() const {
        return m_cid;
    }

    void setCid(int cid) {
        m_cid = cid;
        Q_EMIT cidChanged(cid);
    }

    Q_SIGNAL void cidChanged(int cid);

    Q_INVOKABLE void execute() override {
        HttpClient client = HttpClient(getBaseUrl() + getPath().arg(m_page));
        if(m_cid != -1){
            client.param("cid",m_cid);
        }
        client.success([this](const QString &response) {
            handleResponse(response);
        }).get();
    }

private:

    int m_page = 0;

    int m_cid = -1;
};

#endif
