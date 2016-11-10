set(GRADLE_PROJECT_DIR "${CMAKE_CURRENT_SOURCE_DIR}/projects/Nova")
set(GRADLE_RESOURCES_DIR "${CMAKE_CURRENT_BINARY_DIR}/resources")
set(GRADLE_NATIVES_DIR "${GRADLE_RESOURCES_DIR}/com/continuum/nova")
set(GRADLE_DIST_DIR "${CMAKE_CURRENT_BINARY_DIR}/distributions")
set(GRADLE_PATCHES_DIR "${CMAKE_CURRENT_SOURCE_DIR}/src/main/patches/minecraft")

if(WIN32)
    set(GRADLE_COMMAND "${CMAKE_CURRENT_SOURCE_DIR}/gradlew.bat")
    set(GRADLE_NATIVES_DIR "${GRADLE_NATIVES_DIR}/win32-x86")
    set(GRADLE_NATIVE_LIB_IN "${CMAKE_CURRENT_BINARY_DIR}/libnova-renderer.dll")
    set(GRADLE_NATIVE_LIB_OUT "${GRADLE_NATIVES_DIR}/libnova-renderer.dll")
else()
    set(GRADLE_COMMAND "${CMAKE_CURRENT_SOURCE_DIR}/gradlew")
    if(X64)
        set(GRADLE_NATIVES_DIR "${GRADLE_NATIVES_DIR}/linux-x86-64")
    else()
        set(GRADLE_NATIVES_DIR "${GRADLE_NATIVES_DIR}/linux-x86")
    endif()
    set(GRADLE_NATIVE_LIB_IN "${CMAKE_CURRENT_BINARY_DIR}/libnova-renderer.so")
    set(GRADLE_NATIVE_LIB_OUT "${GRADLE_NATIVES_DIR}/libnova-renderer.so")
endif()

# Create natives dir
file(COPY "${CMAKE_CURRENT_SOURCE_DIR}/src/main/resources/" DESTINATION "${GRADLE_RESOURCES_DIR}/")
file(MAKE_DIRECTORY ${GRADLE_NATIVES_DIR})

add_custom_command(OUTPUT "${GRADLE_NATIVE_LIB_OUT}"
                   DEPENDS nova-renderer
                   COMMAND ${CMAKE_COMMAND} -E copy "${GRADLE_NATIVE_LIB_IN}" "${GRADLE_NATIVE_LIB_OUT}")

# ForgeGradle setup
add_custom_command(OUTPUT "${GRADLE_PROJECT_DIR}"
                   COMMAND ${GRADLE_COMMAND} ARGS -PbuildDir=${CMAKE_CURRENT_BINARY_DIR} -PresourcesDir=${GRADLE_RESOURCES_DIR} setup
                   WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}")

add_custom_target(gradle-setup ALL DEPENDS "${GRADLE_PROJECT_DIR}")

# ForgeGradle build
add_custom_command(OUTPUT "${GRADLE_DIST_DIR}"
                   DEPENDS gradle-setup "${GRADLE_NATIVE_LIB_OUT}" "${GRADLE_RESOURCES_DIR}"
                   COMMAND ${GRADLE_COMMAND} ARGS -PbuildDir=${CMAKE_CURRENT_BINARY_DIR} -PresourcesDir=${GRADLE_RESOURCES_DIR} build
                   WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}")

add_custom_target(gradle-build ALL DEPENDS "${GRADLE_DIST_DIR}")

# ForgeGradle generate patches
add_custom_command(OUTPUT "${GRADLE_PATCHES_DIR}"
                   DEPENDS gradle-setup
                   COMMAND ${GRADLE_COMMAND} ARGS -PbuildDir=${CMAKE_CURRENT_BINARY_DIR} -PresourcesDir=${GRADLE_RESOURCES_DIR} genPatches
                   WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}")

add_custom_target(gradle-gen-patches DEPENDS "${GRADLE_PATCHES_DIR}")
