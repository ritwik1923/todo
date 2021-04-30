import 'package:flutter/material.dart';
import 'package:todo/constrant.dart';
import 'AddTask.dart';
import 'Screen/background.dart';
import 'Screen/draggable.dart';
import 'constrant.dart';

class Todo extends StatefulWidget {
  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todiio"),
        actions: [
          Icon(
            Icons.menu,
            size: 40,
          )
        ],
      ),
      // body: TodoList(),
      // floatingActionButton: FloatingActionButton(
      //     child: Icon(
      //       Icons.add,
      //       color: Colors.pink,
      //     ),
      //     onPressed: () {
      //       showModalBottomSheet(
      //           context: context,
      //           builder: (context) {
      //             return Column(
      //               mainAxisSize: MainAxisSize.min,
      //               children: <Widget>[
      //                 ListTile(
      //                   leading: new Icon(Icons.photo),
      //                   title: new Text('Photo'),
      //                   onTap: () {
      //                     Navigator.pop(context);
      //                   },
      //                 ),
      //                 ListTile(
      //                   leading: new Icon(Icons.music_note),
      //                   title: new Text('Music'),
      //                   onTap: () {
      //                     Navigator.pop(context);
      //                   },
      //                 ),
      //                 ListTile(
      //                   leading: new Icon(Icons.videocam),
      //                   title: new Text('Video'),
      //                   onTap: () {
      //                     Navigator.pop(context);
      //                   },
      //                 ),
      //                 ListTile(
      //                   leading: new Icon(Icons.share),
      //                   title: new Text('Share'),
      //                   onTap: () {
      //                     Navigator.pop(context);
      //                   },
      //                 ),
      //               ],
      //             );
      //           });
      //     }),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SamplePage(),
        // DraggableSheet()
      ],
    );
  }
}
