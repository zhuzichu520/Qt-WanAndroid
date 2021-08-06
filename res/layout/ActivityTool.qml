import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.5
import QtQuick.Dialogs 1.0

import "../base"

Activity {

    property var path

    id:root
    width: 695
    height: 595
    minimumWidth: 695
    minimumHeight: 350
    visible: true
    title: qsTr("玩Android")

    onCreateView: {
        startFragment(path)
    }

}
