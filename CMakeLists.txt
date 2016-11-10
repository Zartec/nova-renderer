cmake_minimum_required(VERSION 3.0.2)
project(Nova-Renderer)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules")

include(Setup)

add_subdirectory(3rdparty)

add_subdirectory(src/main/cpp)

include(SetupGradle)
