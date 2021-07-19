import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.5
import "../base"

Activity {
    id: activity
    width: 400
    height: 400
    title: "登录注册"
    onCreateView: {
        console.debug("创建了")
        startFragment("qrc:/layout/FragmentLogin.qml")
    }
    onDestroyView: {
        console.debug("销毁了")
    }
}
