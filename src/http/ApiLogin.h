#ifndef APILOGIN_H
#define APILOGIN_H

#include <QObject>
#include "HttpClient.h"
#include "src/utils/LogUtils.h"
#include "Api.h"

class ApiLogin : public Api
{
    Q_OBJECT
    Q_PROPERTY(QString username READ getUsername WRITE setUsername NOTIFY usernameChanged)
    Q_PROPERTY(QString password READ getPassword WRITE setPassword NOTIFY passwordChanged)

public:

    explicit ApiLogin(QObject *parent = nullptr){}

    ~ApiLogin() override{}

    QString getPath() override {
        return  "/user/login";
    }

    const QString &getUsername() const{
        return m_username;
    }

    void setUsername(const QString &username){
        m_username = username;
        Q_EMIT usernameChanged(username);
    }

    const QString &getPassword() const{
        return m_password;
    }

    void setPassword(const QString &password){
        m_password = password;
        Q_EMIT passwordChanged(m_password);
    }

    Q_SIGNAL void usernameChanged(const QString &);

    Q_SIGNAL void passwordChanged(const QString &);

    Q_INVOKABLE void execute() override{
        HttpClient(getBaseUrl()+getPath())
                .param("username",m_username)
                .param("password",m_password)
                .success([this](const QString &response) {
                    handleResponse(response);
                    LOG(INFO)<<response.toStdString();
                }).post();
    }

private:

    QString m_password;

    QString m_username;

};

#endif
