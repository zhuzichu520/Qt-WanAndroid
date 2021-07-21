import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import UI.Controller 1.0
import "../base"
import "../global"

Fragment{

    id:root

    controller:ToolController{
    }

    onResume: {
        console.debug("Tool_onResume")
    }

    onPause: {
        console.debug("Tool_onPause")
    }

    onCreateView: {
        console.debug("Tool_onCreateView")
    }

    onDestroyView: {
        console.debug("Tool_onDestroyView")
    }

    Text {
        anchors.centerIn: parent
        text: qsTr("工具页面")
        MouseArea{
            anchors.fill: parent
            onClicked: {
                back()
            }
        }
    }

}
