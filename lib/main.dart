import 'package:todo/Screen/loading_Screen.dart';
import 'package:todo/Screen/main_Screen.dart';

import 'package:flutter/material.dart';
import 'package:todo/Screen/HomeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        // Replace the 3 second delay with your initialization code:
        future: Future.delayed(Duration(seconds: 2)),
        builder: (context, AsyncSnapshot snapshot) {
          // Show splash screen while waiting for app resources to load:
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          } else {
            return MainScreen();
          }
        });
  }
}

var routes = <String, WidgetBuilder>{
  // "/home": (BuildContext context) => HomeScreen(),
  "/intro": (BuildContext context) => HomeScreen(),
};


/*
adb -d shell "run-as com.example.todo cat /data/data/com.example.todo/databasesTodo.db" > databasesTodo.db
 */