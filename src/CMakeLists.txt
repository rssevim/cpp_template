# Add executable
add_executable(${PROJECT_NAME} 
    main.cpp
    calculator.cpp
)

# Include directories for header files
target_include_directories(${PROJECT_NAME} PRIVATE 
    ${CMAKE_SOURCE_DIR}/include
)