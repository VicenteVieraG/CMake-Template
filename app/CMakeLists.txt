add_executable(${CMAKE_PROJECT_NAME} main.cpp)

target_include_directories(${CMAKE_PROJECT_NAME}
    PRIVATE ./
    PRIVATE ${CMAKE_BINARY_DIR}/configured_files/include
)

if(ENABLE_WARNINGS)
    target_set_warnings(
        ${CMAKE_PROJECT_NAME}
        ${ENABLE_WARNINGS}
        ${ENABLE_WARNINGS_AS_ERRORS}
    )
endif()
