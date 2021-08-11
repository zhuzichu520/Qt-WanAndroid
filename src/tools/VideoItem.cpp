#include "VideoItem.h"
#include <QCoreApplication>

VideoItem::VideoItem(QQuickItem *parent)
    : QQuickPaintedItem(parent) {
    m_camera.setViewfinder(&m_surface);
    m_camera.start();
    if(!m_face_cascade.load(QCoreApplication::applicationDirPath().append("/haarcascade_frontalface_alt.xml").toStdString())){
        LOG(INFO)<<"加载人脸模型失败:";
    }
    if(!m_eye_cascade.load(QCoreApplication::applicationDirPath().append("/haarcascade_eye_tree_eyeglasses.xml").toStdString())){
        LOG(INFO)<<"加载眼睛模型失败:";
    }
    connect(&m_surface,&VideoSurface::updateFrame, this, [&](const cv::Mat &mat) {
        mat.copyTo(m_mat);
        cv::resize(m_mat, m_mat, cv::Size(), 0.5, 0.5, cv::INTER_LINEAR);
        std::vector<cv::Rect> face_rects;
        cv::Mat mat_grey;
        cv::cvtColor(m_mat,mat_grey,cv::COLOR_BGR2GRAY);
        m_face_cascade.detectMultiScale(mat_grey,face_rects,1.1,3,0 | cv::CASCADE_SCALE_IMAGE, cv::Size(32,32));
        for (size_t i = 0; i < face_rects.size(); i++) {
            cv::Mat faceROI = m_mat(face_rects[i]);
            cv::GaussianBlur(faceROI, faceROI, cv::Size(25, 25), 3, 3);
            cv::rectangle(m_mat, cv::Point(face_rects[i].x, face_rects[i].y), cv::Point(face_rects[i].x + face_rects[i].width, face_rects[i].y + face_rects[i].height), cv::Scalar(255, 0, 0), 1, 8);
            //            std::vector<cv::Rect> eye_rects;
            //            m_eye_cascade.detectMultiScale(faceROI,eye_rects,1.1,3,0 | cv::CASCADE_SCALE_IMAGE);
            //            for (size_t j = 0; j < eye_rects.size(); j++) {
            //                    cv::Point center(face_rects[i].x + eye_rects[j].x + eye_rects[j].width*0.5, face_rects[i].y + eye_rects[j].y + eye_rects[j].height*0.5);
            //                    int radius = cvRound((eye_rects[j].width + eye_rects[j].height)*0.25);
            //                    circle(m_mat, center, radius, cv::Scalar(255, 0, 0), 4, 8, 0);
            //                }
        }
        setInfo(
                    QString("cols:%1\nrows:%2\ndims:%3\nchannels:%4\ndepth:%5")
                    .arg(m_mat.cols)
                    .arg(m_mat.rows)
                    .arg(m_mat.dims)
                    .arg(m_mat.channels())
                    .arg(depthString(m_mat.depth()))
                    );
        std::vector<cv::Rect>().swap(face_rects);
        update() ;
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
