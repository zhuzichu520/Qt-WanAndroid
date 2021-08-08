import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import UI.Http 1.0
import "../base"
import "../global"
import "../view"

Fragment{

    id:root

    property int page: 0
    property int positionPrimary: -1
    property int positionSecondary: -1
    property bool isOpenDarwder : true


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
            grid_primary.children = []
            var index = 0
            for(var i = 0,len=data.length; i < len; i++) {
                var item = data[i]
                item.index =  index
                item.level = 1
                if(item.children.length === 0)
                    continue
                index++
                delegate_primary.createObject(grid_primary,{model:item})
            }
            positionPrimary = 0
        }
        function onFinish(){

        }
    }

    ApiGetArticleList{
        id:api_getArticleList
        page: root.page
        cid:60
    }

    Connections{
        target: api_getArticleList
        function onError(errorCode,errorMsg){
            toast(errorMsg)
        }
        function onSuccess(data){
            if(page === 0){
                listModel.clear()
            }
            var datas = data.datas
            for(var i=0;i<datas.length;i++){
                datas[i].shareDate=""
            }
            listModel.append(datas)
            if(data.curPage === data.pageCount){
                list.finishLoadMore()
            }
            page++
        }
        function onFinish(){
            list.endLoadMore()
            list.endRefresh()
        }
    }

    onPositionPrimaryChanged: {
        grid_secondary.children = []
        var items = grid_primary.children[positionPrimary].model.children;
        for(var i = 0,len=items.length; i < len; i++) {
            items[i].level = 2
            items[i].index = i
            delegate_secondary.createObject(grid_secondary,{model:items[i]})
        }
        positionSecondary = 0
    }

    onPositionSecondaryChanged: {
        if(positionSecondary == -1)
            return
        isOpenDarwder = false
        list.positionViewAtBeginning()
        timer_execute.start()
    }

    Timer{
        id:timer_execute
        interval: 300
        onTriggered: {
            api_getArticleList.cid = grid_secondary.children[positionSecondary].model.id
            list.startRefresh()
        }
    }

    ListModel{
        id:listModel
    }

    CusListView{
        id:list
        anchors{
            left: parent.left
            right: parent.right
            top: layout_drawer.bottom
            bottom: parent.bottom
        }
        model: listModel
        delegate: delegate_article
        refreshEnable: true
        loadMoreEnable: true
        onRefresh: {
            page=0
            api_getArticleList.execute()
        }
        onLoadMore: {
            api_getArticleList.execute()
        }
    }

    MouseArea{
        anchors.fill: layout_tree
        onWheel: {}
    }

    Flickable{
        id:layout_tree
        width: parent.width
        y:isOpenDarwder ? layout_drawer.height : layout_drawer.height-layout_tree.height
        height: Math.min(content.height,300)
        contentWidth: width
        clip: true
        boundsBehavior: Flickable.StopAtBounds
        contentHeight: content.height
        ScrollBar.vertical: ScrollBar {
            anchors.right: layout_tree.right
            width: 10
            contentItem.opacity: 1
        }
        Behavior on y {
            NumberAnimation{
                duration: 300
            }
        }
        Rectangle{
            id:content
            width: parent.width
            color: Theme.colorItemBackground
            height: childrenRect.height + 20
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
                color:Theme.colorFontPrimary
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
                spacing: 5
                anchors{
                    left: title_primary.right
                    right: parent.right
                    top: title_primary.top
                    leftMargin: 10
                    rightMargin: 20
                }
            }

            Text {
                id:title_secondary
                text: qsTr("二级分类:")
                color:Theme.colorFontPrimary
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
                spacing: 5
                anchors{
                    left: title_secondary.right
                    right: parent.right
                    top: title_secondary.top
                    leftMargin: 10
                    rightMargin: 20
                }
            }
        }
    }

    Image {
        width: layout_tree.width
        height: 5
        anchors{
            top:layout_tree.bottom
        }
        source: "qrc:/drawable/ic_shadow_bottom.png"
    }

    Rectangle{
        id:layout_drawer
        width: parent.width
        height: 30
        color: Theme.colorBackground2
        anchors{
            top:parent.top
        }
        Image {
            source: "qrc:/drawable/ic_arrow_top.png"
            width: 25
            height: 16
            anchors.centerIn: parent
            rotation: isOpenDarwder ? 0 : 180
            Behavior on rotation{
                NumberAnimation{
                    duration: 300
                }
            }
        }
        MouseArea{
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                isOpenDarwder = !isOpenDarwder
            }
        }
    }

    Component{
        id:delegate_article
        Rectangle{
            width: list.width
            height: 80
            color:Theme.colorItemBackground
            MouseArea{
                anchors.fill: parent
                propagateComposedEvents: false
                preventStealing: true
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    startActivity(Router.activity_web,false,{webUrl:model.link})
                }
            }

            TextEdit {
                id:item_title
                text: model.title
                font{
                    pixelSize: 16
                    weight: Font.Bold
                }
                readOnly: true
                selectByMouse: true
                color: Theme.colorFontPrimary
                wrapMode: Text.WrapAnywhere
                textFormat: Text.RichText
                anchors{
                    top: parent.top
                    left: parent.left
                    topMargin: 15
                    leftMargin: 15
                }
                width: {
                    var w = parent.width-30
                    if(item_title.implicitWidth > w)
                        return w
                    return item_title.implicitWidth
                }
            }

            Row{
                spacing: 20
                anchors{
                    bottom: parent.bottom
                    top: parent.top
                    left: parent.left
                    right: parent.right
                    leftMargin: 15
                    topMargin: 60
                }
                Text{
                    text:{
                        if(model.author){
                            return "作者：%1".arg(model.author)
                        }
                        return "分享人：%1".arg(model.shareUser)
                    }
                    font.pixelSize: 14
                    color: Theme.colorFontSecondary
                }
                Text{
                    text:"分类：%1/%2".arg(model.superChapterName).arg(model.chapterName)
                    font.pixelSize: 14
                    color: Theme.colorFontSecondary
                }
                Text{
                    text:"时间：%1".arg(model.niceShareDate)
                    font.pixelSize: 14
                    color: Theme.colorFontSecondary
                }
            }
            Rectangle{
                width: parent.width
                height: 1
                color: Theme.colorDivider
                anchors.bottom: parent.bottom
            }
        }
    }



    Component{
        id:delegate_primary
        Rectangle{
            property var model
            property var isChoose : positionPrimary === model.index
            width: item_name.width+20
            height: item_name.height+10
            radius: 3
            color:isChoose ? Theme.colorPrimary : Theme.colorBackground2
            Text {
                id:item_name
                text:model.name
                anchors.centerIn: parent
                color:isChoose ? Theme.color_FFFFFFFF : Theme.colorFontPrimary
            }
            MouseArea{
                anchors.fill: parent
                cursorShape: isChoose ? Qt.ArrowCursor : Qt.PointingHandCursor
                onClicked: {
                    positionSecondary = -1
                    positionPrimary = model.index
                }
            }
        }
    }

    Component{
        id:delegate_secondary
        Rectangle{
            property var model
            property var isChoose : positionSecondary === model.index
            width: item_name.width+20
            height: item_name.height+10
            radius: 3
            color:isChoose ? Theme.colorPrimary : Theme.colorBackground2
            Text {
                id:item_name
                text:model.name
                anchors.centerIn: parent
                color:isChoose ? Theme.color_FFFFFFFF : Theme.colorFontPrimary
            }
            MouseArea{
                anchors.fill: parent
                cursorShape: isChoose ? Qt.ArrowCursor : Qt.PointingHandCursor
                onClicked: {
                    positionSecondary = model.index
                }
            }
        }
    }

}
