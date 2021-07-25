import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import "../base"
import "../global"

Fragment{

    id:root

    Text {
        anchors.centerIn: parent
        text: qsTr("工具页面")
        MouseArea{
            anchors.fill: parent
            onClicked: {
                back()
            }
        }
    }

}
