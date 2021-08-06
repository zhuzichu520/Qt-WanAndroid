#ifndef WANANDROID_VIEWPROVIDER_H
#define WANANDROID_VIEWPROVIDER_H

#include <QQuickImageProvider>

class ViewProvider : public QQuickImageProvider
{
public:
    ViewProvider();
    QImage requestImage(const QString &id, QSize *size, const QSize &requestedSize) override;
};

#endif
