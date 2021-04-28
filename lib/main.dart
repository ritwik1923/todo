import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/todo.dart';

import 'AddTask.dart';
import 'constrant.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {
    for (int i = 0; i < 3; i++) {
      item.add(AddTask());
    }
    // item.add(FlatButton(
    //     child: Row(
    //       children: [
    //         Icon(Icons.add, size: 25),
    //         SizedBox(width: 10),
    //         Text(
    //           "Add Task",
    //           style: TextStyle(fontSize: 15),
    //         ),
    //       ],
    //     ),
    //     onPressed: () {
    //       setState(() {
    //         item.insert(item.length - 1, AddTask());
    //       });
    //     }));
  }

  TextStyle _style = TextStyle(fontSize: 55);
  bool _isDark = false;
  ThemeData _light = ThemeData.light().copyWith(
    primaryColor: Colors.green,
  );
  ThemeData _dark = ThemeData.dark().copyWith(
    primaryColor: Colors.blueGrey,
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
        appBar: AppBar(
          title: Text('Todo'),
          centerTitle: true,
          actions: [
            FlatButton(
              onPressed: () {
                setState(() {
                  _isDark = !_isDark;
                });
              },
              child: Icon(
                Icons.menu,
                size: 40,
              ),
            )
          ],
        ),
        body: TodoList(),
      ),
    );
  }
}
