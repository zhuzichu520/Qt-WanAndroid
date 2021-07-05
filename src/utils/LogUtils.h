#ifndef LOGUTILS_H
#define LOGUTILS_H

#include "glog/logging.h"
#include <QObject>
#include <QStandardPaths>
#include <QDir>
#include <QDebug>

class LogUtils {
public:
    LogUtils(char* argv[]);
    ~LogUtils();

private:
    void configureGoogleLog();
    static void messageHandler(QtMsgType, const QMessageLogContext& context, const QString& message);
};

#endif
