#ifndef WANANDROID_VIEWHOTKEY_H
#define WANANDROID_VIEWHOTKEY_H

#include <QObject>

class ViewHotkey : public QObject {
Q_OBJECT
public:
    explicit ViewHotkey(QObject *parent = nullptr);

    Q_SIGNAL void hotKeyActivated(const QString &key);

};


#endif
