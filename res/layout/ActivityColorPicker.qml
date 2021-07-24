import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.5
import "../base"

Activity {
    id: activity
    width: 400
    height: 250
    maximumWidth: 400
    minimumWidth: 400
    minimumHeight: 250
    maximumHeight: 250
    flags: Qt.Dialog
    title: "颜色选择器"

    property var callBack

    onCreateView: {
        startFragment("qrc:/layout/FragmentColorPicker.qml")
    }
}
