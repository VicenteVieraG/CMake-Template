include_guard(GLOBAL)

set(_lto_enabled_configs RELEASE RELWITHDEBINFO)

function(_lto_check_support RESULT_VAR OUTPUT_VAR)
    get_property(_lto_supported GLOBAL PROPERTY LTO_SUPPORTED)
    get_property(_lto_output GLOBAL PROPERTY LTO_SUPPORT_OUTPUT)

    if(NOT DEFINED _lto_supported)
        include(CheckIPOSupported)
        check_ipo_supported(RESULT _lto_supported OUTPUT _lto_output)

        set_property(GLOBAL PROPERTY LTO_SUPPORTED "${_lto_supported}")
        set_property(GLOBAL PROPERTY LTO_SUPPORT_OUTPUT "${_lto_output}")
    endif()

    set(${RESULT_VAR} "${_lto_supported}" PARENT_SCOPE)
    set(${OUTPUT_VAR} "${_lto_output}" PARENT_SCOPE)
endfunction()

function(_lto_enable_for_target TARGET)
    foreach(config IN LISTS _lto_enabled_configs)
        set_property(TARGET "${TARGET}" PROPERTY "INTERPROCEDURAL_OPTIMIZATION_${config}" TRUE)
    endforeach()
endfunction()

if(ENABLE_LTO_GLOBALY)
    _lto_check_support(_lto_supported _lto_output)

    if(_lto_supported)
        message(STATUS "LTO/IPO supported and enabled globally for Release and RelWithDebInfo.")
        foreach(config IN LISTS _lto_enabled_configs)
            set("CMAKE_INTERPROCEDURAL_OPTIMIZATION_${config}" TRUE)
        endforeach()
    else()
        message(WARNING "LTO/IPO requested but not supported: ${_lto_output}")
    endif()
else()
    message(STATUS "LTO/IPO is disabled globally.")
endif()

function(target_enable_lto TARGET)
    if(NOT TARGET "${TARGET}")
        message(FATAL_ERROR "target_enable_lto: '${TARGET}' is not a valid target.")
    endif()

    _lto_check_support(lto_supported lto_output)

    if(lto_supported)
        _lto_enable_for_target("${TARGET}")
    else()
        message(WARNING "LTO/IPO is not supported: ${lto_output}")
    endif()
endfunction()
