import 'dart:convert';
import 'package:todo/constrant.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/Screen/draggable.dart';
import 'package:todo/Screen/todo.dart';
import 'AddTask.dart';
import 'constrant.dart';
import 'package:intl/intl.dart';

import 'database/db_helper.dart';

void main() {
  runApp(Todo());
}

class Todo extends StatelessWidget {
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

  String formatted = "";
  String onlyDay(DateTime date) {
    final DateFormat formatter = DateFormat("yyyy-MM-dd");
    return formatter.format(date);
  }

  void initState() {
    formatted = onlyDay(DateTime.now());

    db.initializeDatabase().then((value) {
      loaddata();
      print('------database intialized $kScore');
    });
    super.initState();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      StoreData();
      // user returned to our app
    } else if (state == AppLifecycleState.inactive) {
      StoreData();
      // app is inactive
    } else if (state == AppLifecycleState.paused) {
      StoreData();
      // user is about quit our app temporally
    } else if (state == AppLifecycleState.detached) {
      print("detach");
      StoreData();
      // app suspended (not used in iOS)
    }
  }

  @override
  void dispose() {
    StoreData();
    // WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<bool> StoreData() async {
    List<String> data = [];
    for (int i = 0; i < item.length; i++) {
      data.add(jsonEncode(item[i].toMap()));
    }

    // TODO: store data before exit
    String d = "$data";
    // ignore: non_constant_identifier_names
    var STodod = StoreTask(dateTime: formatted, alltask: d);
    print("res: $STodod");
    bool res = await db.insertTodo(STodod);
    if (res == true) {
      print("stored!!..");
      return true;
    } else {
      return false;
    }
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
                      StoreData()
                          .then((value) => Navigator.of(context).pop(true));
                    },
                  ),
                ],
              );
            });

        // return value == true;
      },
      child: Scaffold(
          body: SafeArea(
            child:
                // Container(),
                CollapsingList(),
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
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DraggableSheet()))
                    .then((value) async {
                  setState(() {
                    int score = 0, total = 0;
                    ktaskdone = 0;
                    ktotaltask = 0;
                    for (int i = 0; i < item.length; i++) {
                      if (i < 1) {
                        if (item[i].isDone == true) score += 5;
                        total += 5;
                      } else if (i < 4) {
                        if (item[i].isDone == true) score += 3;
                        total += 3;
                      } else {
                        if (item[i].isDone == true) score += 1;
                        total += 1;
                      }
                      if (item[i].isDone == true) ktaskdone += 1;
                    }
                    ktotaltask = item.length;
                    if (total == 0) {
                      ktotaltask += 1;
                      total = 1;
                    }
                    kScore = score / total;

                    // TODO: store data before exit
                  });
                });
              },
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat),
    );
  }

  Future<void> loaddata() async {
    StoreTask storeddata = await db.getTodo(formatted);
    if (storeddata != null) {
      print("${storeddata.dateTime}: ${storeddata.alltask}");

      var x = jsonDecode(storeddata.alltask);
      print(x);
      print("len: ${x.length}");
      item.clear();
      ktaskdone = 0;
      ktotaltask = 0;
      int score = 0, total = 0;
      for (int i = 0; i < x.length; i++) {
        if (i < 1) {
          if (x[i]["done"] == "true") score += 5;
          total += 5;
        } else if (i < 4) {
          if (x[i]["done"] == "true") score += 3;
          total += 3;
        } else {
          if (x[i]["done"] == "true") score += 1;
          total += 1;
        }
        if (x[i]["done"] == "true") ktaskdone += 1;
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
        kScore = score / total;
      });
    } else {
      print("not data");
    }
  }
}
