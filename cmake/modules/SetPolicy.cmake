function(SetPolicy POL VAL)
    if(POLICY ${POL})
        cmake_policy(SET ${POL} ${VAL})
    endif()
endfunction()
