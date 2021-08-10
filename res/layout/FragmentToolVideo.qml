import QtQuick 2.9
import QtQuick.Controls 2.5
import UI.Http 1.0
import Qt.labs.settings 1.0
import UI.Controller 1.0
import UI.View 1.0
import Qt.labs.platform 1.0
import "../base"
import "../view"
import "../global"

Fragment {

    backgroundColor: Theme.colorItemBackground

    Text {
        id:toole_item_title
        text: video.info
        font.pixelSize: 14
        color: Theme.colorFontPrimary
        horizontalAlignment: Text.AlignLeft
    }

    Rectangle{
        id:layout_image
        width: video.width+4
        height: video.height+4
        anchors.centerIn: parent
        border{
            width: 4
            color: Theme.colorPrimary
        }
        color: Theme.colorBackground2
    }


    VideoItem {
        id:video
        width: 320
        height: 240
        anchors.centerIn:parent
    }

}
