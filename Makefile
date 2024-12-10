# Project Configuration
PROJECT_NAME = my_cpp_project
BUILD_DIR = build
CMAKE = cmake
CTEST = ctest

# Compiler and Tools
CXX = g++
CLANG_FORMAT = clang-format
CLANG_TIDY = clang-tidy
VALGRIND = valgrind
GCOV = gcov
LCOV = lcov
GENHTML = genhtml

# Compiler Flags
COVERAGE_FLAGS = -fprofile-arcs -ftest-coverage

# Phony targets to avoid conflicts with file names
.PHONY: all build clean run test format tidy valgrind coverage help

# Default target
all: help

# Create build directory and generate CMake files
configure:
	@mkdir -p $(BUILD_DIR)
	@cd $(BUILD_DIR) && $(CMAKE) -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_BUILD_TYPE=Debug ..

# Build the project in debug mode with coverage
build: configure
	@$(CMAKE) --build $(BUILD_DIR) --parallel

# Clean build artifacts
clean:
	@rm -rf $(BUILD_DIR)
	@find . -name "*.gcda" -delete
	@find . -name "*.gcno" -delete
	@find . -name "*.gcov" -delete
	@rm -rf coverage
	@rm -rf valgrind-logs

# Run the executable
run: build
	@./$(BUILD_DIR)/src/$(PROJECT_NAME)

# Run tests
test: build
	@cd $(BUILD_DIR) && $(CTEST) --output-on-failure

# Run tests with Valgrind for memory checking
valgrind: build
	@mkdir -p valgrind-logs
	@$(VALGRIND) --leak-check=full \
		--show-leak-kinds=all \
		--track-origins=yes \
		--verbose \
		--log-file=valgrind-logs/memcheck.log \
		$(BUILD_DIR)/tests/$(PROJECT_NAME)_tests
	@echo "Valgrind memory check complete. Check valgrind-logs/memcheck.log for details."

# Generate code coverage report
coverage: build
	@mkdir -p coverage
	@cd $(BUILD_DIR) && $(CTEST) --output-on-failure
	@$(LCOV) --directory . --capture --output-file coverage/coverage.info
	@$(LCOV) --remove coverage/coverage.info \
		'/usr/include/*' \
		'/usr/local/include/*' \
		'tests/*' \
		--output-file coverage/coverage_filtered.info
	@$(GENHTML) coverage/coverage_filtered.info \
		--output-directory coverage/report
	@echo "Coverage report generated in coverage/report/index.html"

# Format source files using clang-format
format:
	@find src include tests \( -name "*.cpp" -o -name "*.hpp" \) | xargs $(CLANG_FORMAT) -i

# Run clang-tidy on source files
tidy: build
	@if [ -d src ]; then \
		$(CLANG_TIDY) -p $(BUILD_DIR) $(wildcard src/*.cpp); \
	fi
	@if [ -d tests ]; then \
		$(CLANG_TIDY) -p $(BUILD_DIR) $(wildcard tests/*.cpp); \
	fi
	@if [ -d include ]; then \
		for file in $(wildcard include/*.hpp); do \
			if [ -f "$$file" ]; then \
				$(CLANG_TIDY) -p $(BUILD_DIR) "$$file"; \
			fi \
		done \
	fi

# Help target to display available commands
help:
	@echo "Available targets:"
	@echo "  configure - Generate CMake build files"
	@echo "  build     - Compile the project"
	@echo "  clean     - Remove build artifacts"
	@echo "  run       - Build and run the executable"
	@echo "  test      - Run unit tests"
	@echo "  valgrind  - Run memory check with Valgrind"
	@echo "  coverage  - Generate code coverage report"
	@echo "  format    - Format source files with clang-format"
	@echo "  tidy      - Run clang-tidy static analysis"