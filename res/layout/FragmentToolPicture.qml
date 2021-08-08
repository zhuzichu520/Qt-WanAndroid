import QtQuick 2.9
import QtQuick.Controls 2.5
import UI.Http 1.0
import Qt.labs.settings 1.0
import UI.Controller 1.0
import UI.View 1.0
import Qt.labs.platform 1.0
import "../base"
import "../view"
import "../global"

Fragment {

    backgroundColor: Theme.colorItemBackground

    controller: PictureController{

    }

    Connections{
        target: viewHotkey
        function onHotKeyActivated(key){
            if(key==="ctrl+alt+A"){
                image.source = "screen_" + Date.now()
            }
        }
    }

    FileDialog{
        id:dialog_file
        title: "请选择图片"
        fileMode: FileDialog.OpenFile
        nameFilters: ["Image Files (*.jpg *.png *.gif *.webp)"]
        onAccepted: {
            image.source = dialog_file.file.toString().slice(8)
        }
    }

    FileDialog{
        id:dialog_save
        title: "保存图片"
        fileMode: FileDialog.SaveFile
        nameFilters: ["Image Files (*.jpg *.png *.gif *.webp)"]
        onAccepted: {
            image.saveImage(dialog_save.file.toString().slice(8))
        }
    }

    ListModel{
        id:toolModel
        ListElement{
            title:"选择图片"
            func:function(){
                dialog_file.open()
            }
        }
        ListElement{
            title:"屏幕截图\n(ctrl+alt+A)"
            func:function(){
                image.source = "screen_" + Date.now()
            }
        }
        ListElement{
            title:"显示原图"
            func:function(){
                image.restore()
            }
        }
        ListElement{
            title:"灰度化"
            func:function(){
                image.isGrey = !image.isGrey
            }
        }
    }

    ListModel{
        id:baseModel
        ListElement{
            title:"亮度值(%1)"
            from:0
            to:200
        }
        ListElement{
            title:"对比度(%1)"
            from:50
            to:300
        }
        ListElement{
            title:"二值化(%1)"
            from:0
            to:100
        }

        ListElement{
            title:"饱和值(%1)"
            from:0
            to:100
        }
    }

    Rectangle{
        id:layout_tool
        width: 130
        height: parent.height
        color: Theme.colorBackground2

        Text {
            id:tool_title
            text: "工具箱"
            font.pixelSize: 14
            anchors{
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: 15
            }
            color: Theme.colorFontPrimary
            font.bold: Font.Black
        }

        ListView{
            id:list_tool
            width: 100
            clip: true
            anchors{
                horizontalCenter: parent.horizontalCenter
                top: tool_title.bottom
                bottom: parent.bottom
                topMargin: 15
                bottomMargin: 15
            }
            model: toolModel
            spacing: 15
            delegate:  Rectangle{
                width: list_tool.width
                height: 40
                color: Theme.colorItemBackground
                border{
                    width: {
                        if(model.index == 3){
                            return  image.isGrey ? 2 : 0
                        }
                        return 0
                    }
                    color: Theme.colorPrimary
                }
                Text {
                    id:toole_item_title
                    text: model.title
                    font.pixelSize: 14
                    anchors.centerIn: parent
                    color: Theme.colorFontPrimary
                    horizontalAlignment: Text.AlignHCenter
                }
                MouseArea{
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    hoverEnabled: true
                    onEntered: {
                        parent.color = Qt.binding(function(){
                            return Theme.colorPrimary
                        })
                        toole_item_title.color = Qt.binding(function(){
                            return Theme.color_FFFFFFFF
                        })
                    }
                    onExited: {
                        parent.color = Qt.binding(function(){
                            return Theme.colorItemBackground
                        })
                        toole_item_title.color = Qt.binding(function(){
                            return Theme.colorFontPrimary
                        })
                    }
                    onClicked: {
                        model.func()
                    }
                }
            }
        }
    }


    Rectangle{
        id:layout_base
        width: 150
        height: parent.height
        color: Theme.colorBackground2
        anchors.right: parent.right

        Text {
            id:base_title
            text: "基础操作"
            font.pixelSize: 14
            anchors{
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: 15
            }
            color: Theme.colorFontPrimary
            font.bold: Font.Black
        }

        ListView{
            id:list_base
            width: 140
            clip: true
            anchors{
                horizontalCenter: parent.horizontalCenter
                top: base_title.bottom
                bottom: parent.bottom
                topMargin: 15
                bottomMargin: 15
            }
            model: baseModel
            spacing: 5
            delegate:  Rectangle{
                width: list_base.width
                height: 60
                color: Theme.colorItemBackground
                Text {
                    id:base_item_title
                    text: model.title.toString().arg(base_item_slider.value)
                    font.pixelSize: 14
                    anchors{
                        left: parent.left
                        top: parent.top
                        leftMargin: 5
                        topMargin: 5
                    }
                    color: Theme.colorFontPrimary
                }

                Slider{
                    id:base_item_slider
                    from: model.from
                    to:model.to
                    stepSize: 1
                    value: {
                        switch(model.index){
                        case 0:
                            return image.bright
                        case 1:
                            return image.contrast
                        default:
                            return model.from
                        }
                    }
                    onValueChanged: {
                        switch(model.index){
                        case 0:
                            image.bright = value
                            break
                        case 1:
                            image.contrast = value
                            break
                        }
                    }
                    anchors{
                        top:base_item_title.bottom
                        left: parent.left
                        right: parent.right
                        topMargin: 5
                    }
                }
            }
        }
    }

    Item{
        id:layout_content
        height: parent.height
        anchors{
            left: layout_tool.right
            right: layout_base.left
        }
        Rectangle{
            id:layout_image
            width: 304
            height: 304
            anchors.centerIn: parent
            border{
                width: 4
                color: Theme.colorPrimary
            }
            color: Theme.colorBackground2
        }

        PictureItem {
            id:image
            anchors.centerIn:layout_image
            width: 300
            height: 300
            MouseArea{
                anchors.fill: parent
                onClicked: {
                }
            }
        }

        CusButton{
            text: "另存为"
            anchors{
                horizontalCenter: parent.horizontalCenter
                top: image.bottom
                topMargin: 20
            }
            onClicked: {
                dialog_save.currentFile = "file:///Wan_" +new Date().getTime() +".jpg"
                dialog_save.open()
            }
        }
    }
}
