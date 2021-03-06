#include "LogUtils.h"

LogUtils::LogUtils(char* argv[])
{
    google::InitGoogleLogging(argv[0]);
    configureGoogleLog();
}

LogUtils::~LogUtils()
{
    google::ShutdownGoogleLogging();
}

void LogUtils::configureGoogleLog()
{
    google::EnableLogCleaner(10);
    google::SetStderrLogging(google::GLOG_INFO);
    auto appDataDir = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
    appDataDir.append("/App");
    QDir logDir = appDataDir;
    if (!logDir.exists(appDataDir))
        logDir.mkpath(appDataDir);

    QByteArray byteLogDir = appDataDir.toUtf8();
    FLAGS_log_dir = byteLogDir.data();
#ifdef Q_NO_DEBUG
    FLAGS_logtostderr = true;
#else
    FLAGS_logtostderr = true;
#endif
    FLAGS_alsologtostderr = false;
    FLAGS_logbufsecs = 0;       //
    FLAGS_max_log_size = 10;    // MB
    FLAGS_stop_logging_if_full_disk = true;

    LOG(INFO) << "===================================================";
    LOG(INFO) << "[Product] NetEase Muticall";
    LOG(INFO) << "[DeviceId] " << QString(QSysInfo::machineUniqueId()).toStdString();
    LOG(INFO) << "[OSVersion] " << QSysInfo::prettyProductName().toStdString();
    LOG(INFO) << "===================================================";

    qInstallMessageHandler(&LogUtils::messageHandler);
}

void LogUtils::messageHandler(QtMsgType, const QMessageLogContext &context, const QString &message)
{
    if (context.file && !message.isEmpty())
    {
        LOG(INFO) << "[" << context.file << ":" << context.line << "] " << message.toStdString();
    }
}

