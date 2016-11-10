CHECK_CXX_COMPILER_FLAG("-std=c++14" COMPILER_SUPPORTS_CXX14)
CHECK_CXX_COMPILER_FLAG("-std=c++1y" COMPILER_SUPPORTS_CXX1Y)

CHECK_CXX_COMPILER_FLAG("-std=c++11" COMPILER_SUPPORTS_CXX11)
CHECK_CXX_COMPILER_FLAG("-std=c++0x" COMPILER_SUPPORTS_CXX0X)

CHECK_C_COMPILER_FLAG("-std=gnu11" COMPILER_SUPPORTS_C11)

if(COMPILER_SUPPORTS_CXX14)
    message(STATUS "${OS}: Clang: Found c++14 support")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++14")
    add_definition(-DCPP_14_SUPPORT)
elseif(COMPILER_SUPPORTS_CXX1Y)
    message(STATUS "${OS}: Clang: Found c++14 support")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++1y")
    add_definition(-DCPP_14_SUPPORT)
elseif(COMPILER_SUPPORTS_CXX11)
    message(STATUS "${OS}: Clang: Found c++11 support")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
    add_definition(-DCPP_11_SUPPORT)
elseif(COMPILER_SUPPORTS_CXX0X)
    message(STATUS "${OS}: Clang: Found c++11 support")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x")
    add_definition(-DCPP_11_SUPPORT)
else()
    message(FATAL_ERROR "Clang: The compiler does not support c++14 or c++11. Please update your compiler.")
endif()

if(COMPILER_SUPPORTS_C11)
    message(STATUS "${OS}: Clang: Found c11 support")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -std=gnu11")
else()
    message(FATAL_ERROR "Clang: The compiler does not support c11. Please update your compiler.")
endif()
