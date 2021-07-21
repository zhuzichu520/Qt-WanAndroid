import QtQuick 2.9
import QtQuick.Controls 2.5
import "../view"

Page {

    property var activity
    property var controller

    signal createView
    signal destroyView
    signal resume
    signal pause

    id: fragment

    Component.onCompleted: {
        createView()
        if(controller !== undefined){
            controller.onCreateView(fragment)
        }
        initUI()
    }

    function initUI(){
        if(controller === undefined){
            return
        }
        controller.onToastEvent.connect(function(text){
            toast(text)
        })
        controller.onBackEvent.connect(function(){
            back()
        })
        controller.onStartFragmentEvent.connect(function(url){
            startFragment(url)
        })
        controller.onStartActivityEvent.connect(function(url){
            startActivity(url,false)
        })
    }

    Connections{
        target: activity
        onActiveChanged:{
            if(activity.active){
                resume()
                if(controller !== undefined){
                    controller.onResume()
                }
            }else{
                pause()
                if(controller !== undefined){
                    controller.onPause()
                }
            }
        }
    }

    Component.onDestruction: {
        try{
            destroyView()
            if(controller !== undefined){
                controller.onDestroyView()
            }
        }catch(err){

        }
    }

    function startFragment(url) {
        activity.startFragment(url)
    }

    function showLoading(){
        activity.showLoading()
    }

    function hideLoading(){
        activity.hideLoading()
    }

    function startActivity(path,isAttach=false) {
        activity.startActivity(path,isAttach)
    }

    function back() {
        activity.back()
    }

    function toast(text) {
        activity.toast(text)
    }

}
