#if(WIN32)
    CheckoutSubmodule(glfw)

    add_subdirectory(glfw EXCLUDE_FROM_ALL)
#else()
#    find_package(GLFW REQUIRED)
#    
#    add_library(glfw INTERFACE)
#    
#    target_link_libraries(glfw
#      INTERFACE
#        ${GLFW_LIBRARIES})
#
#    target_include_directories(glfw
#      INTERFACE
#        ${GLFW_INCLUDE_DIR})
#endif()
