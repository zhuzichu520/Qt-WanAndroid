import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Templates 2.5 as T
import "../global"

// @disable-check M129
T.Slider{
    id: control

    property bool acceptWheel: true
    property color handleBorderColor: "black"
    property color handleNormalColor: Theme.colorPrimary
    property color handleHoverColor: Qt.lighter(handleNormalColor)
    property color handlePressColor: Qt.darker(handleNormalColor)
    property color completeColor: Theme.colorPrimary
    property color incompleteColor: Qt.lighter(completeColor,1.6)
    implicitWidth: horizontal? 200: 24;
    implicitHeight: horizontal? 24: 200;
    padding: horizontal? height/4: width/4;
    handle: Rectangle {
        x: control.leftPadding + (control.horizontal ? control.visualPosition * (control.availableWidth - width) : (control.availableWidth - width) / 2)
        y: control.topPadding + (control.horizontal ? (control.availableHeight - height) / 2 : control.visualPosition * (control.availableHeight - height))
        width: control.horizontal?(control.height/2):(control.width)
        height: control.horizontal?(control.height):(control.width/2)
        color: control.pressed
               ?handlePressColor
               :control.hovered
                 ?handleHoverColor
                 :handleNormalColor
        border.width: 1
        border.color: handleBorderColor
    }
    background: Rectangle {
        x: control.leftPadding + (control.horizontal ? 0 : (control.availableWidth - width) / 2)
        y: control.topPadding + (control.horizontal ? (control.availableHeight - height) / 2 : 0)
        implicitWidth: control.horizontal ? 200 : 6
        implicitHeight: control.horizontal ? 6 : 200
        width: control.horizontal ? control.availableWidth : implicitWidth
        height: control.horizontal ? implicitHeight : control.availableHeight
        radius: 3
        color: control.incompleteColor
        scale: control.horizontal && control.mirrored ? -1 : 1
        Rectangle {
            y: control.horizontal ? 0 : control.visualPosition * parent.height
            width: control.horizontal ? control.position * parent.width : parent.width
            height: control.horizontal ? parent.height : control.position * parent.height
            radius: 3
            color: control.completeColor
        }
    }
    MouseArea{
        anchors.fill: parent
        acceptedButtons: Qt.NoButton
        onWheel: {
            if(wheel.angleDelta.y<0){
                control.decrease();
            }else{
                control.increase();
            }
        }
    }
}
