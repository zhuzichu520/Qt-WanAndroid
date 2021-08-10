#ifndef WANANDROID_VIDEOITEM_H
#define WANANDROID_VIDEOITEM_H

#include <QtQuick/QQuickPaintedItem>
#include <QColor>
#include <QPainter>
#include <QPainterPath>
#include <QGuiApplication>
#include <QScreen>
#include <QCamera>
#include "src/utils/LogUtils.h"
#include "src/utils/ImageUtils.h"
#include "src/tools/VideoSurface.h"

class VideoItem : public QQuickPaintedItem {
    Q_OBJECT
    Q_PROPERTY(QString info READ getInfo WRITE setInfo NOTIFY infoChanged)
public:
    explicit VideoItem(QQuickItem *parent = nullptr);
    ~VideoItem() override;
    void paint(QPainter *painter) override;
    [[nodiscard]] QString getInfo() const;
    void setInfo(const QString &info);
private:
    inline QString depthString(int depth);
    Q_SIGNAL void infoChanged();
private:
    cv::Mat m_mat;
    QCamera m_camera;
    VideoSurface m_surface;
    QString m_info;
    QRect m_rect;
};

#endif
