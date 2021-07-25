import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.5
import QtQuick.Dialogs 1.0

import "../base"

Activity {

    property string appTitle: "玩Android"

    id:root
    width: 650
    height: 595
    minimumWidth: 650
    minimumHeight: 350
    visible: true
    title: qsTr(appTitle)

    onCreateView: {
        startFragment("qrc:/layout/FragmentMain.qml")
    }

}
