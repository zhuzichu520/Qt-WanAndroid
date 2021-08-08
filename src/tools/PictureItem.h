#ifndef WANANDROID_PICTUREITEM_H
#define WANANDROID_PICTUREITEM_H

#include <QtQuick/QQuickPaintedItem>
#include <QColor>
#include <QPainter>
#include <QPainterPath>
#include <QGuiApplication>
#include <QScreen>
#include "src/utils/LogUtils.h"
#include "src/utils/ImageUtils.h"

class PictureItem : public QQuickPaintedItem {
    Q_OBJECT
    Q_PROPERTY(QString source READ getSource WRITE setSource NOTIFY sourceChanged)
    Q_PROPERTY(bool isGrey READ getGrey WRITE setGrey NOTIFY greyChanged)
    Q_PROPERTY(int contrast READ getContrast WRITE setContrast NOTIFY contrastChanged)
    Q_PROPERTY(int bright READ getBright WRITE setBright NOTIFY brightChanged)
public:
    explicit PictureItem(QQuickItem *parent = nullptr);
    ~PictureItem() override;
    [[nodiscard]] QString getSource() const;
    void setSource(const QString &source);
    [[nodiscard]] bool getGrey() const;
    void setGrey(bool isGrey);
    [[nodiscard]] int getContrast() const;
    void setContrast(int contrast);
    [[nodiscard]] int getBright() const;
    void setBright(int bright);
    void paint(QPainter *painter) override;
    Q_INVOKABLE void restore();
    Q_INVOKABLE void saveImage(const QString &path);
    Q_SIGNAL void sourceChanged();
    Q_SIGNAL void greyChanged();
    Q_SIGNAL void contrastChanged();
    Q_SIGNAL void brightChanged();
private:
    inline QRect calculateReact(const QImage &image);
    inline cv::Mat calculateContrastAndBright(const cv::Mat &mat);
private:
    QString m_source;
    bool m_isGrey;
    int m_contrast;
    int m_bright;
    cv::Mat m_mat;
    cv::Mat m_temp;
};

#endif
