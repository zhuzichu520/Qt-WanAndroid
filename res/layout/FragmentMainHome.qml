import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import UI.Http 1.0
import "../base"
import "../global"
import "../view"

Fragment{

    property int page: 0

    id:root

    ApiGetArticleList{
        id:api_getArticleList
        page: root.page
    }

    onCreateView: {
        list.startRefresh()
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
            listModel.append(data.datas)
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


    ListModel{
        id:listModel
    }

    CusListView{
        id:list
        anchors.fill:parent
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

}
