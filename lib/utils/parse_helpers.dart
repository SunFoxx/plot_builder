import 'package:flutter/cupertino.dart';
import 'package:function_printer/model/operator.dart';

String adjustExpression(String baseExpression) {
  String result = baseExpression.trim();
  result = ceaseBrackets(result).trim();
  result = result.replaceAll('sqrt', 's');

  return result;
}

// lookup for least priority operation
int findLatestOperatorIndex(String expression) {
  //masking content that behind brackets to avoid interference
  String maskedText = maskBracketsExpressions(expression);

  for (OperatorGroup operatorGroup in OPERATOR_GROUPS) {
    if (operatorGroup.direction == TextDirection.ltr) {
      int furthestIndex = -1;
      operatorGroup.operators.forEach((operator) {
        int lastIndex = maskedText.substring(1).lastIndexOf(operator);

        if (furthestIndex < lastIndex) {
          furthestIndex = lastIndex + 1;
        }
      });

      if (furthestIndex != -1) {
        return furthestIndex;
      }
    }
    if (operatorGroup.direction == TextDirection.rtl) {
      int closestIndex = maskedText.length;
      operatorGroup.operators.forEach((operator) {
        int firstIndex = maskedText.indexOf(operator);

        if (closestIndex > firstIndex && firstIndex != -1) {
          closestIndex = firstIndex;
        }
      });

      if (closestIndex != maskedText.length) {
        return closestIndex;
      }
    }
  }

  return -1;
}

String maskBracketsExpressions(String expression) {
  String maskedText = '$expression';
  int nestedBrackets = 0;

  if (maskedText.indexOf('(') > -1 && maskedText.indexOf(')') > 0) {
    for (int i = maskedText.indexOf('(');
        i <= maskedText.lastIndexOf(')');
        i++) {
      if (maskedText[i] == '(') {
        nestedBrackets += 1;
      }

      if (maskedText[i] == ')') {
        nestedBrackets -= 1;
      }

      if (nestedBrackets > 0 || maskedText[i] == ')') {
        maskedText = maskedText.replaceRange(i, i + 1, '?');
      }
    }
  }

  return maskedText;
}

String ceaseBrackets(String expression) {
  bool isEnclosing = false;
  int nestedBrackets = 0;

  for (int i = 0; i < expression.length; i++) {
    if (expression[i] == '(') {
      nestedBrackets += 1;
    }

    if (expression[i] == ')') {
      nestedBrackets -= 1;
    }

    if (nestedBrackets == 0 && expression[i] == ')') {
      isEnclosing = i == expression.length - 1;
      break;
    }
  }

  if (expression[0] == '(' &&
      expression[expression.length - 1] == ')' &&
      isEnclosing) {
    String resultString = expression.substring(1, expression.length - 1);

    // resolving excess brackets i.e. (((x)))
    if (resultString[0] == '(' &&
        resultString[resultString.length - 1] == ')') {
      return ceaseBrackets(resultString);
    }

    return expression.substring(1, expression.length - 1);
  }

  return expression;
}

String setVariableValues(String expression, double value) {
  if (value >= 0) {
    return expression.replaceAll('x', '$value');
  }

  return expression.replaceAll('x', '($value)');
}
