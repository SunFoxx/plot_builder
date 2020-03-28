import 'package:flutter/material.dart';
import 'package:function_printer/state/app_state.dart';
import 'package:function_printer/widgets/graph_painter.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String expressionInput;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              decoration: BoxDecoration(border: Border.all()),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: TextField(
                      onChanged: (text) => {
                        this.setState(() {
                          expressionInput = text;
                        })
                      },
                    ),
                  ),
                  SizedBox(width: 15),
                  Consumer<AppState>(
                    builder: (_, state, children) {
                      return IconButton(
                          icon: Icon(Icons.forward),
                          onPressed: () {
                            setState(() {
                              state.expression = expressionInput;
                              state.leftRange = -4.0;
                              state.rightRange = 4.0;
                              state.buildGraphPoints();
                            });
                          });
                    },
                  )
                ],
              ),
            ),
            Consumer<AppState>(builder: (_, state, child) {
              if (state.graphPoints == null) {
                return Text('nothing to draw');
              }

              return Container(
                padding: EdgeInsets.all(5.0),
                child: CustomPaint(
                  painter: GraphPainter(state.graphPoints),
                  size: Size(double.infinity, 200),
                  willChange: true,
                  isComplex: true,
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
