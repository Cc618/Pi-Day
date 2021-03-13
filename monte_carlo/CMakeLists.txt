cmake_minimum_required(VERSION 3.10)

project(MonteCarlo LANGUAGES CXX CUDA)

set(CMAKE_CXX_STANDARD 17)
file(GLOB SRC *.cpp *.cu)

add_executable(MonteCarlo ${SRC})
