cmake_minimum_required(VERSION 3.24.1)

project(MY_PROJECT VERSION 0.0.0 LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Compiler paths and executable output folder declaration
set(CMAKE_C_COMPILER C:\\mingw64\\bin\\clang)
set(CMAKE_CXX_COMPILER C:\\mingw64\\bin\\clang++)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}\\bin)

# Subdirectories
add_subdirectory(config)
add_subdirectory(external)
add_subdirectory(src)
add_subdirectory(include)
add_subdirectory(app)