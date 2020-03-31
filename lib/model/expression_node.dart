import 'package:function_printer/model/exceptions.dart';
import 'package:function_printer/utils/parse_helpers.dart';

class ExpressionNode {
  String baseExpression = '';
  double operand;
  String operator;

  ExpressionNode leftNode;
  ExpressionNode rightNode;

  ExpressionNode(String rootExpression) {
    baseExpression = adjustExpression(rootExpression);
    int latestOperatorIndex = findLatestOperatorIndex(baseExpression);
    bool isSqrtOperator = latestOperatorIndex != -1
        ? baseExpression[latestOperatorIndex] == 's'
        : false;

    if (latestOperatorIndex <= 0 && !isSqrtOperator) {
      try {
        operand = double.parse(baseExpression);
      } catch (e) {
        throw InvalidSyntaxException(baseExpression);
      }
    } else {
      operator = baseExpression[latestOperatorIndex];

      if (!isSqrtOperator) {
        String leftExpression =
            baseExpression.substring(0, latestOperatorIndex);
        leftNode = ExpressionNode(leftExpression);
      }

      String rightExpression = baseExpression.substring(
        latestOperatorIndex + 1,
        this.baseExpression.length,
      );

      if (rightExpression.length == 0) {
        throw InvalidSyntaxException(baseExpression);
      }

      rightNode = ExpressionNode(rightExpression);
    }
  }
}
