import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Window 2.3
import "../view"
import "../global"

ApplicationWindow {

    property var router

    signal createView
    signal destroyView

    id:root

    onClosing: function(closeevent){
        try{
            root.destroy()
            closeevent.accepted = false
        }catch(err){

        }
    }

    Component.onCompleted: {
        createView()
        if(router !== undefined){
            Router.addActivity(router.path,root)
        }
    }

    Component.onDestruction: {
        destroyView()
        if(router !== undefined){
            Router.removeActivity(router.path)
        }
    }

    StackView {
        id:container
        width: parent.width
        anchors{
            fill:parent
        }
    }

    function startFragment(url){
        container.push(Qt.resolvedUrl(url),{activity:root})
    }

    function startActivity(path,isAttach,options={}){
        var data = Router.obtRouter(path)
        if(data === null){
            console.error("没有注册当前路由："+path)
            return
        }
        var comp = Qt.createComponent(data.url)
        if (comp.status !== Component.Ready){
            console.error("组件创建错误："+path)
            return
        }
        var activity = Router.obtActivity(data.path)
        if(activity !== null && data.onlyOne){
            activity.show()
            activity.raise()
            activity.requestActivate()
            return
        }
        options.router = data
        var object= comp.createObject(isAttach?root:null,options)
        object.show()
    }

    function back(){
        if(container.depth>1){
            container.pop()
            return
        }
        root.close()
    }

}
