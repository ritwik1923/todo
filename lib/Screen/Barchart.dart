import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:bar_wow/subscriber_series.dart';
import 'package:flutter/material.dart';

import '../AddTask.dart';

var axis = charts.NumericAxisSpec(
    renderSpec: charts.GridlineRendererSpec(
  labelStyle: charts.TextStyleSpec(
      fontSize: 10,
      color: charts
          .MaterialPalette.white), //chnage white color as per your requirement.
));
const kStyle =
    charts.TextStyleSpec(fontSize: 14, color: charts.MaterialPalette.white);

class BarChart extends StatelessWidget {
  final List<DailyPerformance> data;

  BarChart({@required this.data});
  @override
  Widget build(BuildContext context) {
    List<charts.Series<DailyPerformance, String>> series = [
      charts.Series(
          id: "Subscribers",
          data: data,
          domainFn: (DailyPerformance series, _) => (series.year).toString(),
          measureFn: (DailyPerformance series, _) => series.subscribers % 99,
          colorFn: (DailyPerformance series, _) => series.barColor)
    ];
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          height: 100,
          width: data.length * 35.00,
          // padding: EdgeInsets.all(20),
          child: charts.BarChart(
            series,
            animate: true,
            // primaryMeasureAxis: axis,
            // domainAxis: axis,
            domainAxis: new charts.OrdinalAxisSpec(
                renderSpec: new charts.SmallTickRendererSpec(

                    // Tick and Label styling here.
                    labelStyle: new charts.TextStyleSpec(
                      fontSize: 15, // size in Pts.
                      color: charts.MaterialPalette.white,
                    ),

                    // Change the line colors to match text color.
                    lineStyle: new charts.LineStyleSpec(
                        color: charts.MaterialPalette.white))),

            /// Assign a custom style for the measure axis.
            primaryMeasureAxis: new charts.NumericAxisSpec(
                renderSpec: new charts.GridlineRendererSpec(

                    // Tick and Label styling here.
                    labelStyle: new charts.TextStyleSpec(
                        fontSize: 15, // size in Pts.
                        color: charts.MaterialPalette.white),

                    // Change the line colors to match text color.
                    lineStyle: new charts.LineStyleSpec(
                        color: charts.MaterialPalette.white))),
            behaviors: [
              // Adding this behavior will allow tapping a bar to center it in the viewport
              charts.SlidingViewport(
                charts.SelectionModelType.action,
              ),
              charts.PanBehavior(),
            ],
          ),
        ));
  }
}

class LineChart extends StatelessWidget {
  final List<DailyPerformance> data;

  LineChart({@required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<DailyPerformance, num>> series = [
      charts.Series(
          id: "Subscribers",
          data: data,
          domainFn: (DailyPerformance series, _) => (series.year),
          measureFn: (DailyPerformance series, _) => series.subscribers % 99,
          colorFn: (DailyPerformance series, _) => series.barColor)
    ];
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          height: 150,
          width: data.length * 10.00,
          // padding: EdgeInsets.all(20),
          child: charts.LineChart(
            series,
            animate: true,
            domainAxis: new charts.NumericAxisSpec(
                renderSpec: new charts.SmallTickRendererSpec(

                    // Tick and Label styling here.
                    labelStyle: new charts.TextStyleSpec(
                      fontSize: 15, // size in Pts.
                      color: charts.MaterialPalette.white,
                    ),

                    // Change the line colors to match text color.
                    lineStyle: new charts.LineStyleSpec(
                        color: charts.MaterialPalette.white))),
            primaryMeasureAxis: new charts.NumericAxisSpec(
                renderSpec: new charts.GridlineRendererSpec(

                    // Tick and Label styling here.
                    labelStyle: new charts.TextStyleSpec(
                        fontSize: 15, // size in Pts.
                        color: charts.MaterialPalette.white),

                    // Change the line colors to match text color.
                    lineStyle: new charts.LineStyleSpec(
                        color: charts.MaterialPalette.white))),
          ),
        ));
  }
}
