if(BUILD_TESTS)
    set(CATCH2_DIR "${CMAKE_CURRENT_SOURCE_DIR}/catch2")

    if(EXISTS "${CATCH2_DIR}/CMakeLists.txt")
        add_subdirectory(${CATCH2_DIR})
        add_executable(tests main.cpp)
        target_include_directories(tests PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

        if(BUILD_TESTS_WITH_MAIN)
            target_link_libraries(tests PUBLIC Catch2::Catch2WithMain)
        else()
            target_link_libraries(tests PUBLIC Catch2::Catch2)
        endif()

        include(Catch)
        catch_discover_tests(tests)
    else()
        message(FATAL_ERROR
            "Catch2 submodule not found at ${CATCH2_DIR}. "
            "Run: git submodule update --init --recursive"
        )
    endif()
endif()
