import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

class AddTask {
  String task = "Add task here";
  bool isDone = false;

  // AddTask(this.task);

  void ismarkedDone(bool marked) {
    this.isDone = marked;
  }

  void addTask(String task) {
    this.task = task;
  }

  bool getMarkedDone() {
    return this.isDone;
  }

  String getTask() {
    return this.task;
  }
}

class DailyPerformance {
  final int year;

  final double subscribers;

  final charts.Color barColor;

  DailyPerformance({
    required this.year,
    required this.subscribers,
    required this.barColor,
  });
}
