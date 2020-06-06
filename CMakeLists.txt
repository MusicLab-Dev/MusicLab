cmake_minimum_required(VERSION 3.10 FATAL_ERROR)
project(MusicLab)

get_filename_component(MLRootDir ${CMAKE_CURRENT_LIST_FILE} PATH)

if (NOT DEFINED ML_TESTS)
set(ML_TESTS FALSE)
elseif (${ML_TESTS})
    find_package(GTest REQUIRED)
    enable_testing()
endif ()

if (NOT DEFINED ML_BENCHMARKS)
    set(ML_BENCHMARKS FALSE)
elseif (${ML_BENCHMARKS})
    find_package(benchmark REQUIRED)
endif ()

if (NOT DEFINED ML_CORE)
    set(ML_CORE FALSE)
endif ()

if (NOT DEFINED ML_AUDIO)
    set(ML_AUDIO FALSE)
endif ()

if (NOT DEFINED ML_PROTOCOL)
    set(ML_PROTOCOL FALSE)
endif ()

if (NOT DEFINED ML_STUDIO)
    set(ML_STUDIO FALSE)
endif ()

if (NOT DEFINED ML_BOARD)
    set(ML_BOARD FALSE)
endif ()

if (NOT DEFINED ML_MODULES)
    set(ML_MODULES FALSE)
endif ()

if (NOT ${ML_AUDIO} AND NOT ${ML_BOARD} AND NOT ${ML_STUDIO} AND NOT ${ML_MODULES})
    set(ML_ALL TRUE)
else ()
    set(ML_ALL FALSE)
endif ()

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED 17)

if (${ML_ALL} OR ${ML_CORE})
    include(${MLRootDir}/MLCore/MLCore.cmake)
endif ()

if (${ML_ALL} OR ${ML_AUDIO})
    include(${MLRootDir}/MLAudio/MLAudio.cmake)
endif ()

if (${ML_ALL} OR ${ML_PROTOCOL})
    include(${MLRootDir}/MLProtocol/MLProtocol.cmake)
endif ()

if (${ML_ALL} OR ${ML_STUDIO})
    include(${MLRootDir}/MLStudio/MLStudio.cmake)
endif ()

if (${ML_ALL} OR ${ML_BOARD})
    include(${MLRootDir}/MLBoard/MLBoard.cmake)
endif ()
