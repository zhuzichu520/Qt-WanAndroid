import QtQuick 2.9
import "../global"

Rectangle {

    property var list: root.parent.parent

    id: root
    width: list.width
    height: 50
    color: Theme.transparent

    property bool isLoading: false

    signal loadMore

    Image {
        id: loading
        source: "qrc:/drawable/ic_loading.png"
        width: 25
        height: 25
        visible: false
        anchors.centerIn: parent
        RotationAnimation on rotation {
            from: 0
            to: 360
            duration: 1500
            loops: Animation.Infinite
        }
    }

    Connections{
        target: list
        function onContentYChanged(){
            if(list.contentHeight + list.originY === list.contentY+list.height && isLoading===false)
            {
              startLoadMore()
            }
        }
    }

    function startLoadMore(){
        loading.visible = true
        isLoading = true
        loadMore()
    }

    function endLoadMore(){
        isLoading = false
    }

}
