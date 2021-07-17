import QtQuick 2.0

Rectangle {

    property var list: root.parent.parent

    id: root
    width: list.width
    height: 50

    property bool isLoading: false

    signal loadMore

    Image {
        id: loading
        source: "qrc:/drawable/ic_loading.png"
        width: 25
        height: 25
        anchors.centerIn: parent
    }

    RotationAnimation{
        id:anim_loading
        target: loading
        from: 0
        to: 360
        duration: 1500
        loops: Animation.Infinite
    }

    Connections{
        target: list
        function onContentYChanged(){
            if(list.contentHeight === list.contentY+list.height && isLoading===false)
            {
                isLoading = true
                anim_loading.start()
                loadMore()
            }
        }
    }

    function endLoadMore(){
        isLoading = false
        anim_loading.stop()
    }

}
