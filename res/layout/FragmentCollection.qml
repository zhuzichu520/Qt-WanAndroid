import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import QtQuick.Dialogs 1.0

import "../base"
import "../global"
import "../view"

Fragment{

    property var isOpen : false

    id:root
    visible: true
    x: isOpen ? parent.width - root.width : parent.width
    clip: true

    Behavior on x{
        NumberAnimation{
            duration: 300
            easing.type: Easing.InOutQuart
        }
    }

    Rectangle{
        anchors.fill: parent
        color: Theme.colorBackground2
    }

    Image {
        source: "qrc:/drawable/ic_shadow_left.png"
        anchors.left: parent.left
        width: 5
        height: parent.height
    }

    Image {
        width: 25
        height: 25
        source: "qrc:/drawable/ic_setting_back.png"
        mirror: true
        anchors{
            left: parent.left
            bottom: parent.bottom
            leftMargin: 15
            bottomMargin: 15
        }
        MouseArea{
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
               isOpen =false
            }
        }
    }

}
