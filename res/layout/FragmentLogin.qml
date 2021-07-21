import QtQuick 2.9
import QtQuick.Controls 2.5
import UI.Controller 1.0
import UI.Http 1.0
import Qt.labs.settings 1.0
import "../base"
import "../view"
import "../global"

Fragment {

    controller:LoginController{
    }

    ApiLogin{
        id:api_login
        username: username.text
        password: password.text
    }

    Connections{
        target: api_login
        function onError(errorCode,errorMsg){
            toast(errorMsg)
        }
        function onSuccess(data){
            data.password = password.text
            AppStorage.loginInfo = data
            back()
        }
        function onFinish(){
            hideLoading()
        }
    }

    Image {
        width: 50
        height: 50
        source: "qrc:/drawable/ic_logo.png"
        anchors{
            horizontalCenter: parent.horizontalCenter
            top:parent.top
            topMargin: 50
        }
    }

    Text {
        text: qsTr("玩Android")
        color: Theme.colorFontPrimary
        font {
            pixelSize: 20
        }
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: 130
        }
    }

    TextField {
        id:username
        font {
            pixelSize: 14
        }
        anchors{
            left:parent.left
            right:parent.right
            leftMargin: 40
            rightMargin: 40
            top:parent.top
            topMargin: 190
        }
        height: 34
        maximumLength: 25
        color: Theme.colorPrimary
        selectByMouse: true
        text: "zhuzichu520@gmail.com"
        placeholderTextColor: "#999F9F9F"
        placeholderText: "请输入用户名"
        background: Rectangle {
            color: "#0D4F7DA4"
            radius: 3
        }
        wrapMode: TextEdit.Wrap
    }

    onCreateView: {
        username.forceActiveFocus()
    }

    TextField {
        id:password
        font {
            pixelSize: 14
        }
        anchors{
            left:username.left
            right:username.right
            top:username.bottom
            topMargin: 10
        }
        height: 34
        maximumLength: 15
        echoMode: TextInput.Password
        color: Theme.colorPrimary
        text: "qaioasd520"
        placeholderTextColor: "#999F9F9F"
        placeholderText: "请输入密码"
        background: Rectangle {
            color: "#0D4F7DA4"
            radius: 3
        }
        wrapMode: TextEdit.Wrap
    }

    CusButton{
        text: "登录"
        height: 36
        width: password.width
        anchors{
            top:password.bottom
            topMargin: 20
            horizontalCenter: parent.horizontalCenter
        }
        onClicked: {
            showLoading()
            api_login.execute()
        }
    }
}
