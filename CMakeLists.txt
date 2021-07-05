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

find_package(QT NAMES Qt6 Qt5 COMPONENTS Quick QuickControls2 REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Quick QuickControls2 REQUIRED)

set(SRC_PACKAGE application base home login tool http utils)
set(SOURCES ./res/qml.qrc main.cpp)

FOREACH (item ${SRC_PACKAGE})
    file(GLOB SRC_FILE "./src/${item}/*.cpp" "./src/${item}/*.h")
    list(APPEND SOURCES ${SRC_FILE})
ENDFOREACH (item)

if (WIN32)
    #win32
    include_directories(./third_party/glog/include/win32)
    enable_language(RC)
    list(APPEND SOURCES ./windows.rc ./windows.manifest)
else ()
    if(MACOS)
        #mac
        include_directories(./third_party/glog/include/mac)
    else()
        #linux
    endif()
endif ()

add_executable(${PROJECT_NAME} WIN32 ${SOURCES})

target_link_libraries(${PROJECT_NAME} PRIVATE
        Qt${QT_VERSION_MAJOR}::Quick
        Qt${QT_VERSION_MAJOR}::QuickControls2
        )

if (WIN32)
    #win32
    target_link_libraries(${PROJECT_NAME} PRIVATE
            ${CMAKE_CURRENT_SOURCE_DIR}/third_party/glog/libs/win32/Debug/glogd.lib
            )
else ()
    if(MACOS)
        #mac
        target_link_libraries(${PROJECT_NAME} PRIVATE
                ${CMAKE_CURRENT_SOURCE_DIR}/third_party/glog/libs/mac/libglog.a
                )
    else()
        #linux
    endif()
endif ()

target_compile_definitions(${PROJECT_NAME} PRIVATE
        QT_NO_KEYWORDS
        QT_DEPRECATED_WARNINGS
        QT_DISABLE_DEPRECATED_BEFORE=0x060100
        GLOG_NO_ABBREVIATED_SEVERITIES
        GOOGLE_GLOG_DLL_DECL=
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
