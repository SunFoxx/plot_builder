import 'package:flutter/material.dart';
import 'package:function_printer/services/plot_service.dart';

class AppState extends ChangeNotifier {
  String _expression;
  String _expressionError;
  double _leftRange;
  double _rightRange;
  dynamic _plotData;
  PlotServiceType _plotServiceType;

  AppState() : _plotServiceType = PlotServiceType.MANUAL;

  void buildPlotData() async {
    if (expression == null ||
        leftRange == null ||
        rightRange == null ||
        expression.length == 0) {
      expressionError = "Fill all input fields first";
      return;
    }

    try {
      plotData = await PLOT_SERVICE_MAP[plotServiceType]
          .getPlotData(_expression, leftRange, rightRange);
      expressionError = null;
    } catch (e) {
      expressionError = e.toString();
    }
  }

  double get leftRange => _leftRange;
  double get rightRange => _rightRange;
  String get expression => _expression;
  String get expressionError => _expressionError;
  PlotServiceType get plotServiceType => _plotServiceType;
  dynamic get plotData => _plotData;

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

  set plotServiceType(PlotServiceType value) {
    _plotServiceType = value;
    notifyListeners();
  }

  set plotData(dynamic value) {
    _plotData = value;
    notifyListeners();
  }
}
