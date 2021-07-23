import QtQuick 2.9
import "../global"

Rectangle {

    property var list: root.parent.parent

    id: root
    width: list.width
    height: 25

    color: Theme.colorItemBackground

    property bool isRefresh: false

    signal refresh

    Rectangle{
        width: parent.height
        height: parent.height
        anchors.centerIn: parent
        color: Theme.transparent
        radius: 3
        Image {
            id: loading
            source: "qrc:/drawable/ic_refresh.svg"
            width: 20
            height: 20
            anchors.centerIn: parent
            RotationAnimation on rotation {
                from: 0
                to: 360
                duration: 1000
                running: isRefresh
                loops: Animation.Infinite
            }
        }
        MouseArea{
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            onEntered: {
                parent.color = Theme.colorBackground2
            }
            onExited: {
                parent.color = Theme.transparent
            }
            onClicked: {
                if(isRefresh === false){
                    isRefresh = true
                    refresh()
                }
            }
        }
    }

    function endRefresh(){
        isRefresh = false
        loading.rotation = 0
    }

}
