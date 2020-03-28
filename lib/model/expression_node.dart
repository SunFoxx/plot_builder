import 'package:function_printer/utils/parse_helpers.dart';

class ExpressionNode {
  String baseExpression = '';
  double operand;
  String operator;

  ExpressionNode leftNode;
  ExpressionNode rightNode;

  ExpressionNode(String rootExpression) {
    print('---------');
    baseExpression = adjustExpression(rootExpression);
    print(baseExpression);

    int latestOperatorIndex = findLatestOperatorIndex(baseExpression);
    bool isSqrtOperator = latestOperatorIndex != -1
        ? baseExpression[latestOperatorIndex] == 's'
        : false;

    print(latestOperatorIndex);
    if (latestOperatorIndex <= 0 && !isSqrtOperator) {
      operand = double.parse(baseExpression);
      print(
          'Node with exp: $baseExpression; latestOperator: $latestOperatorIndex; operand: $operand');
    } else {
      operator = baseExpression[latestOperatorIndex];
      print(
          'Node with exp: $baseExpression; latestOperator: $latestOperatorIndex; operator: $operator');

      String leftExpression = isSqrtOperator
          ? "0"
          : baseExpression.substring(0, latestOperatorIndex);
      String rightExpression = baseExpression.substring(
        latestOperatorIndex + 1,
        this.baseExpression.length,
      );

      print('Left node: $leftExpression');
      print('Right node: $rightExpression');

      leftNode = ExpressionNode(leftExpression);
      rightNode = ExpressionNode(rightExpression);
    }
  }
}
