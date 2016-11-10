function(CheckoutSubmodule path)
    if(NOT GIT_FOUND)
        find_package(Git QUIET)
    endif()
    if(NOT GIT_FOUND)
        message(FATAL_ERROR "GIT-NOTFOUND")
    endif()
    execute_process(COMMAND "${GIT_EXECUTABLE}" submodule update --init -- ${path}
        WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}"
        RESULT_VARIABLE res
        OUTPUT_VARIABLE out
        ERROR_QUIET
        OUTPUT_STRIP_TRAILING_WHITESPACE)
endfunction()
