#include "PictureItem.h"

PictureItem::PictureItem(QQuickItem *parent)
    : QQuickPaintedItem(parent) {
    restore();
}

PictureItem::~PictureItem(){

}

QString PictureItem::getSource() const {
    return m_source;
}

void PictureItem::setSource(const QString &source) {
    if (source == m_source)
        return;
    m_source = source;
    QImage image  = m_source.startsWith("screen_")
            ? QGuiApplication::primaryScreen()->grabWindow(0).toImage()
            : QImage(source);
    ImageUtils::imageToMat(image).copyTo(m_mat);
    update();
    Q_EMIT sourceChanged();
}

void PictureItem::restore() {
    if (m_isGrey != false) {
        m_isGrey = false;
        Q_EMIT greyChanged();
    }
    if (m_bright != 0) {
        m_bright = 0;
        Q_EMIT brightChanged();
    }
    if (m_contrast != 100) {
        m_contrast = 100;
        Q_EMIT contrastChanged();
    }
    update();
}

void PictureItem::saveImage(const QString &path) {
    if (m_source.isEmpty())
        return;
    cv::imwrite(path.toStdString(), m_mat);
}

bool PictureItem::getGrey() const {
    return m_isGrey;
}

void PictureItem::setGrey(bool isGrey) {
    if (m_isGrey == isGrey)
        return;
    m_isGrey = isGrey;
    update();
    Q_EMIT greyChanged();
}

int PictureItem::getContrast() const {
    return m_contrast;
}

void PictureItem::setContrast(int contrast) {
    if (contrast == m_contrast)
        return;
    m_contrast = contrast;
    update();
    Q_EMIT contrastChanged();
}

int PictureItem::getBright() const {
    return m_bright;
}

void PictureItem::setBright(int bright) {
    if (bright == m_bright)
        return;
    m_bright = bright;
    update();
    Q_EMIT brightChanged();
}

void PictureItem::paint(QPainter *painter) {
    if (m_source.isEmpty()) {
        return;
    }
    painter->save();
    painter->setRenderHints(QPainter::Antialiasing, true);
    m_mat.copyTo(m_temp);
    if (m_isGrey) {
        cv::cvtColor(m_temp, m_temp, cv::COLOR_BGR2GRAY);
    }
    m_temp = calculateContrastAndBright(m_temp);
    QImage image = ImageUtils::matToImage(m_temp);
    const QRect &rect = calculateReact(image);
    painter->drawImage(rect, image);
    painter->restore();
}

cv::Mat PictureItem::calculateContrastAndBright(const cv::Mat &mat) {
    cv::Mat dst = cv::Mat::zeros(mat.size(), mat.type());
    mat.convertTo(dst, -1, m_contrast * 0.01, m_bright);
    return dst;
}

QRect PictureItem::calculateReact(const QImage &image) {
    qreal scale;
    qreal dx;
    qreal dy;
    qreal dwidth = image.width();
    qreal dheight = image.height();
    qreal vwidth = width();
    qreal vheight = height();
    if (dwidth <= vwidth && dheight <= vheight) {
        scale = 1.0;
    } else {
        scale = qMin(vwidth / dwidth, vheight / dheight);
    }
    auto rwidth = dwidth * scale;
    auto rheight = dheight * scale;
    dx = (vwidth - rwidth) * 0.5 + 0.5;
    dy = (vheight - rheight) * 0.5 + 0.5;
    return QRect(
                static_cast<int>(dx),
                static_cast<int>(dy),
                static_cast<int>(rwidth),
                static_cast<int>(rheight)
                );
}
