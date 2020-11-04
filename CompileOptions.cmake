cmake_minimum_required(VERSION 3.10 FATAL_ERROR)
project(Kube)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED 17)

include_directories(${MLRootDir})

if (UNIX AND NOT APPLE)
    add_compile_options(
        -Wall
    )
endif()