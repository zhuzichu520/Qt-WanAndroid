import QtQuick 2.9
import "../global"

Rectangle {

    property var list: root.parent.parent

    id: root
    width: list.width
    height: 50
    color: Theme.transparent

    property bool isLoading: false

    property bool isFinish: false

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

    Text {
        text: qsTr("亲，已经到底了哦~")
        anchors.centerIn: parent
        font.pixelSize: 14
        color: Theme.colorPrimary
        visible: isFinish
    }

    Connections{
        target: list
        function onContentYChanged(){
            if(list.contentHeight + list.originY === list.contentY+list.height && isLoading===false && !isFinish)
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

    function finishLoadMore(){
        isFinish = true
        loading.visible = false
    }

    function endLoadMore(){
        isLoading = false
    }

}
