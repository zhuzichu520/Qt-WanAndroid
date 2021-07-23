pragma Singleton
import QtQuick 2.9
import "../global"

QtObject{
    property string transparent: "transparent"
    property string color_FFFFFFFF: "#FFFFFFFF"
    property string color_FF4A80FD: "#FF4A80FD"

    property string colorPrimary: (AppStorage.colorPrimary === "") ?"#FF1A7DFF":AppStorage.colorPrimary

    property string colorBackground:AppStorage.isDark?"#333333":"#F7F7F7"
    property string colorBackground2:AppStorage.isDark?"#444444":"#EFEFEF"
    property string colorItemBackground:AppStorage.isDark?"#000000":"#FFFFFF"

    property string colorFontPrimary:AppStorage.isDark?"#FFFFFFFF":"#333333"
    property string colorFontSecondary :AppStorage.isDark?"#FFFFFFFF":"#666666"
    property string colorFontTertiary: AppStorage.isDark?"#FFFFFFFF":"#999999"
}
