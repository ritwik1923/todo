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
// import '';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DB_Helper db = DB_Helper();

  String formatted = "";
  void initState() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    formatted = formatter.format(now);

    db.initializeDatabase().then((value) {
      loaddata();
      print('------database intialized $kScore');
    });
    super.initState();
  }

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
      home: Scaffold(
          body: CollapsingList(),
          // TodoList(),

          floatingActionButton: Builder(
            builder: (context) => FloatingActionButton.extended(
              backgroundColor: Color(0xFF272B4C),
              icon: new Icon(
                Icons.add,
                color: Colors.white,
                size: 40,
                // textDirection: TextDirection.LTR,
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
                loaddata();
                showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    builder: (context) {
                      return DraggableSheet();
                      Container(
                        height: 300,
                        width: 300,
                        color: Colors.pinkAccent,
                      );
                    }).then((value) async {
                  setState(() {
                    List<String> data = [];
                    for (int index = 0; index < item.length; index++) {
                      data.add(jsonEncode(item[index].toMap()));
                    }

                    String d = "$data";
                    // ignore: non_constant_identifier_names
                    var STodod = StoreTask(dateTime: formatted, alltask: d);
                    print("res: $STodod");
                    db.insertTodo(STodod);
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
    // print("${storeddata[].dateTime} : ")
    if (storeddata != null) {
      print("${storeddata.dateTime}: ${storeddata.alltask}");

      // List<String> dd = storeddata.alltask as List<String>;
      var x = jsonDecode(storeddata.alltask);
      // var x = storeddata.alltask;
      print(x);
      print("len: ${x.length}");
      item.clear();
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
        var xx = AddTask.fromMap(x[i]);
        //TODO : loading screen
        item.add(AddTask(
            task: x[i]["task"],
            isDone: x[i]["done"] == "true" ? true : false,
            isSubtask: x[i]["isSubtask"] == "true" ? true : false));
        //TODO: (DONE) load data to todo app from db
        print("$i:   ${x[i]["done"]} ");
        // if (x[i]["issubtask"] == "1") {
        //   for (int j = 0; j < x[i]["subtask"].length; j++)
        //     print("\t${x[i]["subtask"][j]}");
        // } else {
        //   print("no Subtask");
        // }
      }
      print("db Your Score: $score/$total");
      setState(() {
        kScore = score / total * 1;
      });
    } else {
      print("not data");
    }
  }
}
