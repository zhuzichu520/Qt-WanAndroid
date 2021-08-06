#include "ViewProvider.h"
#include "QCoreApplication"
#include "src/utils/LogUtils.h"

ViewProvider::ViewProvider() : QQuickImageProvider(QQuickImageProvider::Image) {

}

QImage ViewProvider::requestImage(const QString &id, QSize *size, const QSize &requestedSize) {
    QString strFileName = QCoreApplication::applicationDirPath() + "/" + id;
    LOG(INFO)<<QString("执行了:%1").arg(strFileName).toStdString();
    QImage image = QImage(strFileName);
//    const cv::Mat &mat = ImageUtils::imageToMat(image);
//    cv::cvtColor(mat,mat,cv::COLOR_BGR2GRAY);
    return image;
}
