import QtQuick 2.9
import QtQuick.Controls 2.5
import UI.Controller 1.0
import "../base"
import "../global"
import "../view"
import "../third_party/colorpicker"


Fragment {

    Rectangle{
        anchors.fill: parent
        color: "#3C3C3C"
    }

    ColorPicker{
       id:color_picker
    }

    CusButton{
        text: "确认"
        anchors{
            right: parent.right
            bottom: parent.bottom
            rightMargin: 10
            bottomMargin: 10
        }
        onClicked: {
            activity.callBack(color_picker.colorValue)
            back()
        }
    }

}
