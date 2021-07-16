import QtQuick 2.0

Rectangle {

    property var list: root.parent.parent

    id: root
    width: list.width
    height: 50
    color: "red"

    signal loadMore

    Connections{
        target: list
        onContentYChanged: {
            console.debug("contentY:"+list.contentY)
            console.debug("contentHeight:"+list.contentHeight)
            console.debug("height:"+list.height)
        }
    }

}
