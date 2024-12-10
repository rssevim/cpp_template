#include <gtest/gtest.h>

#include "calculator.hpp"

class CalculatorTest : public ::testing::Test {
protected:
  Calculator calc;
};

TEST_F(CalculatorTest, AdditionWorks) {
  EXPECT_DOUBLE_EQ(5.0, calc.add(2.0, 3.0));
  EXPECT_DOUBLE_EQ(5.0, calc.getCurrentValue());
}

TEST_F(CalculatorTest, SubtractionWorks) {
  EXPECT_DOUBLE_EQ(-1.0, calc.subtract(2.0, 3.0));
  EXPECT_DOUBLE_EQ(-1.0, calc.getCurrentValue());
}

TEST_F(CalculatorTest, MultiplicationWorks) {
  EXPECT_DOUBLE_EQ(6.0, calc.multiply(2.0, 3.0));
  EXPECT_DOUBLE_EQ(6.0, calc.getCurrentValue());
}

TEST_F(CalculatorTest, DivisionWorks) {
  EXPECT_DOUBLE_EQ(2.0, calc.divide(6.0, 3.0));
  EXPECT_DOUBLE_EQ(2.0, calc.getCurrentValue());
}

TEST_F(CalculatorTest, DivisionByZeroThrows) {
  EXPECT_THROW(calc.divide(6.0, 0.0), std::invalid_argument);
}

TEST_F(CalculatorTest, InitialConstructor) {
  Calculator default_calc;
  EXPECT_DOUBLE_EQ(0.0, default_calc.getCurrentValue());
}

TEST_F(CalculatorTest, ValueConstructor) {
  Calculator value_calc(10.0);
  EXPECT_DOUBLE_EQ(10.0, value_calc.getCurrentValue());
}

TEST_F(CalculatorTest, ResetWorks) {
  calc.add(5.0, 3.0);
  calc.reset();
  EXPECT_DOUBLE_EQ(0.0, calc.getCurrentValue());
}