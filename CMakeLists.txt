# Main CMake file

#! CMake minimum version. Make sure your current CMake version is equal or greater than this
cmake_minimum_required(VERSION 4.2.3)

# Project name, version and languages
#! Change the project name and version here
project(MY_PROJECT VERSION 0.0.0 LANGUAGES C CXX)

# Configure build options
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Create binary outputs at ./build/bin
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
# Set the module path to include custom CMake modules (.cmake files)
set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake/")

# Options
option(BUILD_TESTS "Build Catch2 unit tests." OFF)
option(BUILD_TESTS_WITH_MAIN "Build Catch2 Tests with custom main function." ON)

# Modules include
include(Docs)
if(BUILD_TESTS)
    include(CTest)
    enable_testing()
endif()

# Subdirectories
#! NOTE: The add_subdirectory order matters
add_subdirectory(config)
add_subdirectory(external)
add_subdirectory(src)
add_subdirectory(include)
add_subdirectory(app)
add_subdirectory(tests)
