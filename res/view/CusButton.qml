import QtQuick 2.9
import QtQuick.Controls 2.5
import "../global"
import "../view"

Button {

    id:root

    property color backgroundColor: Theme.colorPrimary
    property color backgroundPressedColor: Qt.darker(backgroundColor, 1.2)
    property color textColor: Theme.color_FFFFFFFF

    contentItem: Text {
        text: parent.text
        font.pixelSize: 12
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
        color: textColor
    }

    background: Rectangle{
        radius: 5
        color: root.down ? root.backgroundPressedColor : root.backgroundColor
    }

}

