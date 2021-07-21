pragma Singleton
import QtQuick 2.9

QtObject {

    property string activity_login: "/activity/login"
    property string activity_web: "/activity/web"

    property var activities : new Map()

    property var router_table: [
        {
            path:activity_login,
            url:"qrc:/layout/ActivityLogin.qml",
            onlyOne:true
        },
        {
            path:activity_web,
            url:"qrc:/layout/ActivityWeb.qml",
            onlyOne:true
        }
    ]

    function obtRouter(path){
        for(var index in router_table){
            var item = router_table[index]
            if(item.path === path){
                return item
            }
        }
        return null
    }

    function obtActivity(path){
        for(let key in activities){
            if (key === path) {
                return activities[key]
            }
        }
        return null
    }

    function addActivity(path,activity){
        activities[path] = activity
        console.debug(activities[path])
    }
    function removeActivity(path){
        delete activities[path]
    }

}
