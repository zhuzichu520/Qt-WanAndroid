import QtQuick 2.9
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0
import QtWebEngine 1.10
import "../base"
import "../global"

Fragment{

    id:root

    property string webUrl

    WebEngineView {
        id:currentWebView
        anchors.fill: parent
        url:webUrl
        onLoadProgressChanged: {
            console.debug(loadProgress)
        }
    }

    ProgressBar {
        id: progressBar
        height: 3
        anchors {
            left: parent.left
            top: parent.top
            right: parent.right
        }
        style: ProgressBarStyle {
            background: Item {}
        }
        minimumValue: 0
        maximumValue: 100
        value: (currentWebView && currentWebView.loadProgress < 100) ? currentWebView.loadProgress : 0
    }

}
