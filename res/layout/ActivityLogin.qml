import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.5
import "../base"

Activity {
    id: activity
    width: 300
    height: 400
    title: "登录注册"
    onCreateView: {
        startFragment("qrc:/layout/FragmentLogin.qml")
    }
}
