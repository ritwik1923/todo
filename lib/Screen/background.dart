import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:todo/constrant.dart';

import 'dart:math';

import '../AddTask.dart';
import 'Barchart.dart';

class SamplePage extends StatefulWidget {
  @override
  _SamplePageState createState() => _SamplePageState();
}

double generateRandomNumber() {
  var random = new Random();

  // Printing Random Number between 1 to 100 on Terminal Window.
  return (random.nextInt(100)) * 1.00;
}

class _SamplePageState extends State<SamplePage> {
  double hh = 10;
  var random = new Random();
  final List<DailyPerformance> data = List<DailyPerformance>.generate(
      1000,
      (int index) => DailyPerformance(
            year: index,
            subscribers: generateRandomNumber(),
            barColor: charts.ColorUtil.fromDartColor(Colors.blue),
          ));

  void _openPage(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => page,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                height: hh,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "${(kScore * 10).toStringAsPrecision(3)}%",
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 35.0),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: new CircularPercentIndicator(
                      radius: 90.0,
                      lineWidth: 20.0,
                      animation: true,
                      percent: kScore,
                      // center: new Text(
                      //   "${(kScore * 10).toStringAsPrecision(3)}%",
                      //   style: new TextStyle(
                      //       fontWeight: FontWeight.bold, fontSize: 35.0),
                      // ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Color(0xFF2296F3),
                    ),
                  ),
                ],
              ),
              // SizedBox(
              //   height: hh,
              // ),
              // Card(
              //   elevation: 5,
              //   child: Container(
              //     padding: EdgeInsets.all(8),
              //     child: BarChart(
              //       data: data,
              //     ),
              //   ),
              // ),
              // // LineChart(data: data),
              // SizedBox(
              //   height: hh,
              // ),
              // Card(
              //   elevation: 5,
              //   child: Container(
              //     padding: EdgeInsets.all(8),
              //     child: LineChart(
              //       data: data,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
