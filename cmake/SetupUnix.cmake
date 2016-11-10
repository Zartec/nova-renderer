if(X64)
    message(STATUS "Detected 64bit Unix")
else()
    message(STATUS "Detected 32bit Unix")
endif()

set(OS "Unix")

message(STATUS "Unix: Using C compiler: ${CMAKE_C_COMPILER}")
message(STATUS "Unix: Using C++ compiler: ${CMAKE_CXX_COMPILER}")

# Setup compiler
if(CMAKE_C_COMPILER MATCHES "gcc" OR CMAKE_C_COMPILER_ID STREQUAL "GNU")
  include(compiler/gcc)
elseif(CMAKE_C_COMPILER MATCHES "icc")
  include(compiler/icc)
elseif(CMAKE_C_COMPILER MATCHES "clang" OR CMAKE_C_COMPILER_ID MATCHES "Clang")
  include(compiler/clang)
endif()
