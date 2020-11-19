cmake_minimum_required(VERSION 3.10 FATAL_ERROR)
project(MusicLab)

get_filename_component(MLRootDir ${CMAKE_CURRENT_LIST_FILE} PATH)

include(${MLRootDir}/CompileOptions.cmake)

set(AtLeastOneManualTag FALSE)

function(ml_setup_module Tag Hint)
    set(${Tag}_PATH "${MLRootDir}/${Hint}/${Hint}.cmake" PARENT_SCOPE)
    set(${Tag}_COMPILED FALSE PARENT_SCOPE)
    if(NOT DEFINED ${Tag})
        message("${Tag} is not manually specified")
        set(${Tag} FALSE PARENT_SCOPE)
    else()
        message("${Tag} is manually specified to ${${Tag}}")
        set(AtLeastOneManualTag TRUE PARENT_SCOPE)
    endif()
endfunction()

function(ml_include_module Tag)
    if(${Tag}_COMPILED) # Already compiled
        return()
    elseif(NOT ${AtLeastOneManualTag}) ## All modules must be compiled
        set(${Tag}_COMPILED TRUE PARENT_SCOPE)
        message("-> Including module ${Tag}")
        include(${${Tag}_PATH})
    elseif(${Tag}) # If module is manually specified to be compiled
        set(${Tag}_COMPILED TRUE PARENT_SCOPE)
        message("-> Including module ${Tag}")
        foreach(Dependency ${ARGN})
            set(${Dependency} TRUE)
            ml_include_module(${Dependency})
        endforeach()
        include(${${Tag}_PATH})
    endif()
endfunction()

if(NOT DEFINED ML_TESTS)
    set(ML_TESTS FALSE)
elseif(${ML_TESTS})
    find_package(GTest REQUIRED)
    enable_testing()
endif()

if(NOT DEFINED ML_BENCHMARKS)
    set(ML_BENCHMARKS FALSE)
elseif(${ML_BENCHMARKS})
    find_package(benchmark REQUIRED)
endif()

ml_setup_module(ML_CORE MLCore)
ml_setup_module(ML_AUDIO MLAudio)
ml_setup_module(ML_STUDIO MLStudio)
ml_setup_module(ML_BOARD MLBoard)
ml_setup_module(ML_BOARD_SERVER MLBoard)
ml_setup_module(ML_PROTOCOL MLProtocol)

ml_include_module(ML_CORE)

ml_include_module(ML_PROTOCOL)

ml_include_module(ML_AUDIO
# Dependencies
    ML_CORE
)

ml_include_module(ML_BOARD
# Dependencies
    ML_CORE ML_PROTOCOL
)

ml_include_module(ML_BOARD_SERVER
# Dependencies
    ML_CORE ML_PROTOCOL
)

ml_include_module(ML_STUDIO
# Dependencies
    ML_CORE # ML_AUDIO ML_PROTOCOL
)