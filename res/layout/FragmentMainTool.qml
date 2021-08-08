import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import "../base"
import "../global"
import "../view"

Fragment{

    id:root

    ListModel{
        id:listModel
        ListElement{
            title:"图片处理器"
            onClick:function(){
                startActivity(Router.activity_tool_picture)
            }
        }
        ListElement{
            title:"视频处理器"
            onClick:function(){
                startActivity(Router.activity_tool_video)
            }
        }
        ListElement{
            title:"颜色选取器"
            onClick:function(){}
        }
    }

    GridView{
        anchors.fill: parent
        model: listModel
        cellWidth: 120
        cellHeight: 120
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        delegate: Item{
            width: 120
            height: 120
            Rectangle{
                width: 100
                height: 100
                radius: 4
                anchors.centerIn: parent
                color: Theme.colorItemBackground
                Text {
                    id:item_title
                    text: model.title
                    font.pixelSize: 14
                    anchors.centerIn: parent
                    color: Theme.colorFontPrimary
                    font.bold: Font.Black
                }
                MouseArea{
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    hoverEnabled: true
                    onEntered: {
                        parent.color = Qt.binding(function(){
                            return Theme.colorPrimary
                        })
                        item_title.color = Qt.binding(function(){
                            return Theme.color_FFFFFFFF
                        })
                    }
                    onExited: {
                        parent.color = Qt.binding(function(){
                            return Theme.colorItemBackground
                        })
                        item_title.color = Qt.binding(function(){
                            return Theme.colorFontPrimary
                        })
                    }
                    onClicked: {
                        if(model.path === ""){
                            toast("功能还未实现")
                            return
                        }
                        model.onClick()
                    }
                }
            }
        }
    }

}
