import QtQuick 2.9
import QtQuick.Controls 2.5

ListView{

    id:list
    boundsBehavior:Flickable.StopAtBounds

    signal refresh
    signal loadMore

    property bool refreshEnable: false
    property bool loadMoreEnable: false

    ScrollBar.vertical: ScrollBar {
        anchors.right: list.right
        width: 10
    }

    header: refreshEnable ? list_refresh : null

    footer: loadMoreEnable ? list_loadmore : null

    Component{
        id:list_refresh
        ListRefresh{
            onRefresh: {
                if(loadMoreEnable)
                    list.footerItem.isFinish = false
                list.refresh()
            }
        }
    }

    Component{
        id:list_loadmore
        ListLoadMore{
            onLoadMore:list.loadMore()
        }
    }

    function endRefresh(){
        if(refreshEnable)
            list.headerItem.endRefresh()
    }

    function startRefresh(){
        if(refreshEnable)
            list.headerItem.startRefresh()
    }

    function endLoadMore(){
        if(loadMoreEnable)
            list.footerItem.endLoadMore()
    }

    function finishLoadMore(){
        if(loadMoreEnable)
            list.footerItem.finishLoadMore()
    }

    function startLoadMore(){
        if(loadMoreEnable)
            list.footerItem.startLoadMore()
    }


}
