#include "Api.h"

Api::Api(QObject *parent) {

}

Api::~Api() {

}

void Api::handleResponse(const QString &response) {
    QJsonParseError jsonError{};
    QJsonDocument  jsonDoc = QJsonDocument::fromJson(response.toUtf8(),&jsonError);
    if(jsonError.error != QJsonParseError::NoError){
        LOG(ERROR)<<"JSON格式错误";
        Q_EMIT error(-1,"JSON格式错误");
        Q_EMIT finish();
        return;
    }
    const QJsonObject &obj = jsonDoc.object();
    int errorCode = obj.value("errorCode").toInt();
    const QString &errorMsg = obj.value("errorMsg").toString();
    if(errorCode != 0){
        Q_EMIT error(errorCode,errorMsg);
        Q_EMIT finish();
        return;
    }
    Q_EMIT success(obj.value("data"));
    Q_EMIT finish();
}
