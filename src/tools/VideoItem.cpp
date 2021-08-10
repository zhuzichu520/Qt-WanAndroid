#include "VideoItem.h"

VideoItem::VideoItem(QQuickItem *parent)
    : QQuickPaintedItem(parent) {
    m_camera.setViewfinder(&m_surface);
    m_camera.start();
    connect(&m_surface,&VideoSurface::updateFrame, this, [&](const cv::Mat &mat) {
        mat.copyTo(m_mat);
        cv::resize(m_mat, m_mat, cv::Size(), 0.5, 0.5, cv::INTER_LINEAR);
        setInfo(
                    QString("cols:%1\nrows:%2\ndims:%3\nchannels:%4\ndepth:%5")
                    .arg(m_mat.cols)
                    .arg(m_mat.rows)
                    .arg(m_mat.dims)
                    .arg(m_mat.channels())
                    .arg(depthString(m_mat.depth()))
                    );
        update();
    });
}

VideoItem::~VideoItem() {
    m_camera.stop();
}

QString VideoItem::getInfo() const {
    return m_info;
}

void VideoItem::setInfo(const QString &info) {
    m_info = info;
    Q_EMIT infoChanged();
}

QString VideoItem::depthString(int depth){
    {
        switch (depth) {
        case 0:
            return "CV_8U";
        case 1:
            return "CV_8S";
        case 2:
            return "CV_16U";
        case 3:
            return "CV_16S";
        case 4:
            return "CV_32S";
        case 5:
            return "CV_32F";
        case 6:
            return "CV_64F";
        case 7:
            return "CV_16F";
        default:
            return "";
        }
    }
}

void VideoItem::paint(QPainter *painter) {
    painter->save();
    QImage image = ImageUtils::matToImage(m_mat);
    m_rect.setRect(0,0,width(),height());
    painter->drawImage(m_rect, image);
    painter->restore();
}
