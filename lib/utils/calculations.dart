import 'package:function_printer/model/exceptions.dart';
import 'package:function_printer/model/expression_node.dart';
import 'package:function_printer/model/operator.dart';
import 'package:function_printer/model/postfix.dart';
import 'package:stack/stack.dart';

double evaluateExpression(ExpressionNode expression) {
  List<PostfixItem> postfix = [];
  extractPostfixFromTree(expression, postfix);
  postfix = postfix.reversed.toList();

  return evaluateFromPostfix(postfix);
}

// building postfix in reversed order, which is mean - Root -> Right -> Left
void extractPostfixFromTree(
    ExpressionNode expression, List<PostfixItem> postfix) {
  if (expression.operand != null) {
    postfix.add(PostfixOperand(expression.operand));
  } else {
    postfix.add(PostfixOperator(expression.operator));

    extractPostfixFromTree(expression.rightNode, postfix);

    if (expression.operator != 's') {
      extractPostfixFromTree(expression.leftNode, postfix);
    }
  }
}

double evaluateFromPostfix(List<PostfixItem> postfix) {
  double result = 0;
  Stack<PostfixItem> evaluationStack = Stack();

  postfix.forEach((PostfixItem postfixItem) {
    if (postfixItem is PostfixOperand) {
      evaluationStack.push(postfixItem);
    }

    if (postfixItem is PostfixOperator) {
      Function evalFunction = OPERATORS_MAP[postfixItem.operator];
      double right = (evaluationStack.pop() as PostfixOperand).value;

      if (postfixItem.operator == 's') {
        if (right < 0) {
          throw new NegativeNumberSqrtException(right);
        }
        evaluationStack.push(PostfixOperand(evalFunction(right)));
      } else {
        double left = (evaluationStack.pop() as PostfixOperand).value;

        if (right == 0 && postfixItem.operator == '/') {
          throw new DivisionByZeroException();
        }

        evaluationStack.push(PostfixOperand(evalFunction(left, right)));
      }
    }
  });

  result = (evaluationStack.pop() as PostfixOperand).value;

  return result;
}

double getRangePercentage(double leftRange, double rightRange, double value) {
  return (value - leftRange) / (rightRange - leftRange);
}
