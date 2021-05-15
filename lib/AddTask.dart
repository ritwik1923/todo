import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

class AddTask {
  String task = "Add task here";
  bool isDone = false;
  bool isSubtask = false;
  List<String> subtask = [];
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

// TODO: Parsing & unparsing of data

class StoreTask {
  final String alltask;
  final String dateTime;
  StoreTask({
    this.alltask,
    this.dateTime,
  });

  // reading data from db & storing it
  factory StoreTask.fromMap(Map<String, dynamic> json) => StoreTask(
        dateTime: json["dateTime"],
        alltask: json["alltask"],
      );
  //converting to json inorder to store data
  Map<String, dynamic> toMap() => {
        "alltask": alltask,
        "dateTime": dateTime,
      };
}

class DailyPerformance {
  final int year;

  final double subscribers;

  final charts.Color barColor;

  DailyPerformance({
    @required this.year,
    @required this.subscribers,
    @required this.barColor,
  });
}

// TODO: store data as 'var xx'

// import 'dart:convert';
// void main() {

//   var xx = '[{"done": "1","issubtask": "1","task": "To store json as string in flutter","subtask": [{"done": "1","task": "task1"},{"done": "0","task": "task2"},{"done": "1","task":"task3"}]},{"done": "0","issubtask": "0","task": "Task 2","subtask": "null"}]';

//   List<dynamic> x = jsonDecode(xx);
//   print(x.length);
//   for(int i = 0;i<x.length;i++) {
//      if(x[i]["issubtask"] == "1") {
//        for(int j = 0 ; j < x[i]["subtask"].length;j++)
//             print("\t${x[i]["subtask"][j]}");
//   }
//     else {
//       print("no Subtask");
//     }
//   }
// }
