// import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:flutter/foundation.dart';

class AddTask {
  String task = "";
  bool isDone = false;
  bool isSubtask = false;

  AddTask({this.task, this.isDone, this.isSubtask});
  void ismarkedDone() {
    this.isDone = !this.isDone;
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

  factory AddTask.fromMap(Map<String, dynamic> json) {
    print("fmap: ${json["task"]}");

    return AddTask(
        isDone: json["done"] == "true" ? true : false,
        isSubtask: json["isSubtask"] == "true" ? true : false,
        task: json["task"]);
  }
  Map<String, dynamic> toMap() => {
        "done": isDone == true ? "true" : "false",
        "isSubtask": isSubtask == true ? "true" : "false",
        "task": task,
        //  TODO: ADD subtask here
        // "isSubtask": isSubtask,
      };
}

// TODO: Parsing & unparsing of data

class StoreTask {
  final String alltask;
  final String dateTime;
  final int score;
  StoreTask({
    this.alltask,
    this.dateTime,
    this.score,
  });

  // reading data from db & storing it
  factory StoreTask.fromMap(Map<String, dynamic> json) => StoreTask(
        dateTime: json["dateTime"],
        alltask: json["alltask"],
        score: json["score"],
      );
  //converting to json inorder to store data
  Map<String, dynamic> toMap() => {
        "dateTime": dateTime,
        "alltask": alltask,
        "score": score * 1000,
      };
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
