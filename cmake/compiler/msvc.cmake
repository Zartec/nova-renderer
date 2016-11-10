CHECK_CXX_COMPILER_FLAG("/std:c++14" COMPILER_SUPPORTS_CXX14)

CHECK_CXX_COMPILER_FLAG("-std=c++11" COMPILER_SUPPORTS_CXX11)
CHECK_CXX_COMPILER_FLAG("-std=c++0x" COMPILER_SUPPORTS_CXX0X)

CHECK_C_COMPILER_FLAG("-std=gnu11" COMPILER_SUPPORTS_C11)

if(COMPILER_SUPPORTS_CXX11)
    message(STATUS "${OS}: MSVC: Found c++14 support")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /std:c++14")
    add_definitions(-DCPP_14_SUPPORT)
elseif(COMPILER_SUPPORTS_CXX11)
    message(STATUS "${OS}: MSVC: Found c++11 support")
    add_definitions(-DCPP_11_SUPPORT)
endif()

if(X64)
    add_definitions("-D_WIN64")
    message(STATUS "${OS}: MSVC: 64-bit platform forced -D_WIN64 parameter")
else()
  add_definitions(/arch:SSE2)
  message(STATUS "${OS}: MSVC: Enabled SSE2 support")
endif()

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /MP")
