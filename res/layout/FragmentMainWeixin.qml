import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import UI.Http 1.0
import "../base"
import "../global"
import "../view"

Fragment{

    id:root

    property int page: 1
    property int userId: 0
    property int position: -1

    onCreateView: {
        api_getWxChapters.execute()
    }

    ApiGetWxChapters{
        id:api_getWxChapters
    }
    Connections{
        target: api_getWxChapters
        function onError(errorCode,errorMsg){
            toast(errorMsg)
        }
        function onSuccess(data){
            modelChapter.clear()
            modelChapter.append(data)
            position = 0
        }
        function onFinish(){

        }
    }

    ApiGetWxArticleList{
        id:api_ApiGetWxArticleList
        page:root.page
        userId:root.userId
    }

    Connections{
        target: api_ApiGetWxArticleList
        function onError(errorCode,errorMsg){
            toast(errorMsg)
        }
        function onSuccess(data){
            if(page == 1){
                modelArticle.clear()
            }
            if(data.size)
            modelArticle.append(data.datas)
            if(data.curPage === data.pageCount){
                list_left.finishLoadMore()
            }
            page++
        }
        function onFinish(){
            list_left.endLoadMore()
            list_left.endRefresh()
        }
    }

    onPositionChanged: {
        list_left.positionViewAtBeginning()
        root.userId =modelChapter.get(position).id
        list_left.startRefresh()
    }

    ListModel{
        id:modelChapter
    }

    ListModel{
        id:modelArticle
    }

    CusListView{
        id:list_right
        width: 120
        height: parent.height
        anchors.right: parent.right
        model:modelChapter
        delegate: item_chapter
    }

    CusListView{
        id: list_left
        anchors{
            left: parent.left
            right: list_right.left
            top: parent.top
            bottom: parent.bottom
        }
        loadMoreEnable: true
        refreshEnable: true
        model: modelArticle
        delegate: item_article
        onRefresh: {
            page = 1
            api_ApiGetWxArticleList.execute()
        }
        onLoadMore: {
            api_ApiGetWxArticleList.execute()
        }
    }


    Rectangle{
        width: 1
        height: parent.height
        anchors.left:list_right.left
        color: Theme.colorDivider
    }

    Component{
        id:item_article

        Rectangle{
            width: list_left.width
            height: 70
            color:Theme.colorItemBackground

            Text {
                id:item_title
                text: model.title
                font.pixelSize: 14
                font.weight: Font.Bold
                width: parent.width-40
                wrapMode: Text.WrapAnywhere
                textFormat: Text.RichText
                anchors{
                    left: parent.left
                    top:parent.top
                    topMargin: 10
                    leftMargin: 20
                }
                color:Theme.colorFontPrimary
            }

            Text {
                text: "时间：%1".arg(model.niceDate)
                font.pixelSize: 12
                anchors{
                    bottom: parent.bottom
                    left: item_title.left
                    bottomMargin: 5
                }
                color:Theme.colorFontTertiary
            }

            Rectangle{
                width: parent.width
                height: 1
                color: Theme.colorDivider
                anchors.bottom: parent.bottom
            }

            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    startActivity(Router.activity_web,false,{webUrl:model.link})
                }
            }
        }
    }


    Component{
        id:item_chapter

        Rectangle{
            width: list_right.width
            height: 50
            color:Theme.colorItemBackground
            Text {
                text: qsTr(model.name)
                font.pixelSize: 14
                anchors.centerIn: parent
            }
            Rectangle{
                width: 7
                height: parent.height
                anchors.left: parent.left
                color: (position === model.index) ? Theme.colorPrimary : Theme.transparent
            }
            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    position = index
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
