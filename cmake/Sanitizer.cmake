include_guard(GLOBAL)

set(_sanitizer_supported_presets
    default
    thread
    memory
    leak
)

function(_sanitizer_resolve_flags PRESET PRESET_KEY_VAR SANITIZERS_VAR FLAGS_VAR)
    if("${PRESET}" STREQUAL "")
        set(PRESET "${SANITIZER_PRESET}")
    endif()

    string(TOLOWER "${PRESET}" _sanitizer_preset_key)
    list(FIND _sanitizer_supported_presets "${_sanitizer_preset_key}" _sanitizer_preset_index)
    if(_sanitizer_preset_index EQUAL -1)
        message(FATAL_ERROR
            "Unknown sanitizer preset: ${PRESET}. "
            "Supported presets: ${_sanitizer_supported_presets}"
        )
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
        set(_compiler_sanitizer_prefix MSVC)
        set(_sanitizer_flag_prefix /fsanitize=)
    elseif(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
        set(_compiler_sanitizer_prefix CLANG)
        set(_sanitizer_flag_prefix -fsanitize=)
    elseif(CMAKE_CXX_COMPILER_ID MATCHES "GNU")
        set(_compiler_sanitizer_prefix GCC)
        set(_sanitizer_flag_prefix -fsanitize=)
    else()
        message(WARNING "Sanitizers are not configured for compiler: ${CMAKE_CXX_COMPILER_ID}")
        set(${PRESET_KEY_VAR} "" PARENT_SCOPE)
        set(${SANITIZERS_VAR} "" PARENT_SCOPE)
        set(${FLAGS_VAR} "" PARENT_SCOPE)
        return()
    endif()

    string(TOUPPER "${_sanitizer_preset_key}" _sanitizer_preset_suffix)
    set(_sanitizers ${${_compiler_sanitizer_prefix}_${_sanitizer_preset_suffix}_SANITIZERS})
    if(NOT _sanitizers)
        message(FATAL_ERROR
            "Sanitizer preset '${_sanitizer_preset_key}' is not supported for compiler: "
            "${CMAKE_CXX_COMPILER_ID}"
        )
    endif()

    set(_sanitizer_flags)
    foreach(_sanitizer IN LISTS _sanitizers)
        list(APPEND _sanitizer_flags ${_sanitizer_flag_prefix}${_sanitizer})
    endforeach()

    set(${PRESET_KEY_VAR} "${_sanitizer_preset_key}" PARENT_SCOPE)
    set(${SANITIZERS_VAR} "${_sanitizers}" PARENT_SCOPE)
    set(${FLAGS_VAR} "${_sanitizer_flags}" PARENT_SCOPE)
endfunction()

function(_sanitizer_target_scope TARGET_NAME SCOPE_VAR)
    get_target_property(_sanitizer_target_type "${TARGET_NAME}" TYPE)
    if(_sanitizer_target_type STREQUAL "INTERFACE_LIBRARY")
        set(${SCOPE_VAR} INTERFACE PARENT_SCOPE)
    else()
        set(${SCOPE_VAR} PRIVATE PARENT_SCOPE)
    endif()
endfunction()

function(_sanitizer_target_links TARGET_NAME RESULT_VAR)
    get_target_property(_sanitizer_target_type "${TARGET_NAME}" TYPE)
    if(_sanitizer_target_type STREQUAL "EXECUTABLE"
        OR _sanitizer_target_type STREQUAL "SHARED_LIBRARY"
        OR _sanitizer_target_type STREQUAL "MODULE_LIBRARY"
        OR _sanitizer_target_type STREQUAL "INTERFACE_LIBRARY")
        set(${RESULT_VAR} TRUE PARENT_SCOPE)
    else()
        set(${RESULT_VAR} FALSE PARENT_SCOPE)
    endif()
endfunction()

function(target_enable_sanitizers TARGET_NAME)
    if(NOT (ARGC EQUAL 1 OR ARGC EQUAL 2))
        message(FATAL_ERROR
            "target_enable_sanitizers expects a target name and an optional preset name."
        )
    endif()

    if(NOT TARGET "${TARGET_NAME}")
        message(FATAL_ERROR "target_enable_sanitizers: '${TARGET_NAME}' is not a valid target.")
    endif()

    if(NOT ENABLE_SANITIZERS)
        return()
    endif()

    set(_requested_preset "")
    if(ARGC EQUAL 2)
        set(_requested_preset "${ARGV1}")
    endif()

    _sanitizer_resolve_flags("${_requested_preset}" _preset_key _sanitizers _sanitizer_flags)
    if(NOT _sanitizer_flags)
        return()
    endif()

    _sanitizer_target_scope("${TARGET_NAME}" _sanitizer_scope)
    target_compile_options("${TARGET_NAME}" ${_sanitizer_scope} ${_sanitizer_flags})

    _sanitizer_target_links("${TARGET_NAME}" _target_links)
    if(_target_links)
        target_link_options("${TARGET_NAME}" ${_sanitizer_scope} ${_sanitizer_flags})
        set(_sanitizer_application "compile and link")
    else()
        set(_sanitizer_application "compile only")
    endif()

    message(
        STATUS
        "Sanitizers enabled for target '${TARGET_NAME}' (${_sanitizer_application}) "
        "with preset '${_preset_key}': ${_sanitizers}"
    )
endfunction()
