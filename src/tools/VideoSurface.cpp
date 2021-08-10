#include "VideoSurface.h"
#include "src/utils/ImageUtils.h"

VideoSurface::VideoSurface(QObject *parent) : QAbstractVideoSurface(parent) {

}

QList<QVideoFrame::PixelFormat> VideoSurface::supportedPixelFormats(QAbstractVideoBuffer::HandleType type) const {
    if (type == QAbstractVideoBuffer::NoHandle) {
        return QList<QVideoFrame::PixelFormat>() << QVideoFrame::Format_RGB32 << QVideoFrame::Format_ARGB32
                                                 << QVideoFrame::Format_ARGB32_Premultiplied
                                                 << QVideoFrame::Format_RGB565 << QVideoFrame::Format_RGB555;
    } else {
        return QList<QVideoFrame::PixelFormat>();
    }
}

bool VideoSurface::isFormatSupported(const QVideoSurfaceFormat &format) const {
    return QVideoFrame::imageFormatFromPixelFormat(format.pixelFormat()) != QImage::Format_Invalid &&
            !format.frameSize().isEmpty() && format.handleType() == QAbstractVideoBuffer::NoHandle;
}

bool VideoSurface::start(const QVideoSurfaceFormat &format) {
    const QImage::Format imageFormat = QVideoFrame::imageFormatFromPixelFormat(format.pixelFormat());
    const QSize size = format.frameSize();
    if (imageFormat != QImage::Format_Invalid && !size.isEmpty()) {
        this->m_format = imageFormat;
        QAbstractVideoSurface::start(format);
        return true;
    }
    return false;
}

void VideoSurface::stop() {
    QAbstractVideoSurface::stop();
}

bool VideoSurface::present(const QVideoFrame &frame) {
    if (surfaceFormat().pixelFormat() != frame.pixelFormat() || surfaceFormat().frameSize() != frame.size()) {
        setError(IncorrectFormatError);
        stop();
        return false;
    }
    m_frame = frame;
    if (m_frame.map(QAbstractVideoBuffer::ReadOnly)) {
        //img就是转换的数据了
        const QImage &image = QImage(m_frame.bits(),m_frame.width(),m_frame.height(),m_frame.bytesPerLine(),m_format);
        cv::Mat mat = ImageUtils::imageToMat(image);
        Q_EMIT updateFrame(mat);
    }
    return true;
}
