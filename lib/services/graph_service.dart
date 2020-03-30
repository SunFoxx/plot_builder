import 'package:function_printer/model/point.dart';

enum GraphServiceType { MANUAL, WOLFRAM }

abstract class GraphService {
  Future<List<Point>> getGraphPoints(
      String expression, double minRange, double maxRange);
}

final Map<GraphServiceType, GraphService> GRAPH_SERVICE_MAP = {
  GraphServiceType.MANUAL: ManualGraphService(),
  GraphServiceType.WOLFRAM: WolframGraphService(),
};

class ManualGraphService implements GraphService {
  @override
  Future<List<Point>> getGraphPoints(
      String expression, double minRange, double maxRange) {
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

      print(result);
      return result;
    });
  }
}

class WolframGraphService implements GraphService {
  @override
  Future<List<Point>> getGraphPoints(
      String expression, double minRange, double maxRange) {
    return Future(() => []);
  }
}
