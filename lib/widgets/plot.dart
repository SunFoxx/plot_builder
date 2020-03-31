import 'package:flutter/material.dart';
import 'package:function_printer/model/point.dart';
import 'package:function_printer/services/plot_service.dart';
import 'package:function_printer/widgets/custom_plot_painter.dart';

class Plot extends StatelessWidget {
  final PlotServiceType serviceType;
  final dynamic plotData;

  const Plot({Key key, @required this.serviceType, this.plotData})
      : super(key: key);

  Widget buildWolfram() {
    return (plotData is String)
        ? Image.network(
            plotData,
            excludeFromSemantics: true,
            fit: BoxFit.cover,
            loadingBuilder: (_, child, loading) {
              if (loading == null && (child as RawImage).image != null)
                return child;

              return CircularProgressIndicator();
            },
          )
        : CircularProgressIndicator();
  }

  Widget buildCustom() {
    return (plotData is List<Point>)
        ? Container(
            padding: EdgeInsets.all(5.0),
            child: CustomPaint(
              painter: CustomPlotPainter(plotData),
              size: Size(double.infinity, 200),
              willChange: true,
              isComplex: true,
            ),
          )
        : CircularProgressIndicator();
  }

  @override
  Widget build(BuildContext context) {
    if (plotData == null) {
      return Padding(
        padding: EdgeInsets.all(15.0),
        child: Text('Nothing to draw'),
      );
    }

    switch (serviceType) {
      case PlotServiceType.MANUAL:
        return buildCustom();
      case PlotServiceType.WOLFRAM:
        return buildWolfram();
      default:
        return SizedBox();
    }
  }
}
