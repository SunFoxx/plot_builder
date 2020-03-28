abstract class PostfixItem {}

class PostfixOperator implements PostfixItem {
  String operator;

  PostfixOperator(this.operator) : assert(operator.length == 1);

  @override
  String toString() => "$operator";
}

class PostfixOperand implements PostfixItem {
  double value;

  PostfixOperand(this.value);

  @override
  String toString() => "$value";
}
