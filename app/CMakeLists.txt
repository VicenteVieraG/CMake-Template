add_executable(${CMAKE_PROJECT_NAME} main.cpp)
target_enable_clang_tidy(${CMAKE_PROJECT_NAME})
target_enable_sanitizers(${CMAKE_PROJECT_NAME})

target_include_directories(${CMAKE_PROJECT_NAME}
    PRIVATE ./
    PRIVATE ${CMAKE_BINARY_DIR}/configured_files/includes
)

target_set_warnings(
    ${CMAKE_PROJECT_NAME}
    ${ENABLE_WARNINGS_AS_ERRORS}
)
