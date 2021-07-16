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

    Row{
        anchors.centerIn: parent

        Text {
            id: label
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 18
            color: "#333333"
        }

    }

    states: [
        State {
            name: "PulledABit"; when: _.pulling && y < 0
            PropertyChanges {target: label; restoreEntryValues: false; text: qsTr("下拉刷新")}
        },
        State {
            name: "PulledEnough"; when: _.pulling && y > 0
        },
        State {
            name: "Refreshing"
            PropertyChanges {target: label; restoreEntryValues: false; text: qsTr("正在刷新")}
        },
        State {
            name: "Refreshed"
            PropertyChanges {target: label; restoreEntryValues: false; text: qsTr("刷新完成")}
        }
    ]

    QtObject {
        id: _
        property bool pulling
    }
}
