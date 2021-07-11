import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import UI.Controller 1.0
import "../base"
import "../global"
import "../view"

Fragment{

    id:root

    controller:HomeController{
    }

    ListModel{
        id:listModel
    }

    ListView{
        id:list
        anchors.fill:parent
        model: listModel
        spacing: 1
        delegate: item_article

        ScrollBar.vertical: ScrollBar {
            anchors.right: list.right
            width: 10
            active: true
        }

        ListHeader {
            id: pullToRefreshHandler
            onRefresh: timer.start()
        }

        Timer {
            id: timer
            interval: 1000
            onTriggered: pullToRefreshHandler.endRefresh()
        }
    }

    Component{
        id:item_article
        ItemDelegate{
            width: parent.width
            height: 80
            Text {
                id:item_title
                text: qsTr(model.title)
                elide: Text.ElideRight
                font{
                    pixelSize: 16
                    weight: Font.Bold
                }
                color: Theme.fontColorPrimary
                maximumLineCount: 2
                wrapMode: Text.WrapAnywhere
                anchors{
                    top: parent.top
                    left: parent.left
                    right: parent.right
                    topMargin: 15
                    leftMargin: 15
                    rightMargin: 15
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
                    topMargin: 55
                }
                Text{
                    text:{
                        if(model.author){
                            return "作者：%1".arg(model.author)
                        }
                        return "分享人：%1".arg(model.shareUser)
                    }
                    font.pixelSize: 14
                }
                Text{
                    text:"分类：%1/%2".arg(model.superChapterName).arg(model.chapterName)
                    font.pixelSize: 14
                }
                Text{
                    text:"时间：%1".arg(model.niceShareDate)
                    font.pixelSize: 14
                }
            }
            Rectangle{
                width: parent.width
                height: 1
                color: "#eeeeee"
                anchors.bottom: parent.bottom
            }
        }
    }

    onLazy: {
        loadData()
    }

    function loadData(){

        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
                print('HEADERS_RECEIVED');
            } else if(xhr.readyState === XMLHttpRequest.DONE) {
                listModel.append(JSON.parse(xhr.responseText.toString()).data.datas)
            }
        }
        xhr.open("GET", "https://www.wanandroid.com/article/list/%1/json".arg(0));
        xhr.send();
    }

}
