import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import "../base"
import "../global"

Fragment {

    id:root

    property int current: 0

    width: parent.width

    ListModel{
        id:tabModel
        ListElement{
            name:"首页"
            icon:"qrc:/drawable/ic_main_home.png"
        }
        ListElement{
            name:"公众号"
            icon:"qrc:/drawable/ic_main_wx.png"
        }
        ListElement{
            name:"体系"
            icon:"qrc:/drawable/ic_main_tree.png"
        }
        ListElement{
            name:"项目"
            icon:"qrc:/drawable/ic_main_project.png"
        }
        ListElement{
            name:"工具"
            icon:"qrc:/drawable/ic_main_tool.png"
        }

    }

    Rectangle{
        id:tab
        color: Theme.colorPrimary
        width: 72
        Behavior on width{
            NumberAnimation{
                duration: 300
            }
        }
        anchors{
            left: parent.lelt
            top:parent.top
            bottom:parent.bottom
        }

        Image{
            id:avatar
            width: 35
            height: 35
            anchors{
                horizontalCenter: parent.horizontalCenter
                top:parent.top
                topMargin: 20
            }
            source: "qrc:/drawable/ic_avatar.png"
            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    if(AppStorage.loginInfo === undefined){
                        startActivity(Router.activity_login,true)
                        return
                    }
                    fragment_setting.show()
                }
            }
        }

        Text {
            id: name
            width: parent.width
            elide: Text.ElideMiddle
            text: {
                if(AppStorage.loginInfo === undefined){
                    return "登录"
                }
                return AppStorage.loginInfo.username
            }
            horizontalAlignment: Text.AlignHCenter
            anchors{
                horizontalCenter: parent.horizontalCenter
                top:avatar.bottom
                topMargin: 5
            }
            color:Theme.color_FFFFFFFF
            font.pixelSize: 11
        }

        ListView{
            anchors{
                top: name.bottom
                left: parent.left
                right: parent.right
                bottom: setting.top
                topMargin: 10
            }
            clip: true
            model:tabModel
            delegate: tabDelegate
        }

        Item {
            id:setting
            width: parent.width
            height: parent.width
            anchors.bottom: parent.bottom
            Image {
                width: 22
                height: 22
                anchors.centerIn: parent
                source: "qrc:/drawable/ic_main_setting.png"
            }

            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    fragment_setting.show()
                }
            }

        }
    }

    StackLayout{
        id:content
        anchors{
            top: tab.top
            bottom: tab.bottom
            left: tab.right
            right: parent.right
        }
        currentIndex:current
        FragmentMainHome{
            activity:  root.activity
        }
        FragmentMainWeixin{
            activity:  root.activity
        }
        FragmentMainTree{
            activity:  root.activity
        }
        FragmentMainProject{
            activity:  root.activity
        }
        FragmentMainTool{
            activity:  root.activity
        }
    }

    Canvas {

        width: 12
        height: 48
        rotation: 180
        opacity: 0.4
        anchors {
            verticalCenter: tab.verticalCenter
            left: tab.right
        }
        contextType: "2d"
        antialiasing: false
        onPaint: {
            context.lineWidth = 2
            context.fillStyle = Theme.colorPrimary
            context.beginPath()
            context.moveTo(0, 12)
            context.lineTo(12, 0)
            context.lineTo(12, 48)
            context.lineTo(0, 36)
            context.lineTo(0, 12)
            context.closePath()
            context.fill()
        }

        Image {
            width: 10
            height: 10
            anchors.centerIn: parent
            source: tab.width == 72 ? "qrc:/drawable/ic_arrow_right.png" : "qrc:/drawable/ic_arrow_left.png"
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                parent.opacity = 1
            }
            onExited: {
                parent.opacity = 0.4
            }
            onClicked: {
                tab.width = tab.width == 72 ? 0 : 72
            }
        }
    }

    FragmentSetting{
        id:fragment_setting
        width: 300
        height: parent.height
        activity:  root.activity
    }

    Component{
        id:tabDelegate
        Item{
            width: parent.width
            height: 64
            Column{
                anchors.centerIn: parent
                Image {
                    id:tabIcon
                    height: 22
                    width: 22
                    source: icon
                    opacity: (current === model.index)?1:0.3
                }
                Text {
                    text: qsTr(name)
                    width: parent.width
                    color: Theme.color_FFFFFFFF
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 12
                    topPadding: 5
                    opacity: (current === model.index)?1:0.3
                }
            }
            MouseArea{
                anchors.fill: parent
                cursorShape: current !== model.index ? Qt.PointingHandCursor : Qt.ArrowCursor
                onClicked: {
                    current = model.index
                }
            }
        }
    }

}
