import 'package:flutter/material.dart';
import 'package:function_printer/services/plot_service.dart';
import 'package:function_printer/state/app_state.dart';
import 'package:function_printer/theme/text_theme.dart';
import 'package:function_printer/widgets/input_field.dart';
import 'package:function_printer/widgets/plot.dart';
import 'package:function_printer/widgets/radio_button.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String expressionInput;
  PlotServiceType plotServiceType = PlotServiceType.MANUAL;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Column(
            children: <Widget>[
              // inputs section
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.elliptical(10.0, 5.0),
                    bottomRight: Radius.elliptical(10.0, 5.0),
                  ),
                ),
                child: SafeArea(
                  child: Consumer<AppState>(
                    builder: (_, state, children) => Column(
                      children: <Widget>[
                        // Expression input
                        InputField(
                          leading: Text(
                            'f(x) = ',
                            style: inputLeadingStyle,
                          ),
                          hintText: 'Input math expression here',
                          onChanged: (text) {
                            state.expression = text;
                          },
                        ),
                        SizedBox(height: 20),
                        // Range Input
                        Row(
                          children: <Widget>[
                            Text(
                              '[ ',
                              style: inputLeadingStyle,
                            ),
                            Flexible(
                              child: InputField(
                                hintText: "Minimum X",
                                inputType: TextInputType.number,
                                onChanged: (text) {
                                  state.leftRange = double.parse(text);
                                },
                              ),
                            ),
                            Text(
                              ' : ',
                              style: inputLeadingStyle,
                            ),
                            Flexible(
                              child: InputField(
                                hintText: "Maximum X",
                                inputType: TextInputType.number,
                                onChanged: (text) {
                                  state.rightRange = double.parse(text);
                                },
                              ),
                            ),
                            Text(
                              ' ]',
                              style: inputLeadingStyle,
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        // Solve method buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RadioButton(
                              value: PlotServiceType.MANUAL,
                              groupValue: plotServiceType,
                              label: "Custom",
                              onChanged: (value) {
                                setState(() {
                                  plotServiceType = value;
                                });
                              },
                            ),
                            SizedBox(width: 5),
                            RadioButton(
                              value: PlotServiceType.WOLFRAM,
                              groupValue: plotServiceType,
                              label: "Wolfram",
                              onChanged: (value) {
                                setState(() {
                                  plotServiceType = value;
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        // Button
                        RaisedButton(
                          onPressed: () {
                            state.plotServiceType = plotServiceType;
                            state.buildPlotData();
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                          },
                          color: Colors.lightBlueAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            "Run",
                            style: buttonTextStyle,
                          ),
                        ),
                        state.expressionError != null
                            ? Center(
                                child: Text(
                                  state.expressionError,
                                  style: errorTextStyle,
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
              // content section
              Consumer<AppState>(builder: (_, state, child) {
                if (state.expressionError != null) {
                  return SizedBox();
                }

                return Plot(
                  serviceType: state.plotServiceType,
                  plotData: state.plotData,
                );
              })
            ],
          ),
        ],
      ),
    );
  }
}
