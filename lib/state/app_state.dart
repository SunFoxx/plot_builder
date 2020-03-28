import 'package:flutter/material.dart';
import 'package:function_printer/model/point.dart';

class AppState extends ChangeNotifier {
  String expression;
  double leftRange;
  double rightRange;
  List<Point> graphPoints;

  void buildGraphPoints() {
    if (expression == null || leftRange == null || rightRange == null) return;

    // keep this value uneven
    const int points = 13;
    double fraction = (rightRange - leftRange) / (points - 1);

    List<Point> result = List();
    result.add(Point.fromExpression(expression, leftRange));

    for (int i = 1; i <= points - 2; i++) {
      result.add(Point.fromExpression(expression, leftRange + (fraction * i)));
    }
    result.add(Point.fromExpression(expression, rightRange));

    print(graphPoints);
    graphPoints = result;
  }
}
