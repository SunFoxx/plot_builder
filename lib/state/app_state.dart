import 'package:flutter/material.dart';
import 'package:function_printer/model/point.dart';
import 'package:function_printer/services/graph_service.dart';

class AppState extends ChangeNotifier {
  String _expression;
  String _expressionError;
  double _leftRange;
  double _rightRange;
  List<Point> _graphPoints;
  GraphServiceType _graphServiceType;

  AppState() : _graphServiceType = GraphServiceType.MANUAL;

  void buildGraphPoints() async {
    if (_expression == null ||
        _leftRange == null ||
        _rightRange == null ||
        _expression.length == 0) {
      _expressionError = "Fill all input fields first";
      return;
    }

    try {
      _graphPoints = await GRAPH_SERVICE_MAP[_graphServiceType]
          .getGraphPoints(_expression, _leftRange, _rightRange);
      _expressionError = null;
      notifyListeners();
    } catch (e) {
      _expressionError = e.toString();
      notifyListeners();
    }
  }

  void setGraphService(String serviceName) {
    switch (serviceName) {
      case "manual":
        _graphServiceType = GraphServiceType.MANUAL;
        break;
      case "wolfram":
        _graphServiceType = GraphServiceType.WOLFRAM;
        break;
      default:
        break;
    }
  }

  double get leftRange => _leftRange;
  double get rightRange => _rightRange;
  String get expression => _expression;
  String get expressionError => _expressionError;
  GraphServiceType get graphServiceType => _graphServiceType;
  List<Point> get graphPoints => _graphPoints;

  set rightRange(double value) {
    _rightRange = value;
    notifyListeners();
  }

  set leftRange(double value) {
    _leftRange = value;
    notifyListeners();
  }

  set expression(String value) {
    _expression = value;
    notifyListeners();
  }

  set expressionError(String value) {
    _expressionError = value;
    notifyListeners();
  }

  set graphServiceType(GraphServiceType value) {
    _graphServiceType = value;
    notifyListeners();
  }

  set graphPoints(List<Point> value) {
    _graphPoints = value;
    notifyListeners();
  }
}
