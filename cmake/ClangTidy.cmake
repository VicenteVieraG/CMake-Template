include_guard(GLOBAL)

function(_target_enable_clang_tidy_resolve EXECUTABLE_VAR)
    if(DEFINED TARGET_ENABLE_CLANG_TIDY_EXECUTABLE)
        set(${EXECUTABLE_VAR} "${TARGET_ENABLE_CLANG_TIDY_EXECUTABLE}" PARENT_SCOPE)
        return()
    endif()

    find_program(_target_enable_clang_tidy_executable NAMES clang-tidy NO_CACHE)
    if(NOT _target_enable_clang_tidy_executable)
        message(FATAL_ERROR
            "ENABLE_CLANG_TIDY is ON, but clang-tidy was not found. "
            "Install clang-tidy or configure with -DENABLE_CLANG_TIDY=OFF."
        )
    endif()

    set(TARGET_ENABLE_CLANG_TIDY_EXECUTABLE
        "${_target_enable_clang_tidy_executable}"
        CACHE INTERNAL "Resolved clang-tidy executable for target_enable_clang_tidy()."
    )
    set(${EXECUTABLE_VAR} "${TARGET_ENABLE_CLANG_TIDY_EXECUTABLE}" PARENT_SCOPE)
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

    _target_enable_clang_tidy_resolve(_target_enable_clang_tidy_executable)
    set_target_properties("${TARGET_NAME}" PROPERTIES
        CXX_CLANG_TIDY
        "${_target_enable_clang_tidy_executable};--checks=-clang-diagnostic-*"
    )
    message(STATUS "clang-tidy enabled for target: ${TARGET_NAME}")
endfunction()

function(enable_global_clang_tidy)
    if(NOT ENABLE_CLANG_TIDY_GLOBAL)
        return()
    endif()

    if(NOT ENABLE_CLANG_TIDY)
        message(FATAL_ERROR
            "ENABLE_CLANG_TIDY_GLOBAL requires ENABLE_CLANG_TIDY=ON. "
            "Configure with -DENABLE_CLANG_TIDY=ON -DENABLE_CLANG_TIDY_GLOBAL=ON."
        )
    endif()

    _target_enable_clang_tidy_resolve(_target_enable_clang_tidy_executable)
    set(CMAKE_C_CLANG_TIDY
        "${_target_enable_clang_tidy_executable};--checks=-clang-diagnostic-*"
        PARENT_SCOPE
    )
    set(CMAKE_CXX_CLANG_TIDY
        "${_target_enable_clang_tidy_executable};--checks=-clang-diagnostic-*"
        PARENT_SCOPE
    )
    message(STATUS "clang-tidy enabled globally for C and C++ targets.")
endfunction()
