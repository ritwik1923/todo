import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/Screen/draggable.dart';
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
          floatingActionButton: Builder(
            builder: (context) => FloatingActionButton(
                backgroundColor: Color(0xFFFF0067),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {
                  print("pressed");
                  showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      builder: (context) {
                        return DraggableSheet();
                      });

                  // showModalBottomSheet(
                  //     context: context,
                  //     isScrollControlled: true,
                  //     backgroundColor: Colors.transparent,
                  //     builder: (context) {
                  //       return DraggableScrollableSheet(
                  //         initialChildSize: 0.8,
                  //         builder: (BuildContext context,
                  //             ScrollController scrollController) {
                  //           return SingleChildScrollView(
                  //             controller: scrollController,
                  //             child: Container(
                  //                 decoration: BoxDecoration(
                  //                   color: Colors.red,
                  //                   borderRadius: BorderRadius.only(
                  //                     topLeft: const Radius.circular(10),
                  //                     topRight: const Radius.circular(10),
                  //                   ),
                  //                 ),
                  //                 child: Column(
                  //                   mainAxisSize: MainAxisSize.min,
                  //                   children: <Widget>[
                  //                     ListTile(
                  //                       leading: new Icon(Icons.photo),
                  //                       title: new Text('Photo'),
                  //                       onTap: () {
                  //                         Navigator.pop(context);
                  //                       },
                  //                     ),
                  //                     ListTile(
                  //                       leading: new Icon(Icons.music_note),
                  //                       title: new Text('Music'),
                  //                       onTap: () {
                  //                         Navigator.pop(context);
                  //                       },
                  //                     ),
                  //                     ListTile(
                  //                       leading: new Icon(Icons.videocam),
                  //                       title: new Text('Video'),
                  //                       onTap: () {
                  //                         Navigator.pop(context);
                  //                       },
                  //                     ),
                  //                     ListTile(
                  //                       leading: new Icon(Icons.share),
                  //                       title: new Text('Share'),
                  //                       onTap: () {
                  //                         Navigator.pop(context);
                  //                       },
                  //                     ),
                  //                   ],
                  //                 )
                  //                 //       "assets/images/trigger_warning_prompt.jpg"),
                  //                 ),
                  //           );
                  //         },
                  //       );
                  //     });
                }),
          )),
    );
  }
}
