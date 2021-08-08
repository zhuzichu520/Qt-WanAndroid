import QtQuick 2.9

// @disable-check M129
Rectangle {
    Behavior on color{
        ColorAnimation {
            duration: 300
        }
    }
}
