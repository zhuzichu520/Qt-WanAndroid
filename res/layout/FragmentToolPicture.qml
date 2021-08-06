import QtQuick 2.9
import QtQuick.Controls 2.5
import UI.Http 1.0
import Qt.labs.settings 1.0
import "../base"
import "../view"
import "../global"

Fragment {

    Image {
        id:image
        mipmap: true
        width: parent.width / 2
        height: parent.height / 2
        anchors.centerIn: parent
        fillMode: Image.PreserveAspectCrop
        source: "image://opencvProvider/ic_logo.jpg"

        Rectangle {
            anchors.fill: parent
            border.width: 2
            border.color: "#89f2f5"
            color: "transparent"
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {

            }
        }
    }

}
