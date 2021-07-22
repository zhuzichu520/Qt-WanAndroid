import QtQuick 2.9
import QtQuick.Controls 2.5
import "../global"

Switch {

    id: root

    property color checkedColor: Theme.colorPrimary

    bottomPadding: 0
    leftPadding: 0
    rightPadding: 0

    indicator: Rectangle {
        width: 45
        height: 25
        radius: height / 2
        color: root.checked ? checkedColor : "white"
        border.width: 1
        border.color: root.checked ? checkedColor : "#E5E5E5"
        Rectangle {
            x: root.checked ? parent.width - width - 1 : 0
            width: root.checked ? parent.height - 4 : parent.height - 1
            height: width
            radius: width / 2
            anchors.verticalCenter: parent.verticalCenter
            color: "white"
            border.color: "#D5D5D5"
            border.width: 1
            Behavior on x {
                NumberAnimation { duration: 200 }
            }
        }
    }
}
