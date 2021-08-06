cmake_minimum_required(VERSION 3.5)

project(WanAndroid LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

if (NOT DEFINED CMAKE_DEBUG_POSTFIX)
    if (WIN32)
        set(CMAKE_DEBUG_POSTFIX d)
    else ()
        set(CMAKE_DEBUG_POSTFIX _debug)
    endif ()
endif ()

if (NOT DEFINED CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif ()

if (NOT (CMAKE_BUILD_TYPE STREQUAL "Debug"))
    set(CMAKE_INTERPROCEDURAL_OPTIMIZATION ON)
endif ()

if (NOT DEFINED CMAKE_RUNTIME_OUTPUT_DIRECTORY)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin)
endif ()

find_package(QT NAMES Qt6 Qt5 COMPONENTS Quick QuickControls2 WebEngine REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Quick QuickControls2 WebEngine REQUIRED)

set(SRC_PACKAGE application base login http utils tools)
set(SOURCES main.cpp)
set(QRC_SOURCE ./res/qml.qrc)

FOREACH (item ${SRC_PACKAGE})
file(GLOB SRC_FILE "./src/${item}/*.cpp" "./src/${item}/*.h")
list(APPEND SOURCES ${SRC_FILE})
ENDFOREACH (item)

if (WIN32)
    #win32
    include_directories(./third_party/glog/include/win32)
    include_directories(./third_party/opencv/include/win32)
    enable_language(RC)
    list(APPEND SOURCES ./windows.rc ./windows.manifest)
else ()
    include_directories(./third_party/glog/include/mac)
endif ()

add_executable(${PROJECT_NAME} WIN32 ${QRC_SOURCE} ${SOURCES})

target_link_libraries(${PROJECT_NAME} PRIVATE
    Qt${QT_VERSION_MAJOR}::Quick
    Qt${QT_VERSION_MAJOR}::QuickControls2
    Qt${QT_VERSION_MAJOR}::WebEngine
    )

if (WIN32)
    #win32
    if (NOT (CMAKE_BUILD_TYPE STREQUAL "Debug"))
        target_link_libraries(${PROJECT_NAME} PRIVATE
            ${CMAKE_CURRENT_SOURCE_DIR}/third_party/glog/libs/win32/Release/glog.lib
            )
        set(OPENCV_LIB_PATH ${CMAKE_CURRENT_SOURCE_DIR}/third_party/opencv/libs/win32/Release/)
        target_link_libraries(${PROJECT_NAME} PRIVATE
                ${OPENCV_LIB_PATH}/opencv_calib3d453.lib
                ${OPENCV_LIB_PATH}/opencv_core453.lib
                ${OPENCV_LIB_PATH}/opencv_dnn453.lib
                ${OPENCV_LIB_PATH}/opencv_features2d453.lib
                ${OPENCV_LIB_PATH}/opencv_flann453.lib
                ${OPENCV_LIB_PATH}/opencv_gapi453.lib
                ${OPENCV_LIB_PATH}/opencv_highgui453.lib
                ${OPENCV_LIB_PATH}/opencv_imgcodecs453.lib
                ${OPENCV_LIB_PATH}/opencv_imgproc453.lib
                ${OPENCV_LIB_PATH}/opencv_ml453.lib
                ${OPENCV_LIB_PATH}/opencv_objdetect453.lib
                ${OPENCV_LIB_PATH}/opencv_photo453.lib
                ${OPENCV_LIB_PATH}/opencv_stitching453.lib
                ${OPENCV_LIB_PATH}/opencv_video453.lib
                ${OPENCV_LIB_PATH}/opencv_videoio453.lib
                )
    else()
        target_link_libraries(${PROJECT_NAME} PRIVATE
            ${CMAKE_CURRENT_SOURCE_DIR}/third_party/glog/libs/win32/Debug/glogd.lib
            )
        set(OPENCV_LIB_PATH ${CMAKE_CURRENT_SOURCE_DIR}/third_party/opencv/libs/win32/Debug/)
        target_link_libraries(${PROJECT_NAME} PRIVATE
                ${OPENCV_LIB_PATH}/opencv_calib3d453d.lib
                ${OPENCV_LIB_PATH}/opencv_core453d.lib
                ${OPENCV_LIB_PATH}/opencv_dnn453d.lib
                ${OPENCV_LIB_PATH}/opencv_features2d453d.lib
                ${OPENCV_LIB_PATH}/opencv_flann453d.lib
                ${OPENCV_LIB_PATH}/opencv_gapi453d.lib
                ${OPENCV_LIB_PATH}/opencv_highgui453d.lib
                ${OPENCV_LIB_PATH}/opencv_imgcodecs453d.lib
                ${OPENCV_LIB_PATH}/opencv_imgproc453d.lib
                ${OPENCV_LIB_PATH}/opencv_ml453d.lib
                ${OPENCV_LIB_PATH}/opencv_objdetect453d.lib
                ${OPENCV_LIB_PATH}/opencv_photo453d.lib
                ${OPENCV_LIB_PATH}/opencv_stitching453d.lib
                ${OPENCV_LIB_PATH}/opencv_video453d.lib
                ${OPENCV_LIB_PATH}/opencv_videoio453d.lib
                )
    endif()

    target_compile_definitions(${PROJECT_NAME} PRIVATE
        GLOG_NO_ABBREVIATED_SEVERITIES
        GOOGLE_GLOG_DLL_DECL=
        )
else ()
    target_link_libraries(${PROJECT_NAME} PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/third_party/glog/libs/mac/libglog.a
        )
    target_compile_definitions(${PROJECT_NAME} PRIVATE
        GLOG_NO_ABBREVIATED_SEVERITIES
        )
endif ()

target_compile_definitions(${PROJECT_NAME} PRIVATE
    QT_NO_KEYWORDS
    QT_DEPRECATED_WARNINGS
    QT_DISABLE_DEPRECATED_BEFORE=0x060100
    )

if (MSVC)
    target_compile_options(${PROJECT_NAME} PRIVATE /utf-8)
    if (NOT (CMAKE_BUILD_TYPE STREQUAL "Debug"))
        target_compile_options(${PROJECT_NAME} PRIVATE /guard:cf)
        target_link_options(${PROJECT_NAME} PRIVATE /GUARD:CF)
    endif ()
endif ()

if (WIN32)
    target_link_libraries(${PROJECT_NAME} PRIVATE user32 shell32 gdi32 dwmapi)
endif ()
