import 'package:function_printer/config/constants.dart';
import 'package:function_printer/model/exceptions.dart';
import 'package:function_printer/model/point.dart';

enum PlotServiceType { MANUAL, WOLFRAM }

abstract class PlotService<T> {
  Future<T> getPlotData(String expression, double minRange, double maxRange);
}

final Map<PlotServiceType, PlotService> PLOT_SERVICE_MAP = {
  PlotServiceType.MANUAL: ManualPlotService(),
  PlotServiceType.WOLFRAM: WolframPlotService(),
};

class ManualPlotService implements PlotService<List<Point>> {
  @override
  Future<List<Point>> getPlotData(
      String expression, double minRange, double maxRange) {
    if (minRange >= maxRange) {
      throw InvalidRangeException();
    }

    return Future(() {
      List<Point> result = List();
      // keep this value uneven
      int points = 31;

      // to ensure proper zero division check
      if (0 < maxRange && 0 > minRange) {
        result.add(Point.fromExpression(expression, 0));
        points -= 1;
      }

      double fraction = (maxRange - minRange) / (points - 1);

      for (int i = 0; i <= points - 2; i++) {
        result.add(Point.fromExpression(expression, minRange + (fraction * i)));
      }
      result.add(Point.fromExpression(expression, maxRange));
      result.sort((Point a, Point b) => (a.x - b.x).ceil());

      return result;
    });
  }
}

class WolframPlotService implements PlotService<String> {
  @override
  Future<String> getPlotData(
      String expression, double minRange, double maxRange) {
    if (minRange >= maxRange) {
      throw InvalidRangeException();
    }

    return Future(() {
      // test expression by attempt of building a point
      double testingXPoint = (minRange < 0 && maxRange > 0) ? 0 : minRange;
      Point.fromExpression(expression, testingXPoint);

      String encodedQuery = Uri.encodeComponent(
          'f(x) = $expression with domain of $minRange to $maxRange');
      return '$WOLFRAM_BASE_URL/simple?appid=$WOLFRAM_APP_ID&i=$encodedQuery';
    });
  }
}
