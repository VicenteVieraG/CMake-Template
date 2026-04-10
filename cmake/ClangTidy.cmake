include_guard(GLOBAL)

function(_resolve_clang_tidy_executable_path EXECUTABLE_VAR)
    if(DEFINED CLANG_TIDY_EXECUTABLE)
        set(${EXECUTABLE_VAR} "${CLANG_TIDY_EXECUTABLE}" PARENT_SCOPE)
        return()
    endif()

    find_program(CLANG_TIDY_EXECUTABLE_PATH NAMES clang-tidy NO_CACHE)
    if(NOT CLANG_TIDY_EXECUTABLE_PATH)
        message(FATAL_ERROR
            "ENABLE_CLANG_TIDY is ON, but clang-tidy was not found. "
            "Install clang-tidy or configure with -DENABLE_CLANG_TIDY=OFF."
        )
    endif()

    set(CLANG_TIDY_EXECUTABLE
        "${CLANG_TIDY_EXECUTABLE_PATH}"
        CACHE INTERNAL "Resolved clang-tidy executable path for target_enable_clang_tidy()."
    )
    set(${EXECUTABLE_VAR} "${CLANG_TIDY_EXECUTABLE}" PARENT_SCOPE)
endfunction()

function(target_enable_clang_tidy TARGET_NAME)
    if(NOT ARGC EQUAL 1)
        message(FATAL_ERROR "target_enable_clang_tidy expects exactly one target name.")
    endif()

    if(NOT TARGET "${TARGET_NAME}")
        message(FATAL_ERROR "target_enable_clang_tidy: '${TARGET_NAME}' is not a valid target.")
    endif()

    if(NOT ENABLE_CLANG_TIDY)
        return()
    endif()

    _resolve_clang_tidy_executable_path(CLANG_TIDY_EXE)
    set_target_properties("${TARGET_NAME}" PROPERTIES
        C_CLANG_TIDY
        "${CLANG_TIDY_EXE};--checks=-clang-diagnostic-*"
        CXX_CLANG_TIDY
        "${CLANG_TIDY_EXE};--checks=-clang-diagnostic-*"
    )
    message(STATUS "clang-tidy enabled for target: ${TARGET_NAME}")
endfunction()
