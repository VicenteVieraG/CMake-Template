function(enable_sanitizers)
    if(NOT ENABLE_SANITIZERS)
        message(STATUS "Sanitizers disabled.")
        return()
    endif()

    set(SUPPORTED_SANITIZER_PRESETS
        default
        thread
        memory
        leak
    )

    string(TOLOWER "${SANITIZER_PRESET}" SANITIZER_PRESET_KEY)
    list(FIND SUPPORTED_SANITIZER_PRESETS "${SANITIZER_PRESET_KEY}" SANITIZER_PRESET_INDEX)
    if(SANITIZER_PRESET_INDEX EQUAL -1)
        message(FATAL_ERROR "Unknown sanitizer preset: ${SANITIZER_PRESET}. Supported presets: ${SUPPORTED_SANITIZER_PRESETS}")
    endif()

    set(MSVC_DEFAULT_SANITIZERS
        address
    )
    set(MSVC_THREAD_SANITIZERS)
    set(MSVC_MEMORY_SANITIZERS)
    set(MSVC_LEAK_SANITIZERS)

    set(CLANG_DEFAULT_SANITIZERS
        address
        undefined
    )
    set(CLANG_THREAD_SANITIZERS
        thread
    )
    set(CLANG_MEMORY_SANITIZERS
        memory
    )
    set(CLANG_LEAK_SANITIZERS
        leak
    )

    set(GCC_DEFAULT_SANITIZERS
        address
        undefined
    )
    set(GCC_THREAD_SANITIZERS
        thread
    )
    set(GCC_MEMORY_SANITIZERS)
    set(GCC_LEAK_SANITIZERS
        leak
    )

    if(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
        set(COMPILER_SANITIZER_PREFIX MSVC)
        set(SANITIZER_FLAG_PREFIX /fsanitize=)
    elseif(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
        set(COMPILER_SANITIZER_PREFIX CLANG)
        set(SANITIZER_FLAG_PREFIX -fsanitize=)
    elseif(CMAKE_CXX_COMPILER_ID MATCHES "GNU")
        set(COMPILER_SANITIZER_PREFIX GCC)
        set(SANITIZER_FLAG_PREFIX -fsanitize=)
    else()
        message(WARNING "Sanitizers are not configured for compiler: ${CMAKE_CXX_COMPILER_ID}")
        return()
    endif()

    string(TOUPPER "${SANITIZER_PRESET_KEY}" SANITIZER_PRESET_SUFFIX)
    set(SANITIZERS ${${COMPILER_SANITIZER_PREFIX}_${SANITIZER_PRESET_SUFFIX}_SANITIZERS})
    if(NOT SANITIZERS)
        message(FATAL_ERROR "Sanitizer preset '${SANITIZER_PRESET_KEY}' is not supported for compiler: ${CMAKE_CXX_COMPILER_ID}")
    endif()

    set(SANITIZER_FLAGS)
    foreach(SANITIZER IN LISTS SANITIZERS)
        list(APPEND SANITIZER_FLAGS ${SANITIZER_FLAG_PREFIX}${SANITIZER})
    endforeach()

    add_compile_options(${SANITIZER_FLAGS})
    add_link_options(${SANITIZER_FLAGS})
    message(STATUS "Sanitizers enabled with preset '${SANITIZER_PRESET_KEY}': ${SANITIZERS}")
endfunction()
