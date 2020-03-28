import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:function_printer/model/point.dart';
import 'package:function_printer/utils/calculations.dart';

const double AXIS_OFFSET = 15;

class GraphPainter extends CustomPainter {
  List<Point> points;

  GraphPainter(this.points);

  void drawXAxisValue(Canvas canvas, Point point, Size size, double xPosition) {
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: '${point.x.toStringAsFixed(2)}',
        style: TextStyle(
          color: Colors.black,
          fontSize: 12,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    Paint linePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    textPainter.layout(minWidth: 20, maxWidth: size.width);
    final offset = Offset(
      xPosition,
      size.height + AXIS_OFFSET,
    );
    final offset2 = Offset(
      xPosition,
      size.height,
    );
    textPainter.paint(canvas, offset);
    canvas.drawLine(offset, offset2, linePaint);
  }

  drawYAxisValues(Canvas canvas, Size size, double min, double max) {
    for (int i = 1; i <= 4; i++) {
      TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: '${(min + (max - min) * (0.25 * i)).toStringAsFixed(2)}',
          style: TextStyle(
            color: Colors.black,
            fontSize: 12,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      Paint linePaint = Paint()
        ..color = Colors.black
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      textPainter.layout(minWidth: 20, maxWidth: size.width);
      final offset = Offset(
        AXIS_OFFSET,
        size.height - (size.height * (i * 0.25)),
      );
      final offset2 = Offset(
        0,
        size.height - (size.height * (i * 0.25)),
      );
      textPainter.paint(canvas, offset);
      canvas.drawLine(offset, offset2, linePaint);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint graphPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    Paint axisPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    Path graphPath = Path();

    List<double> values = points.map((e) => e.y).toList();
    double maxY = values.reduce(max) * 1.2;
    double minY = values.reduce(min);

    double minX = points[0].x;
    double maxX = points[points.length - 1].x;

    graphPath.moveTo(
      0,
      size.height - (size.height * getRangePercentage(minY, maxY, points[0].y)),
    );
    for (int i = 0; i <= points.length - 2; i += 2) {
      graphPath.quadraticBezierTo(
        size.width * getRangePercentage(minX, maxX, points[i + 1].x),
        size.height -
            (size.height * getRangePercentage(minY, maxY, points[i + 1].y)),
        size.width * getRangePercentage(minX, maxX, points[i + 2].x),
        size.height -
            (size.height * getRangePercentage(minY, maxY, points[i + 2].y)),
      );

      drawXAxisValue(canvas, points[i], size,
          size.width * getRangePercentage(minX, maxX, points[i].x));
    }

    canvas.drawLine(
        Offset(0, size.height), Offset(size.width, size.height), axisPaint);
    canvas.drawLine(Offset(0, size.height), Offset(0, 0), axisPaint);
    drawYAxisValues(canvas, size, minY, maxY);
    canvas.drawPath(graphPath, graphPaint);
  }

  @override
  bool shouldRepaint(GraphPainter oldDelegate) => oldDelegate.points != points;
}
