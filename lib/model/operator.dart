import 'dart:math' as math;

import 'package:flutter/material.dart';

class OperatorGroup {
  TextDirection direction;
  List<String> operators;

  OperatorGroup(this.direction, this.operators);
}

// index defines priority, from lower to bigger
final List<OperatorGroup> OPERATOR_GROUPS = [
  OperatorGroup(TextDirection.ltr, ['+', '-']),
  OperatorGroup(TextDirection.ltr, ['/', '*']),
  OperatorGroup(TextDirection.rtl, ['^', 's']),
];

final Map<String, Function> OPERATORS_MAP = {
  "+": (double a, double b) => a + b,
  "-": (double a, double b) => a - b,
  "/": (double a, double b) => a / b,
  "*": (double a, double b) => a * b,
  "^": (double a, double b) => math.pow(a, b),
  "s": (double a) => math.sqrt(a),
};
