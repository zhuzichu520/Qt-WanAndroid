#include "BaseController.h"


BaseController::BaseController(QObject *parent) {

}


BaseController::~BaseController() {

}

void BaseController::onCreateView(QObject *root) {
    m_root = root;
    initView();
}


void BaseController::onDestroyView() {

}

void BaseController::onResume() {

}

void BaseController::onPause() {

}

void BaseController::startActivity(const QVariant &url) {
    Q_EMIT startActivityEvent(url);
}

void BaseController::startFragment(const QVariant &url) {
    Q_EMIT startFragmentEvent(url);
}

void BaseController::back() {
    Q_EMIT backEvent();
}

void BaseController::toast(const QString &text) {
    Q_EMIT toastEvent(text);
}
