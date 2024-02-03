cmake_minimum_required(VERSION 3.8)

project(SLT_API_DEMO)
message(STATUS "Project name : --- ${PROJECT_NAME}")
message(STATUS "Current dir : --- ${CMAKE_CURRENT_SOURCE_DIR}")

set(CMAKE_BUILD_TYPE Release)
#-----------------------------------------------------------------------------
# 配置平台参数: X86
#
set(CROSS_PLATFORM X86)

if (NOT CROSS_PLATFORM)
    set(CROSS_PLATFORM X86)
endif ()

message(STATUS "CROSS_PLATFORM : --- ${CROSS_PLATFORM}")

#-----------------------------------------------------------------------------

set(CMAKE_BINARY_DIR ${CMAKE_SOURCE_DIR}/build)
set(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR})
set(LIBRARY_OUTPUT_PATH ${CMAKE_SOURCE_DIR}/libs/${CROSS_PLATFORM})

#aux_source_directory(fft FFT_SRCS)

include_directories(.)
#include_directories(fft)

set(BIN slt_bin)
set(TFLITE_LIB tensorflowlite_c.dll.if)
set(MAIN_SRCS main.cpp)

link_directories(${LIBRARY_OUTPUT_PATH})

add_executable(${BIN} ${MAIN_SRCS})
#target_link_libraries(${BIN} SLTBasic ${TFLITE_LIB}  stdc++ m)
target_link_libraries(${BIN} SLTBasic ${TFLITE_LIB})
