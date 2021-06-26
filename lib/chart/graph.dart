import 'package:intl/intl.dart';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
// import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:todo/constrant.dart';
import 'package:todo/database/db_helper.dart';
import 'package:todo/model/AddTask.dart';

class Graph extends StatefulWidget {
  @override
  _GraphState createState() => _GraphState();
}

final Color lineColor = Color(0xff0855AD);

class _GraphState extends State<Graph> {
  List<FlSpot> data = [];
  List<double> date = [];
  DB_Helper db = DB_Helper();

  void initState() {
    // Future<List<FlSpot>> data = fgData(10);
    // print(data);
    // for (int i = 0; i < 10; i++) {}
    super.initState();
  }

  List<Color> gradientColors = [
    lineColor
    // lineColor
    // const Color(0xff02d39a),
  ];
  double kScore = 0.65;
  bool showAvg = false;
// drop down:  https://protocoderspoint.com/flutter-drop-down-menu-list-drop-down-in-flutter/
  var items = [10, 30, 180, 365, -1];
  double dValue = 10;
  int dropdownvalue = 10;
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          // color: Color(0xff151D33),
          child: Padding(
            padding: const EdgeInsets.only(
                right: 18.0, left: 12.0, top: 24, bottom: 12),
            child: LineChart(mainData(dValue * 1.00)),
          ),
        ),
        Container(
          // width: 150,
          height: 40,
          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
            border: Border.all(color: Color(0xff37434d), width: 2),

            // color: Colors.pink,
            color: Color(0xff1E1E30),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: dropdownvalue,
              icon: Icon(Icons.keyboard_arrow_down),
              dropdownColor: Color(0xff37434d),
              items: items.map((int items) {
                return DropdownMenuItem(
                    value: items,
                    child: Center(
                        child: items != -1
                            ? Text("Lasts $items days")
                            : Text("all")));
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  print(dropdownvalue);
                  dropdownvalue = newValue as int;
                  print(dropdownvalue);
                  //TODO:  selection of graph
                  if (newValue == -1) {
                    showAvg = true;
                    dValue = 600.00;
                  } else {
                    dValue = newValue * 1.00;
                    showAvg = false;
                  }
                });
              },
            ),
          ),
        ),

        // detailWidget(165.00),
      ],
    );
  }

// TODO: add data parameter

// https://github.com/imaNNeoFighT/fl_chart/blob/master/example/lib/line_chart/samples/line_chart_sample2.dart
  LineChartData mainData(double n) {
    print("ascha $n");
    double wi = 3;
    var pow2 = pow(2.303, n);
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),

      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
              color: Color(0xff0855AD),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            if (value.toInt() % 2 == 0) {
              print('${date[value.toInt() - 1]}');
              //   // return '${date[value as int]}';
              //   return 'te';
              return '${date[value.toInt() - 1]}';
            } else
              return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: false,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff0855AD),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            if ((value * 100).toInt() % 100 % 2 == 0) {
              // print('${value.toDouble()}');
              return '${value.toDouble()}';
            } else
              return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
        rightTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff0855AD),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            if (value.toInt() % 5 == 0) {
              // print('${value.toDouble()}');
              return '${value.toDouble()}';
            } else
              return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border(
            bottom: BorderSide(color: const Color(0xff0855AD), width: wi),
            right: BorderSide(color: const Color(0xff0855AD), width: wi),
          )
          // Border.(color: const Color(0xff0855AD), width: 2)
          ),
      // TODO: scaling of graph
      minX: 1,
      maxX: n + 0.01 * n,
      minY: -1,
      maxY: 10,
      lineBarsData: [
        LineChartBarData(
          spots: gDta(n),
          isCurved: true,
          colors: gradientColors,
          barWidth: wi,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  List<FlSpot> gDta(double n) {
    data.clear();
    date.clear();
    fgData(n);
    return data;
  }

  void fgData(double n) async {
    // TODO: data here
    var now = DateTime.now();

    // 2021-06-21
    print("fdate: $n");
    for (int i = 1; i <= n; i++) {
      var ddate = DateTime(now.year, now.month, now.day - i + 1);
      var d = DateFormat('yyyy-MM-dd').format(ddate);
      // print(d);
      StoreTask storeddata = await db.getTodo(d);
      if (storeddata != null) {
        data.add(FlSpot((n - i + 1) * 1.0, storeddata.score * 10));
        // print("${date.day * 1.0 + date.month * 0.01} : ${storeddata.score}");
      } else {
        data.add(FlSpot((n - i + 1) * 1.0, 0.00));
        // print("${date.day * 1.0 + date.month * 0.01} : 0");
      }
      date.add(ddate.day * 1.0 + ddate.month * 0.01);
    }
    // data = List.from(data.reversed);
    date = List.from(date.reversed);
    // print("${date.length} , ${data.length} ");
    for (int i = 0; i < n; i++) print("${data[i].x} , ${data[i].y}");
    // return data;
  }
}
