add_library(miniz STATIC miniz/miniz.c)

target_include_directories(glad
  PUBLIC
    miniz)

set_target_properties(miniz
  PROPERTIES
    COMPILE_FLAGS "-fno-strict-aliasing -D_LARGEFILE64_SOURCE=1 -D_FILE_OFFSET_BITS=64")

if(NOT X64)
    set_target_properties(miniz
      PROPERTIES
        COMPILE_FLAGS "-m32")
endif()
