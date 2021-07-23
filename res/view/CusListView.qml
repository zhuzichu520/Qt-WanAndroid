import QtQuick 2.9
import QtQuick.Controls 2.5

ListView{

    id:list
    anchors.fill:parent
    boundsBehavior:Flickable.StopAtBounds

    signal refresh
    signal loadMore

    ScrollBar.vertical: ScrollBar {
        anchors.right: list.right
        width: 10
        active: true
    }

    header: ListRefresh{
        onRefresh: list.refresh()
    }

    footer: ListLoadMore{
        onLoadMore:list.loadMore()
    }

    function endRefresh(){
        list.headerItem.endRefresh()
    }

    function startRefresh(){
        list.headerItem.startRefresh()
    }

    function endLoadMore(){
        list.footerItem.endLoadMore()
    }

    function startLoadMore(){
        list.footerItem.startLoadMore()
    }

}
