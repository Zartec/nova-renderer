# Include modules
include(CheckCCompilerFlag)
include(CheckCXXCompilerFlag)
# Include custom modules
include(CheckoutSubmodule)

# Set standards
set(CMAKE_CXX_STANDARD                  14)
set(CMAKE_C_STANDARD                    11)
set(CMAKE_POSITION_INDEPENDENT_CODE     ON)

# Set build type if not set
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE                "Debug")
endif()

set(BUILD_SHARED_LIBS                   OFF)

# Output dirs
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR})
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR})

set(CMAKE_SKIP_BUILD_RPATH            FALSE) # Add absolute path to all dependencies for BUILD
set(CMAKE_BUILD_WITH_INSTALL_RPATH    FALSE) # Use CMAKE_INSTALL_RPATH for INSTALL
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH FALSE) # Do NOT add path to dependencies for INSTALL

# Determine architecture (32/64 bit)
set(X64 OFF)
if(CMAKE_SIZEOF_VOID_P EQUAL 8)
    set(X64 ON)
endif()

# Setup system
if(WIN32)
    include(SetupWindows)
elseif(UNIX)
    include(SetupUnix)
endif()
