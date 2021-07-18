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
            index:0
        }
        ListElement{
            name:"工具"
            icon:"qrc:/drawable/ic_main_tool.png"
            index:1
        }
    }

    Rectangle{
        id:tab
        color: "#FF455B55"
        width: 70
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
                    startActivity(Router.activity_login,true)
                }
            }
        }

        ListView{
            anchors{
                top: avatar.bottom
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
        FragmentHome{

        }
        FragmentTool{

        }
    }

    FragmentSetting{
        id:fragment_setting
        width: 300
        height: parent.height
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
