#if(WIN32)
    CheckoutSubmodule(glm)

    add_subdirectory(glm EXCLUDE_FROM_ALL)
#else()
#    find_package(GLM)
#    
#    add_library(glm INTERFACE)
#
#    target_include_directories(glm
#      INTERFACE
#        ${GLM_INCLUDE_DIRS})
#endif()
