// import 'package:flutter/material.dart';

// class AddTask extends StatefulWidget {
//   @override
//   _AddTaskState createState() => _AddTaskState();
// }

// class _AddTaskState extends State<AddTask> {
//   bool ticked = false;
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           margin: EdgeInsets.only(top: 12),
//           child: Icon(
//             Icons.drag_indicator_rounded,
//           ),
//         ),
//         Checkbox(
//           value: ticked,
//           // splashRadius: 10,
//           onChanged: (value) {
//             setState(() {
//               ticked = value!;
//             });
//           },
//         ),
//         Expanded(
//           child: Container(
//             child: TextFormField(
//               keyboardType: TextInputType.multiline,
//               minLines: 1, //Normal textInputField will be displayed
//               maxLines: 10, // when user presses enter it will adapt to it
//               onChanged: (value) {
//                 print(value);
//                 //Do something with the user input.
//               },
//               decoration: new InputDecoration(
//                   border: InputBorder.none,
//                   focusedBorder: InputBorder.none,
//                   enabledBorder: InputBorder.none,
//                   errorBorder: InputBorder.none,
//                   disabledBorder: InputBorder.none,
//                   contentPadding:
//                       EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
//                   hintText: "Hint here"),
//             ),
//           ),
//         ),

//         // TextFormField(
//         //   autovalidateMode: AutovalidateMode.always,
//         //   decoration: const InputDecoration(
//         //     icon: Icon(Icons.person),
//         //     hintText: 'What do people call you?',
//         //     labelText: 'Name *',
//         //   ),
//         //   onChanged: (value) {
//         //     print(value);
//         //     // This optional block of code can be used to run
//         //     // code when the user saves the form.
//         //   },
//         //   // validator: (value) {
//         //   //   return value.contains('@') ? 'Do not use the @ char.' : null;
//         //   // },
//         // )
//         // TextField(
//         //   onChanged: (text) {
//         //     print("First text field: $text");
//         //   },
//         // ),
//         // Container(
//         //   color: Colors.pink,
//         //   height: 10,
//         //   width: 60,
//         // )
//       ],
//     );
//   }
// }

// import 'package:flutter/material.dart';

class AddTask {
  String task = "Add task here";
  bool isDone = false;

  // AddTask(this.task);

  void ismarkedDone(bool marked) {
    this.isDone = marked;
  }

  void addTask(String task) {
    this.task = task;
  }

  bool getMarkedDone() {
    return this.isDone;
  }

  String getTask() {
    return this.task;
  }
}
