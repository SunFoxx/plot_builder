import 'package:function_printer/model/exceptions.dart';
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

    if (latestOperatorIndex <= 0 && !isSqrtOperator) {
      try {
        operand = double.parse(baseExpression);
        print(
            'Node $operand with exp: $baseExpression; latestOperator: $latestOperatorIndex;');
      } catch (e) {
        throw InvalidSyntaxException(baseExpression);
      }
    } else {
      operator = baseExpression[latestOperatorIndex];
      print(
          'Node $operator with exp: $baseExpression; latestOperator: $latestOperatorIndex;');

      if (!isSqrtOperator) {
        String leftExpression =
            baseExpression.substring(0, latestOperatorIndex);
        print('Left node: $leftExpression');
        leftNode = ExpressionNode(leftExpression);
      }

      String rightExpression = baseExpression.substring(
        latestOperatorIndex + 1,
        this.baseExpression.length,
      );

      if (rightExpression.length == 0) {
        throw InvalidSyntaxException(baseExpression);
      }

      print('Right node: $rightExpression');
      rightNode = ExpressionNode(rightExpression);
    }
  }
}
