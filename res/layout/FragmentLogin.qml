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
    }

    TextField {
        id:username
        font {
            pixelSize: 14
        }
        anchors{
            left:parent.left
            right:parent.right
            leftMargin: 20
            rightMargin: 20
            top:parent.top
            topMargin: 80
        }
        height: 34
        focus: true
        maximumLength: 25
        color: "#FFFF7A00"
        selectByMouse: true
        placeholderTextColor: "#999F9F9F"
        placeholderText: "请输入用户名"
        background: Rectangle {
            color: "#0D4F7DA4"
            radius: 3
        }
        wrapMode: TextEdit.Wrap
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
        focus: true
        maximumLength: 15
        echoMode: TextInput.Password
        color: "#FFFF7A00"
        placeholderTextColor: "#999F9F9F"
        placeholderText: "请输入密码"
        background: Rectangle {
            color: "#0D4F7DA4"
            radius: 3
        }
        wrapMode: TextEdit.Wrap
    }

    Button{
        text: "登录"
        height: 36
        width: password.width
        anchors{
            top:password.bottom
            topMargin: 20
            horizontalCenter: parent.horizontalCenter
        }
        onClicked: {
            api_login.execute()
        }
    }

}
