# Fetch Google Test
include(FetchContent)
FetchContent_Declare(
  googletest
  GIT_REPOSITORY https://github.com/google/googletest.git
  GIT_TAG v1.13.0
)
FetchContent_MakeAvailable(googletest)

# Add test executable
add_executable(${PROJECT_NAME}_tests
    test_main.cpp
    test_calculator.cpp
    ${CMAKE_SOURCE_DIR}/src/calculator.cpp
)

# Include directories for header files
target_include_directories(${PROJECT_NAME}_tests PRIVATE 
    ${CMAKE_SOURCE_DIR}/include
)

# Link Google Test
target_link_libraries(${PROJECT_NAME}_tests 
    GTest::gtest_main
)

# Discover and add tests
include(GoogleTest)
gtest_discover_tests(${PROJECT_NAME}_tests)