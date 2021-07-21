import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.5
import QtWebView 1.0
import "../base"

Activity {
    id: activity
    width: 400
    height: 400
    title: "Web"

    property string webUrl

    onCreateView: {
        startFragment("qrc:/layout/FragmentWeb.qml",{webUrl:activity.webUrl})
    }

}
