import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import UI.Http 1.0
import "../base"
import "../global"


Fragment{

    id:root

    property var items:[]
    property var positionPrimary: -1

    onCreateView: {
        api_getTree.execute()
    }

    ApiGetTree{
        id:api_getTree
    }

    Connections{
        target: api_getTree
        function onError(errorCode,errorMsg){
            toast(errorMsg)
        }
        function onSuccess(data){
            console.debug(JSON.stringify(data))
            grid_primary.children = []
            for(var i = 0,len=data.length; i < len; i++) {
                data[i].index =  i
                data[i].level = 1
                delegate_item.createObject(grid_primary,{model:data[i]})
            }
            positionPrimary = 0
        }
        function onFinish(){

        }
    }

    onPositionPrimaryChanged: {
        grid_secondary.children = []
        var items = grid_primary.children[positionPrimary].model.children;
        for(var i = 0,len=items.length; i < len; i++) {
            items[i].level = 2
            delegate_item.createObject(grid_secondary,{model:items[i]})
        }
    }

    Item{
        id:layout_tree
        anchors{
            left: parent.left
            right: parent.right
            top: parent.top
        }
        height: bg_tree.height
        Rectangle{
            id:bg_tree
            width: parent.width
            anchors{
                top:parent.top
                bottom:drawer_img.bottom
            }
        }
        Behavior on height{
            NumberAnimation{
                duration: 300
            }
        }

        Text {
            id:title_primary
            text: qsTr("一级分类:")
            font{
                pixelSize: 14
                weight: Font.Bold
            }
            anchors{
                top: parent.top
                left: parent.left
                topMargin: 10
                leftMargin: 10
            }
        }

        Flow{
            id:grid_primary
            width: parent.width
            resources: items
            spacing: 5
            anchors{
                left: title_primary.right
                right: parent.right
                top: title_primary.top
                leftMargin: 10
            }
        }

        Text {
            id:title_secondary
            text: qsTr("二级分类:")
            font{
                pixelSize: 14
                weight: Font.Bold
            }
            anchors{
                top: grid_primary.bottom
                left: parent.left
                topMargin: 10
                leftMargin: 10
            }
        }

        Flow{
            id:grid_secondary
            width: parent.width
            resources: items
            spacing: 5
            anchors{
                left: title_secondary.right
                right: parent.right
                top: title_secondary.top
                leftMargin: 10
            }
        }

        Image {
            id:drawer_img
            source: "qrc:/drawable/ic_arrow_top.png"
            width: 25
            height: 16
            anchors{
                top: grid_secondary.bottom
                topMargin: 10
                horizontalCenter: parent.horizontalCenter
            }
            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    var h = bg_tree.height
                    layout_tree.height = layout_tree.height === h ? 40 : h
                }
            }
        }
    }





    Component{
        id:delegate_item
        Rectangle{
            property var model
            width: item_name.width+20
            height: item_name.height+10
            radius: 3
            Text {
                id:item_name
                text:model.name
                anchors.centerIn: parent
            }
            border{
                width: positionPrimary === model.index ? 1 :0
                color: Theme.colorPrimary
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if(model.level === 1){
                        positionPrimary = model.index
                        return
                    }
                    if(model.level === 2){
                        toast(model.name)
                    }
                }
            }

        }
    }

}
