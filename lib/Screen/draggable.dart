import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo/chart/calender.dart';
import 'package:todo/database/db_helper.dart';

import '../model/AddTask.dart';
import '../constrant.dart';

class DraggableSheet extends StatefulWidget {
  @override
  _DraggableSheetState createState() => _DraggableSheetState();
}

class _DraggableSheetState extends State<DraggableSheet> {
  // Widget build(BuildContext context) {
  //   // TODO: implement build
  //   return Padding(
  //     padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10),
  //     child: DraggableScrollableSheet(
  //       initialChildSize: 1,
  //       minChildSize: 0.00,
  //       maxChildSize: 1,
  //       builder: (BuildContext context, ScrollController scrollController) {
  //         return Stack(
  //           children: [
  //             SafeArea(
  //               child: Scaffold(
  //                 appBar: AppBar(
  //                   title: Text("${MediaQuery.of(context).padding.top}"),
  //                 ),
  //                 body: SafeArea(
  //                   child: Container(
  //                     decoration: BoxDecoration(
  //                       shape: BoxShape.rectangle,
  //                       borderRadius: BorderRadius.only(
  //                         topLeft: Radius.circular(15.0),
  //                         topRight: Radius.circular(15.0),
  //                       ),
  //                     ),
  //                     child: ReorderableListView(
  //                       scrollController: scrollController,
  //                       buildDefaultDragHandles: false,
  //                       children: <Widget>[
  //                         for (int index = 0; index <= item.length; index++)
  //                           index != item.length
  //                               ? rList(index)
  //                               : rAddTask(index),
  //                       ],
  //                       onReorder: (int oldIndex, int newIndex) {
  //                         print("old: $oldIndex ; new: $newIndex");
  //                         // prevent exception
  //                         if (oldIndex < 0 ||
  //                             oldIndex >= item.length ||
  //                             newIndex < 0 ||
  //                             newIndex >= item.length) {
  //                           return;
  //                         }
  //                         setState(() {
  //                           if (oldIndex < newIndex) {
  //                             newIndex -= 1;
  //                           }
  //                           final i = item.removeAt(oldIndex);
  //                           item.insert(newIndex, i);
  //                         });
  //                       },
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ,
  //           ],
  //         );
  //       },
  //     ),
  //   );
  // }
  String _date;
  DB_Helper db = DB_Helper();
  void initState() {
    _date = onlyDay(DateTime.now());

    super.initState();
  }

  List<AddTask> temp;
  double calScore() {
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
    setState(() {
      ktotaltask = item.length;

      if (total == 0) {
        total = 1;
        ktotaltask += 1;
      }
      kScore = score / total;
      kScore = double.parse(kScore.toStringAsPrecision(3));
      print("score: $kScore/$ktaskdone");
    });
    return kScore;
  }

  Future<bool> StoreData() async {
    List<String> data = [];
    for (int i = 0; i < item.length; i++) {
      data.add(jsonEncode(item[i].toMap()));
    }

    // TODO: store data before exit
    String d = "$data";
    print("Storing:  $d");
    // ignore: non_constant_identifier_names
    var STodod = StoreTask(dateTime: _date, alltask: d, score: calScore());
    print("res: $STodod");

    bool res = await db.insertTodo(STodod);
    if (res == true) {
      print("stored!!..");
      return true;
    } else {
      return false;
    }
    // if (_date != formatted) {
    //   item = temp;
    // }
  }
  // adb -d shell "run-as com.example.todo cat /data/data/com.example.todo/databasesTodo.db" > databasesTodo.db

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
            title: Text("Pick Date"),

            //  Row(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     Align(
            //       alignment: Alignment.bottomLeft,
            //       child: GestureDetector(
            //         child: Icon(Icons.arrow_back),
            //         onTap: () {
            //           Navigator.of(context).pop(true);
            //         },
            //       ),
            //     ),
            //     Align(
            //       alignment: Alignment.center,
            //       child: GestureDetector(
            //         child: Text("Pick Date"),
            //         onTap: () {
            //           Navigator.of(context).pop(true);
            //         },
            //       ),
            //     ),
            //   ],
            // ),

