import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import UI.Controller 1.0
import Qt.labs.settings 1.0
import QtQuick.Dialogs 1.0
import "../base"
import "../global"
import "../view"

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

    ListModel{
        id:settingModel
        ListElement{
            type:0
        }
        ListElement{
            type:1
        }
    }

    Component{
        id:com_theme
        Rectangle{
            width: parent.width
            height: 40
            radius: 3
            color:Theme.colorItemBackground
            Text{
                text: "主题颜色"
                anchors{
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: 20
                }
                color:Theme.colorFontPrimary
            }
            Rectangle{
                width: 28
                height: 28
                radius: 14
                anchors{
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                    rightMargin: 20
                }
                color: Theme.colorPrimary
                MouseArea{
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        dialog_color.open()
                    }
                }
            }
        }
    }

    ColorDialog{
        id:dialog_color
        currentColor: AppStorage.colorPrimary
        onAccepted: {
            AppStorage.colorPrimary = color.toString()
        }
    }

    Component{
        id:com_dark
        Rectangle{
            width: parent.width
            height: 40
            radius: 3
            color:Theme.colorItemBackground
            Text{
                text: "夜间模式"
                anchors{
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: 20
                }
                color:Theme.colorFontPrimary
            }
            CusSwitch{
                checked: AppStorage.isDark
                anchors{
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                    rightMargin: 12
                }
                onCheckedChanged: {
                    AppStorage.isDark = checked
                }
            }
        }
    }

    Rectangle
    {
        id:content
        width: parent.width
        height: parent.height
        anchors.centerIn: parent
        color: Theme.colorBackground2

        ListView{
            id:list
            anchors{
                top: parent.top
                bottom: logout.top
                bottomMargin: 20
                topMargin: 20
                left: parent.left
                right: parent.right
                leftMargin: 5
                rightMargin: 5
            }
            spacing: 5
            model: settingModel
            delegate: Loader{
                width: list.width
                sourceComponent: {
                    switch(model.type){
                    case 0:
                        return com_dark
                    case 1:
                        return com_theme
                    }
                }
            }
        }

        CusButton{
            id:logout
            text: qsTr("退出登录")
            visible: AppStorage.loginInfo!==undefined
            anchors{
                bottom:  parent.bottom
                bottomMargin: 20
                horizontalCenter: parent.horizontalCenter
            }
            onClicked: {
                AppStorage.loginInfo = undefined
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

    Colorpicker{

    }

    function show(){
        root.x = 0
    }

    function hide(){
        root.x = -root.width
    }

}
