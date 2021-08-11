#ifndef WANANDROID_IMAGEUTILS_H
#define WANANDROID_IMAGEUTILS_H

#include <QImage>
#include "src/utils/LogUtils.h"
#include <opencv2/opencv.hpp>
#include <QVideoFrame>
#include <QImage>

class ImageUtils {
public:

    ImageUtils();

    static cv::Mat imageToMat(const QImage &image);

    static QImage matToImage(const cv::Mat& mat);

    static cv::Mat frameToMat(const QVideoFrame &frame);

};

#endif