            actions: <Widget>[
              TextButton(
                child: const Text('Done'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
            content: SingleChildScrollView(
                child: Expanded(
              child: Container(
                width: 100000,
                // height: 100,
                // color: Colors.pink,
                child: Calender(week_or_month: false),
              ),
            )));
      },
    );
  }

  Future<void> loaddata() async {
    StoreTask storeddata = await db.getTodo(_date);
    if (storeddata != null) {
      print(
          "${storeddata.dateTime}: ${storeddata.alltask} , ${storeddata.score}");

      var x = jsonDecode(storeddata.alltask);
      print(x);
      print("len: ${x.length}");
      item.clear();
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
      print("not data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  // Scaffold.of(context).openDrawer();
                  //   bool res = await StoreData();
                  // print("istored: $res");

                  StoreData().then((value) {
                    // if (_date != formatted) {
                    //   item = temp;
                    // }
                  }).then((value) => Navigator.of(context).pop(true));
                },
                // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          title: GestureDetector(
              onTap: () {
                print("ppressed");
                // Dialog(
                //     child: SingleChildScrollView(
                //         child: Stack(
                //             // crossAxisAlignment: CrossAxisAlignment.start,
                //             children: <Widget>[
                //       Calender(false),
                //     ])));
                // Calender obj = Calender();
                _showMyDialog().then((value) {
                  SendCalenderData scd = SendCalenderData();

                  setState(() {
                    _date = scd.getSeletedDate();
                    loaddata();
                    // if (_date != formatted) {
                    //   temp = item;
                    //   print(temp.length);
                    //   for (int i = 0; i < temp.length; i++) {
                    //     print(
                    //         "${temp[i].getMarkedDone()}: ${temp[i].getTask()} ");
                    //   }
                    //   item.clear();
                    // }
                  });
                });
              },
              child: Text("$_date")),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                // Scaffold.of(context).openDrawer();
                // Navigator.of(context).pop(true);
              },
              // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ],
        ),
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
            ),
            child: ReorderableListView(
              // scrollController: scrollController,
              buildDefaultDragHandles: false,
              children: <Widget>[
                for (int index = 0; index <= item.length; index++)
                  index != item.length ? rList(index) : rAddTask(index),
              ],
              onReorder: (int oldIndex, int newIndex) {
                print("old: $oldIndex ; new: $newIndex");
                // prevent exception
                if (oldIndex < 0 ||
                    oldIndex >= item.length ||
                    newIndex < 0 ||
                    newIndex >= item.length) {
                  return;
                }
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
    );
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
              // color: Color(0xFF272B4C),
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
                    item.add(
                        AddTask(isDone: false, isSubtask: false, task: ""));
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
    final productName = item[index];
    return Dismissible(
      key: ValueKey(productName),
      background: slideRightBackground(),
      secondaryBackground: slideLeftBackground(),
      confirmDismiss: (direction) async {
        // ignore: missing_return
        if (direction == DismissDirection.endToStart) {
          // final bool res =
          return await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  // TODO: improve deleting ui task
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
          return null;
        }
      },
      child: InkWell(
        child: Container(
          key: ValueKey(productName),
          child: Row(
            children: <Widget>[
              Container(
                height: 64,
                margin: EdgeInsets.only(left: 8),
                child: ReorderableDragStartListener(
                  index: index,
                  child: Icon(
                    Icons.drag_indicator_rounded,
                  ),
                ),
              ),
              // TODO: inputing task over here
              Checkbox(
                value: item[index].getMarkedDone() == true ? true : false,
                activeColor: Color(0xFF272B4C),
                // splashRadius: 10,
                onChanged: (value) {
                  setState(() {
                    item[index].ismarkedDone();
                    // ticked = value!;
                  });
                },
              ),
              Expanded(
                child: Container(
                  child: TextFormField(
                    initialValue: item[index].getTask(),
                    keyboardType: TextInputType.multiline,
                    minLines: 1, //Normal textInputField will be displayed
                    maxLines: 10, // when user presses enter it will adapt to it
                    onChanged: (value) {
                      print(value);
                      item[index].addTask(value);

                      //TODO: Do something with the user input.
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

//  actions: <Widget>[
//   TextButton(
//     child: const Text('Approve'),
//     onPressed: () {
//       Navigator.of(context).pop();
//     },
//   ),
// ],
