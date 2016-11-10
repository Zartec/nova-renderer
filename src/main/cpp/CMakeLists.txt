set(COMMON_LINK_LIBS ${CMAKE_DL_LIBS} glfw ${OPENGL_LIBRARIES} glad miniz easyloggingpp json glm glfw)

include_directories(${CMAKE_CURRENT_SOURCE_DIR})

# Setup the nova-core library.
set(NOVA_SOURCE

        view/gui/gui_renderer.cpp

        view/nova_renderer.cpp
        mc_interface/nova_facade.cpp
        model/texture_manager.cpp
        model/uniform_buffer_store.cpp
        view/gui/gui_renderer.cpp

        model/gl/gl_shader_program.cpp
        model/gl/gl_uniform_buffer.cpp
        model/gl/gl_vertex_buffer.cpp
        model/texture2D.cpp

        gl/windowing/glfw_gl_window.cpp

        interfaces/ivertex_buffer.cpp

        utils/utils.cpp

        model/settings.cpp
        model/loaders/shader_loading.cpp
        model/loaders/loaders.h
        model/loaders/shader_loading.h
        model/data_model.cpp
        model/data_model.h
        model/loaders/loader_utils.cpp
        model/loaders/loader_utils.h
        )


set(NOVA_HEADERS

        view/gui/gui_renderer.h

        core/renderer/batch_builder.h
        core/renderer/model_renderer.h

        view/shaders/uniform_buffer_definitions.h

        mc_interface/nova.h
        view/nova_renderer.h
        model/texture_manager.h
        view/types.h

        model/gl/gl_shader_program.h
        model/gl/gl_uniform_buffer.h
        model/gl/gl_vertex_buffer.h
        model/texture2D.h

        gl/windowing/glfw_gl_window.h

        interfaces/igraphics_context.h
        interfaces/ivertex_buffer.h
        interfaces/iwindow.h

        mc_interface/mc_gui_objects.h
        mc_interface/mc_objects.h

        utils/utils.h
        model/settings.h
        )

# For now just put everthing in a single nova source group
# because there are several sub groups that would be extremely small
source_group("nova" FILES ${NOVA_HEADERS} ${NOVA_NO_COMPILE} ${NOVA_SOURCE})

add_library(nova-renderer SHARED ${NOVA_SOURCE})
add_library(nova-renderer-static STATIC ${NOVA_SOURCE})

target_compile_definitions(nova-renderer PRIVATE DLL_EXPORT)
target_compile_definitions(nova-renderer PUBLIC DLL_EXPORT)
target_compile_definitions(nova-renderer-static PRIVATE DLL_EXPORT)
target_compile_definitions(nova-renderer-static PUBLIC DLL_EXPORT)

if(CMAKE_SYSTEM_NAME MATCHES "Linux")
    set_target_properties(nova-renderer PROPERTIES CXX_VISIBILITY_PRESET hidden)
endif()

#set_target_properties(nova-renderer-obj PROPERTIES WINDOWS_EXPORT_ALL_SYMBOLS TRUE)

# Not sure if this is actually doing anything
if(GLFW_COMPILED)
        add_dependencies(nova-renderer glfw3)
endif()

target_link_libraries(nova-renderer ${COMMON_LINK_LIBS} glad)
target_link_libraries(nova-renderer-static ${COMMON_LINK_LIBS})

# Setup the nova-test executable
set(TEST_SOURCE_FILES
        test/main.cpp
        )

set(TEST_HEADERS
        )

source_group("test" FILES ${TEST_SOURCE_FILES} ${TEST_HEADERS})

add_executable(nova-test ${TEST_SOURCE_FILES})
add_dependencies(nova-test nova-renderer-static)
target_compile_definitions(nova-test PUBLIC STATIC_LINKAGE)
target_link_libraries(nova-test nova-renderer-static ${COMMON_LINK_LIBS})
set_target_properties(nova-test PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/test")
