import QtQuick 2.0
import "../base"

Activity {

    id:root
    width: 695
    height: 595
    minimumWidth: 695
    minimumHeight: 350
    visible: true
    title: qsTr("图片处理器")

    onCreateView: {
        startFragment("qrc:/layout/FragmentToolPicture.qml")
    }

}
