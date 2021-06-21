import 'dart:async';
import 'dart:convert';
import 'package:todo/model/AddTask.dart';
import 'package:todo/constrant.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/Screen/AddTaskScreen.dart';
import 'package:todo/Screen/HomeScreen.dart';

import 'package:intl/intl.dart';
import 'package:todo/database/db_helper.dart';

class MainScreen extends StatelessWidget {
  TextStyle _style = TextStyle(fontSize: 55);
  bool _isDark = true;
  ThemeData _light = ThemeData.light().copyWith(
    primaryColor: Colors.green,
  );
  ThemeData _dark = ThemeData.dark().copyWith(
    accentColor: Color(0xFFEB06FF),

    primaryColor: Color(0xFF101438),
    //  Color(0x3450A1),
    backgroundColor: Color(0xFF041955),
    scaffoldBackgroundColor: Color(0xFF101438),
    cardColor: Color(0xFF272A4D),
    // Color(0xFF272A4D),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: _dark,
      theme: _light,
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Theme',
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DB_Helper db = DB_Helper();

  String onlyDay(DateTime date) {
    final DateFormat formatter = DateFormat("yyyy-MM-dd");
    return formatter.format(date);
  }

  void initState() {
    formatted = onlyDay(DateTime.now());
    // Timer(Duration(seconds: 5), () {
    //   print("pushing");
    //   Navigator.pushNamed(context, "/intro");
    // });
    db.initializeDatabase().then((value) {
      loaddata(formatted);
      print('------database intialized $kScore');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // final value =
        return await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('Are you sure you want to exit?'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('No'),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  FlatButton(
                    child: Text('Yes, exit'),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                ],
              );
            });
      },
      child: Scaffold(
          body: SafeArea(
            child: HomeScreen(),
          ),
          floatingActionButton: Builder(
            builder: (context) => FloatingActionButton.extended(
              backgroundColor: Color(0xFF272B4C),
              icon: new Icon(
                Icons.add,
                color: Colors.white,
                size: 40,
              ),
              label: Text(
                "add task",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                print("pressed");

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Todo()));
                loaddata(formatted);
                print("!pressed");
              },
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat),
    );
  }

  Future<void> loaddata(String date) async {
    item.clear();
    StoreTask storeddata = await db.getTodo(date);
    if (storeddata != null) {
      print(
          "${storeddata.dateTime}: ${storeddata.alltask} , ${storeddata.score}");

      var x = jsonDecode(storeddata.alltask);
      print(x);
      print("len: ${x.length}");
      ktaskdone = 0;
      ktotaltask = 0;
      int score = 0, total = 0;
      for (int i = 0; i < x.length; i++) {
        var xx = AddTask.fromMap(x[i]);
        //TODO : loading screen
        item.add(AddTask(
            task: x[i]["task"],
            isDone: x[i]["done"] == "true" ? true : false,
            isSubtask: x[i]["isSubtask"] == "true" ? true : false));
        //TODO: (DONE) load data to todo app from db
        print("$i:   ${x[i]["done"]} ");
      }
      print("db Your Score: $score/$total");
      setState(() {
        ktotaltask = x.length;
        if (total == 0) {
          ktotaltask += 1;
          total = 1;
        }
        kScore = storeddata.score;
        // calScore();
      });
    } else {
      print("$date not data");
    }
  }
}
