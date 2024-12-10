#pragma once

#include <stdexcept>

class Calculator {
public:
  // Constructors
  Calculator() = default;
  explicit Calculator(double initial_value);

  // Arithmetic operations
  double add(double a, double b);
  double subtract(double a, double b);
  double multiply(double a, double b);

  // Division with error handling
  double divide(double a, double b);

  // Getter for current value
  [[nodiscard]] double getCurrentValue() const;

  // Reset calculator
  void reset();

private:
  double current_value_ = 0.0;
};