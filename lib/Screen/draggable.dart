import 'package:flutter/material.dart';

import '../AddTask.dart';
import '../constrant.dart';

class DraggableSheet extends StatefulWidget {
  @override
  _DraggableSheetState createState() => _DraggableSheetState();
}

class _DraggableSheetState extends State<DraggableSheet> {
  @override
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      minChildSize: 0.03,
      maxChildSize: 1,
      builder: (BuildContext context, ScrollController scrollController) {
        return Stack(
          children: [
            SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  // title: Text('exit'),
                  centerTitle: true,
                  actions: [
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          // _isDark = !_isDark;
                        });
                      },
                      child: Icon(
                        Icons.menu,
                        size: 40,
                      ),
                    )
                  ],
                ),
                body: Container(
                  decoration: BoxDecoration(
                    // color: Colors.orange,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                    ),
                  ),
                  child: ReorderableListView(
                    scrollController: scrollController,
                    buildDefaultDragHandles: false,
                    children: <Widget>[
                      for (int index = 0; index <= item.length; index++)
                        index != item.length
                            ? index == 0
                                ? Column(
                                    key: Key('$index'),
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      //rowBar(),
                                      rList(index)
                                    ],
                                  )
                                : rList(index)
                            : item.length == 0
                                ? Column(
                                    key: Key('$index'),
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      //rowBar(),
                                      Container(
                                        key: Key('$index'),
                                        // color: item[index].isOdd ? oddItemColor : evenItemColor,
                                        child: Row(
                                          children: <Widget>[rAddTask(index)],
                                        ),
                                      )
                                    ],
                                  )
                                : rAddTask(index),
                    ],
                    onReorder: (int oldIndex, int newIndex) {
                      setState(() {
                        if (oldIndex < newIndex) {
                          newIndex -= 1;
                        }
                        final i = item.removeAt(oldIndex);
                        item.insert(newIndex, i);
                      });
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    //  buttomSheet() {

    //   }
  }

  Widget rAddTask(index) {
    return Container(
      key: Key('$index'),
      // color: item[index].isOdd ? oddItemColor : evenItemColor,
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFFFF0067),
              // color: Colors.orange,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
                // topRight: Radius.circular(15.0),
              ),
            ),
            child: FlatButton(
                child: Row(
                  children: [
                    Icon(Icons.add, size: 25),
                    SizedBox(width: 10),
                    Text(
                      "Add Task",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                onPressed: () {
                  setState(() {
                    item.add(AddTask());
                    for (int index = 0; index < item.length; index++) {
                      print(
                          "$index ${item[index].getMarkedDone()} ${item[index].getTask()}");
                    }
                  });
                }),
          ),
        ],
      ),
    );
  }

  Widget rowBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 50,
          height: 5,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget rList(int index) {
    // index -= 1;
    final productName = item[index];
    return Dismissible(
      key: ValueKey(productName),
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
          key: ValueKey(productName),
          // color: item[index].isOdd ? Colors.yellowAccent : Colors.greenAccent,
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                // width: 64,
                height: 64,
                // padding: const EdgeInsets.all(8),
                margin: EdgeInsets.only(left: 8),
                child: ReorderableDragStartListener(
                  index: index,
                  child: Icon(
                    Icons.drag_indicator_rounded,
                  ),
                ),
              ),
              Checkbox(
                value: item[index].getMarkedDone(),
                // splashRadius: 10,
                onChanged: (value) {
                  setState(() {
                    item[index].ismarkedDone(value!);
                    // ticked = value!;
                  });
                },
              ),
              Expanded(
                child: Container(
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    minLines: 1, //Normal textInputField will be displayed
                    maxLines: 10, // when user presses enter it will adapt to it
                    onChanged: (value) {
                      print(value);
                      item[index].addTask(value);

                      //Do something with the user input.
                    },
                    decoration: new InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15),
                        hintText: "Add task here"),
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
