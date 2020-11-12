cmake_minimum_required(VERSION 3.10 FATAL_ERROR)
project(MusicLab)

if(UNIX)
    add_compile_options(-fdiagnostics-color=always)
endif()

include(MusicLab.cmake)
