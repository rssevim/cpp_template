#include "calculator.hpp"

Calculator::Calculator(double initial_value) : current_value_(initial_value) {}

double Calculator::add(double a, double b) {
  current_value_ = a + b;
  return current_value_;
}

double Calculator::subtract(double a, double b) {
  current_value_ = a - b;
  return current_value_;
}

double Calculator::multiply(double a, double b) {
  current_value_ = a * b;
  return current_value_;
}

double Calculator::divide(double a, double b) {
  if (b == 0.0) {
    throw std::invalid_argument("Division by zero");
  }
  current_value_ = a / b;
  return current_value_;
}

double Calculator::getCurrentValue() const { return current_value_; }

void Calculator::reset() { current_value_ = 0.0; }