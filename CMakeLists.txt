# Main CMake file

#! CMake minimum version. Make sure your current CMake version is equal or greater than this
cmake_minimum_required(VERSION 3.28.3)

# Project name, version and languages
#! Change the project name and version here
project(MY_PROJECT VERSION 0.0.0 LANGUAGES C CXX)

# Configure build options
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Configuration to set binary output and modules directory.
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake/")

# Options
option(BUILD_TESTS "Build Catch2 unit tests." OFF)
option(BUILD_TESTS_WITH_MAIN "Build Catch2 Tests with custom main function." ON)
option(ENABLE_CLANG_TIDY "Enable clang-tidy static analysis." OFF)
option(ENABLE_WARNINGS "Enable compiler warnings." ON)
option(ENABLE_WARNINGS_AS_ERRORS "Enable compiler warnings as errors." OFF)
option(ENABLE_SANITIZERS "Enable a set of sanitizers." OFF)
set(SANITIZER_PRESET "default" CACHE STRING "Sanitizer preset to enable.")
set_property(CACHE SANITIZER_PRESET PROPERTY STRINGS default thread memory leak)
option(ENABLE_LTO_GLOBALY "Enable LTO/IPO globally for Release and RelWithDebInfo targets." OFF)

# Modules include
include(Docs)
include(ClangTidy)
if(BUILD_TESTS)
    include(CTest)
    enable_testing()
endif()
include(Warnings)
if(ENABLE_SANITIZERS)
    include(Sanitizer)
    enable_sanitizers()
else()
    message(STATUS "Sanitizers disabled.")
endif()
include(LTO)

# Subdirectories
#! NOTE: The add_subdirectory order matters
add_subdirectory(config)
add_subdirectory(external)
add_subdirectory(src)
add_subdirectory(includes)
add_subdirectory(app)
add_subdirectory(tests)
