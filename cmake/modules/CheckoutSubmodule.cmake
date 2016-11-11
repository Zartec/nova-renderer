macro(CheckoutSubmodule path)
    if(NOT GIT_FOUND)
        find_package(Git QUIET)
    endif()
    if(NOT GIT_FOUND)
        message(FATAL_ERROR "GIT-NOTFOUND")
    endif()
    execute_process(COMMAND "${GIT_EXECUTABLE}" submodule update --init -f -- "${path}"
        WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
        RESULT_VARIABLE res
        OUTPUT_VARIABLE out
        ERROR_QUIET
        OUTPUT_STRIP_TRAILING_WHITESPACE)
    if(NOT res EQUAL 0)
        message(FATAL_ERROR "Submodule checkout failed ${out} (${res})")
    endif()
endmacro()
