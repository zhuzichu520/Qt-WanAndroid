import QtQuick 2.0

Item {
    id: root
    width: listView.width
    height: 50
    y: -height - listView.contentY

    readonly property bool refreshing: state == "Refreshing"
    property var listView: parent
    signal refresh()
    function endRefresh() {
        state = "Refreshed"
        listView.interactive = true
        listView.contentY = -height
        timer.start()
    }

    Timer {
        id: timer
        interval: 500
        onTriggered: {
            listView.topMargin = 0
            listView.contentY = -height
            listView.flick(0, 1)
        }
    }

    Connections {
        target: listView
        onDragStarted: {
            if (state != "Refreshing") {
                _.pulling = true
            }
        }
        onDragEnded: {
            if (listView.contentY < 0) {
                if (state == "PulledEnough") {
                    state = "Refreshing"
                    listView.topMargin = height
                    listView.interactive = false
                    _.pulling = false
                    refresh()
                }
            }
        }
    }

    Text {
        id: label
        anchors.centerIn: parent
    }

    states: [
        State {
            name: "PulledABit"; when: _.pulling && y < 0
            PropertyChanges {target: label; restoreEntryValues: false; text: qsTr("Pull to refresh")}
        },
        State {
            name: "PulledEnough"; when: _.pulling && y >= 0
            PropertyChanges {target: label; restoreEntryValues: false; text: qsTr("Release to refresh")}
        },
        State {
            name: "Refreshing"
            PropertyChanges {target: label; restoreEntryValues: false; text: qsTr("Refreshing")}
        },
        State {
            name: "Refreshed"
            PropertyChanges {target: label; restoreEntryValues: false; text: qsTr("Refreshed")}
        }
    ]

    QtObject {
        id: _
        property bool pulling
    }
}
