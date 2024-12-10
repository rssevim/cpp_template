#include <iostream>

#include "calculator.hpp"

int main() {

  std::cout << "Hello, C++ Project Template!" << std::endl;

  Calculator calculator;

  std::cout << "Calculator-> 3 + 3 = " << calculator.add(3U, 3U) << std::endl;

  return 0;
}