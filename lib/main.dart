/// Flutter code sample for ReorderableListView.buildDefaultDragHandles

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final List<int> item = List<int>.generate(7, (int index) => index);

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    return ReorderableListView(
      buildDefaultDragHandles: false,
      children: <Widget>[
        for (int index = 1; index < item.length; index++)
          // if(index == 0)
          // Container(
          //   height: 15,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[
          //       Container(
          //         width: 50,
          //         height: 5,
          //         decoration: BoxDecoration(
          //             color: Colors.grey[300],
          //             borderRadius: BorderRadius.all(Radius.circular(12.0))),
          //       ),
          //     ],
          //   ),
          // )
          if (index != item.length - 1)
            rList(index)
          else
            Container(
              key: Key('$index'),
              color: item[index].isOdd ? oddItemColor : evenItemColor,
              child: Row(
                children: <Widget>[
                  Container(
                    color: Colors.pink,
                    width: 64,
                    height: 64,
                    padding: const EdgeInsets.all(8),
                    // child: ReorderableDragStartListener(
                    //   index: index,
                    //   child: Card(
                    //     color: colorScheme.primary,
                    //     elevation: 2,
                    //   ),
                    // ),
                  ),
                  Text('Item ${item[index]}'),
                ],
              ),
            )
        // }
      ],
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final int i = item.removeAt(oldIndex);
          item.insert(newIndex, i);
        });
      },
    );
  }

  Widget rList(int index) {
    return Dismissible(
      key: ValueKey(item[index]),
      background: slideRightBackground(),
      secondaryBackground: slideLeftBackground(),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          // final bool res =
          await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content:
                      Text("Are you sure you want to delete ${index + 1}?"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                      child: Text(
                        "Delete",
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        // TODO: Delete the item from DB etc..
                        setState(() {
                          item.removeAt(index);
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              });
          // print(res);
          // return res;
        } else {
          // TODO: Navigate to edit page;
        }
      },
      child: InkWell(
        child: Container(
          key: Key('$index'),
          color: item[index].isOdd ? Colors.yellowAccent : Colors.greenAccent,
          child: Row(
            children: <Widget>[
              Container(
                width: 64,
                height: 64,
                padding: const EdgeInsets.all(8),
                child: ReorderableDragStartListener(
                  index: index,
                  child: Card(
                    // color: colorScheme.primary,
                    elevation: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget slideRightBackground() {
    return Container(
      color: Colors.green,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.edit,
              color: Colors.white,
            ),
            Text(
              " Edit",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }
}
