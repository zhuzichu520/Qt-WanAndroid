import QtQuick 2.9
import QtQuick.Window 2.9
import QtQuick.Controls 2.9
Window {
    id: window
    visible: true
    width: 800
    height: 600
    title: qsTr("Hello, World!")
    color: "#f0f0f0"

    Timer {
        id: timer
        interval: 500
        running: true
        repeat: true
        onTriggered: label.text = Qt.formatTime(new Date(), "hh:mm:ss")
    }

    Label {
        id: label
        anchors.centerIn: parent
        font {
            pointSize: 70
            bold: true
        }
    }

}
