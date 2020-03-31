class InvalidSyntaxException implements Exception {
  String brokenPart;
  InvalidSyntaxException(this.brokenPart);

  @override
  String toString() => 'Invalid expression syntax: check \'$brokenPart\'';
}

class NegativeNumberSqrtException implements Exception {
  double xValue;
  NegativeNumberSqrtException(this.xValue);

  @override
  String toString() =>
      'Selected range involves taking the square root of a negative number {$xValue}';
}

class DivisionByZeroException implements Exception {
  @override
  String toString() => 'Selected range involves division by zero';
}

class InvalidRangeException implements Exception {
  @override
  String toString() => 'Given range must be in ascending order';
}
