extension NumX on num {
  double remap(
    num lowerLimit,
    num higherLimit, {
    num inputLowerLimit = 0,
    num inputHigherLimit = 1,
  }) {
    assert(lowerLimit <= higherLimit);
    assert(inputLowerLimit <= inputHigherLimit);
    assert(inputLowerLimit <= this && this <= inputHigherLimit);
    final value = this - inputLowerLimit;
    final range = higherLimit - lowerLimit;
    final inputRange = inputHigherLimit - inputLowerLimit;

    return value / inputRange * range + lowerLimit;
  }
}
