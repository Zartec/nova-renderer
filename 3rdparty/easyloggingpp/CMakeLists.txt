CheckoutSubmodule(easyloggingpp)

add_library(easyloggingpp INTERFACE)

target_include_directories(easyloggingpp
  INTERFACE
    easyloggingpp/src)
