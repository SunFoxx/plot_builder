import 'package:function_printer/model/expression_node.dart';
import 'package:function_printer/utils/calculations.dart';
import 'package:function_printer/utils/parse_helpers.dart';

class Point {
  double x;
  double y;

  Point(this.x, this.y);

  factory Point.fromExpression(String expression, double x) {
    String replacedVariable = setVariableValues(expression, x);
    double y = evaluateExpression(ExpressionNode(replacedVariable));

    return Point(x, y);
  }

  @override
  String toString() => '[x: $x, y: $y]';
}
