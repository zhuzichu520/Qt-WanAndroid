#ifndef WANANDROID_VIDEOSURFACE_H
#define WANANDROID_VIDEOSURFACE_H


#include <QAbstractVideoSurface>
#include <QImage>
#include <QRect>
#include <QVideoFrame>
#include <qabstractvideosurface.h>
#include <qvideosurfaceformat.h>
#include <QVideoSurfaceFormat>
#include <opencv2/opencv.hpp>

class VideoSurface :public QAbstractVideoSurface {
    Q_OBJECT
public:

    explicit VideoSurface(QObject *parent = nullptr);

    QList<QVideoFrame::PixelFormat> supportedPixelFormats(QAbstractVideoBuffer::HandleType type) const override;

    bool isFormatSupported(const QVideoSurfaceFormat &format) const override;

    bool start(const QVideoSurfaceFormat &format) override;

    void stop() override;

    bool present(const QVideoFrame &frame) override;

    Q_SIGNAL void updateFrame(const cv::Mat &mat);

private:
    QVideoFrame m_frame;
};


#endif
