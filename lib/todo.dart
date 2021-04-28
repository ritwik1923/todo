import 'package:flutter/material.dart';
import 'package:todo/constrant.dart';
import 'AddTask.dart';
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
        title: Text("Todo"),
        actions: [
          Icon(
            Icons.menu,
            size: 40,
          )
        ],
      ),
      body: TodoList(),
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
    return Stack(
      children: [
        DraggableScrollableSheet(
          initialChildSize: 1,
          minChildSize: 0.03,
          maxChildSize: 1.0,
          builder: (BuildContext context, ScrollController scrollController) {
            return Stack(
              children: [
                Scaffold(
                  body: Container(
                    decoration: BoxDecoration(
                      color: Colors.orange,
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
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                        ),
                                        rList(index)
                                      ],
                                    )
                                  : rList(index)
                              : Container(
                                  key: Key('$index'),
                                  // color: item[index].isOdd ? oddItemColor : evenItemColor,
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        color: Colors.pink,
                                        padding: const EdgeInsets.all(8),
                                        child: FlatButton(
                                            child: Row(
                                              children: [
                                                Icon(Icons.add, size: 25),
                                                SizedBox(width: 10),
                                                Text(
                                                  "Add Task",
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                ),
                                              ],
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                item.add(AddTask());
                                                for (int index = 0;
                                                    index < item.length;
                                                    index++) {
                                                  print(
                                                      "$index ${item[index].getMarkedDone()} ${item[index].getTask()}");
                                                }
                                              });
                                            }),
                                      ),
                                    ],
                                  ),
                                )
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

                  // ReorderableListView.builder(
                  //     header: Container(
                  //       height: 15,
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: <Widget>[
                  //           Container(
                  //             width: 50,
                  //             height: 5,
                  //             decoration: BoxDecoration(
                  //                 color: Colors.grey[300],
                  //                 borderRadius: BorderRadius.all(
                  //                     Radius.circular(12.0))),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     // padding: EdgeInsets.only(top: 20),
                  //     scrollController: scrollController,
                  //     itemCount: item.length,
                  //     itemBuilder: (context, index) {
                  //       final Widget productName = item[index];
                  //       // bool ticked = false;
                  //       print("index: $index");
                  //       if (index == item.length - 1) {
                  //         return ListTile(
                  //           key: ValueKey(productName),
                  //           title: productName,
                  //           onTap: () {/* Do something else */},
                  //         );
                  //       }
                  //       return Dismissible(
                  //         background: slideRightBackground(),
                  //         secondaryBackground: slideLeftBackground(),
                  //         confirmDismiss: (direction) async {
                  //           if (direction == DismissDirection.endToStart) {
                  //             // final bool res =
                  //             await showDialog(
                  //                 context: context,
                  //                 builder: (BuildContext context) {
                  //                   return AlertDialog(
                  //                     content: Text(
                  //                         "Are you sure you want to delete ${index + 1}?"),
                  //                     actions: <Widget>[
                  //                       FlatButton(
                  //                         child: Text(
                  //                           "Cancel",
                  //                           style: TextStyle(
                  //                               color: Colors.black),
                  //                         ),
                  //                         onPressed: () {
                  //                           Navigator.of(context).pop();
                  //                         },
                  //                       ),
                  //                       FlatButton(
                  //                         child: Text(
                  //                           "Delete",
                  //                           style:
                  //                               TextStyle(color: Colors.red),
                  //                         ),
                  //                         onPressed: () {
                  //                           // TODO: Delete the item from DB etc..
                  //                           setState(() {
                  //                             item.removeAt(index);
                  //                           });
                  //                           Navigator.of(context).pop();
                  //                         },
                  //                       ),
                  //                     ],
                  //                   );
                  //                 });
                  //             // print(res);
                  //             // return res;
                  //           } else {
                  //             // TODO: Navigate to edit page;
                  //           }
                  //         },
                  //         key: ValueKey(productName),
                  //         // elevation: 1,
                  //         // margin: const EdgeInsets.all(10),
                  //         child: InkWell(
                  //           onTap: () {
                  //             print("${item[index]} clicked");
                  //           },
                  //           child: ListTile(
                  //             title: productName,
                  //             onTap: () {/* Do something else */},
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //
                  //     // The reorder function
                  //     onReorder: (oldIndex, newIndex) {
                  //       print(
                  //           "old: $oldIndex ; new: $newIndex ; ${item.length}");
                  //       if (newIndex == item.length) newIndex -= 1;
                  //       if (oldIndex < item.length - 1) {
                  //         setState(() {
                  //           if (newIndex > oldIndex) {
                  //             newIndex = newIndex - 1;
                  //           }
                  //           final element = item.removeAt(oldIndex);
                  //           item.insert(newIndex, element);
                  //         });
                  //       }
                  //     }),
                  //
                ),
              ],
            );
          },
        )
      ],
    );
  }

  Widget rList(int index) {
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
            children: <Widget>[
              Container(
                // width: 64,
                height: 64,
                padding: const EdgeInsets.all(8),
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

              // Container(
              //   child: productName,
              // ),
              // Container(
              //   child: item[index],
              // )
              // item[index],
              // productName,
              // Row(
              //   children: [
              //     Text('Item $index'),
              //     Text('Item $index'),
              //     Text('Item $index'),
              //   ],
              // ),
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

  bool _keyboardIsVisible() {
    print((MediaQuery.of(context).viewInsets.bottom == 0.0));
    return (MediaQuery.of(context).viewInsets.bottom == 0.0);
  }
}
