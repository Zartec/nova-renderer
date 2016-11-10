if(X64)
    message(STATUS "Detected 64bit Windows")
else()
    message(STATUS "Detected 32bit Windows")
endif()

set(OS "Windows")

# Set minimum system required to Windows 7
add_definitions(-D_WIN32_WINNT=0x0601)

message(STATUS "Windows: Using C compiler: ${CMAKE_C_COMPILER}")
message(STATUS "Windows: Using C++ compiler: ${CMAKE_CXX_COMPILER}")

# Setup compiler
if (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
    include(compiler/msvc)
elseif (CMAKE_CXX_PLATFORM_ID MATCHES "MinGW")
    include(compiler/mingw)
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
    include(compiler/clang)
endif()
