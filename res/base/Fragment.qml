import QtQuick 2.9
import QtQuick.Controls 2.5
import "../view"
import "../global"

Page {

    property var activity
    property var controller

    property string backgroundColor: Theme.colorBackground

    signal createView
    signal destroyView
    signal resume
    signal pause

    id: fragment
    background: Rectangle{
        color: backgroundColor
    }

    Component.onCompleted: {
        createView()
        if(controller !== undefined){
            initUI()
            controller.onCreateView(fragment)
        }
    }

    function initUI(){
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
        function onActiveChanged(){
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

    function startActivity(path,isAttach=false,options={}) {
        activity.startActivity(path,isAttach,options)
    }

    function back() {
        activity.back()
    }

    function toast(text) {
        activity.toast(text)
    }

}
