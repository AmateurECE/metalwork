cmake_minimum_required(VERSION 3.15)
project(PackageTest CXX)

find_package(stm32mp1 CONFIG REQUIRED)

add_executable(example src/example.cpp)
target_link_libraries(example
  stm32mp1::disco_bsp
  stm32mp1::c_polyfill)

add_executable(empty src/empty.cpp)
target_link_libraries(empty
  stm32mp1::c_polyfill)
