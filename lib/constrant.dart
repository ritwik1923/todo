import 'package:flutter/material.dart';
import 'package:todo/AddTask.dart';

// final item = [];
final List<AddTask> item = [];
double barWeidth = 50;
double barHeight = 5;
double kScore = 0;
int ktaskdone = 0;
int ktotaltask = 0;
String klable1 = "Performance";
String ksubtext1 = "see your progress";
String klable2 = "Plan Tomrrow";
String ksubtext2 = "plan your task for up comming days";

kTextStyle(double fs) {
  return TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: fs,
    color: Colors.white,
  );
}

var kSubTextStyle = TextStyle(
  fontSize: 15.0,
);
