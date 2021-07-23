import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.5
import Qt.labs.platform 1.1
import "../base"

Activity {

    property string appTitle: "玩Android"

    id:root
    width: 878
    height: 595
    minimumWidth: 650
    minimumHeight: 350
    visible: true
    title: qsTr(appTitle)

    onCreateView: {
        startFragment("qrc:/layout/FragmentMain.qml")
    }

    SystemTrayIcon {
        id: systray
        tooltip: qsTr(appTitle)
        visible: true
        icon.source: "qrc:/drawable/ic_logo.png"
        menu: Menu {
            MenuItem {
                text: qsTr("退出")
                onTriggered: {
                    Qt.quit()
                }
            }
        }

        onMessageClicked: {
            root.show()
        }

        onActivated: {
            if(reason === SystemTrayIcon.Trigger) {
                root.show()
                root.raise()
                root.requestActivate()
            }
        }
    }
}
