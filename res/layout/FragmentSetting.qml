import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import UI.Controller 1.0
import Qt.labs.settings 1.0
import "../base"
import "../global"

Fragment{

    id:root
    visible: true
    x:-root.width

    clip: true

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
        id:content
        width: parent.width
        height: parent.height
        anchors.centerIn: parent
        color: Theme.backGroundColor


        Button{
            text: "退出登录"
            visible: AppStorage.loginInfo!==null
            anchors{
                bottom:  parent.bottom
                bottomMargin: 20
                horizontalCenter: parent.horizontalCenter
            }
            onClicked: {
                AppStorage.loginInfo = null
                hide()
            }
        }
    }


    Image {
        width: 25
        height: 25
        source: "qrc:/drawable/ic_setting_back.png"
        anchors{
            right: parent.right
            bottom: parent.bottom
            rightMargin: 15
            bottomMargin: 15
        }
        MouseArea{
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
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
