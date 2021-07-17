import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import UI.Controller 1.0
import "../base"
import "../global"

Fragment{

    id:root
    visible: true
    x:-root.width

    controller:SettingController{
    }

    Behavior on x{
        NumberAnimation{
            duration: 300
            easing.type: Easing.InOutQuart
        }
    }

    Rectangle
    {
        width: parent.width
        height: parent.height
        id:content
        anchors.centerIn: parent
        color: Theme.backGroundColor
    }


    Text {
        anchors.centerIn: parent
        text: qsTr("设置页面")
        MouseArea{
            anchors.fill: parent
            onClicked: {
                hide()
            }
        }
    }

    function show(){
        root.x = 0
    }

    function hide(){
        root.x = -root.width
    }

}
