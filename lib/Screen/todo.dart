import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../constrant.dart';
import 'background.dart';
import 'dart:math' as math;

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
    return SingleChildScrollView(
      child: Column(
        children: [
          SamplePage(),
          // DraggableSheet()
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => math.max(maxHeight, minHeight);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class CollapsingList extends StatelessWidget {
  SliverPersistentHeader makeHeader(String headerText) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: 75.0,
        maxHeight: 180.0,
        child: Container(
            color: Color(0xFFFFA012),
            child: Center(
                child: Text(
              headerText,
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height;
    double graphHeight = size * 0.21;

    return Stack(
      children: [
        Container(
          child: Column(
            children: [
              Container(
                height: size * 0.3,
                color: Color(0xFFFFA012),
              ),
              Container(
                height: size * 0.7,
                color: Color(0xFF141438),
              )
            ],
          ),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: CustomScrollView(
              slivers: <Widget>[
                makeHeader('Todo'),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      ConstrainedBox(
                        // TODO: prevent overlayer of widget
                        constraints: BoxConstraints(
                            minHeight: 266, maxHeight: 350, maxWidth: 250),
                        child: Container(
                          height: graphHeight * 1.56,
                          decoration: BoxDecoration(
                            color: Color(0xFF272B4C),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.only(
                                top: 15.0, left: 15, right: 15),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${(kScore * 10).toStringAsPrecision(3)}%",
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30.0),
                                    ),
                                    new CircularPercentIndicator(
                                      radius: 75.0,
                                      lineWidth: 15.0,
                                      animation: true,
                                      percent: kScore,
                                      // center: new Text(
                                      //   "${(kScore * 10).toStringAsPrecision(3)}%",
                                      //   style: new TextStyle(
                                      //       fontWeight: FontWeight.bold, fontSize: 35.0),
                                      // ),
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                      progressColor: Color(0xFF026FE7),
                                      backgroundColor: Color(0xFF868686),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  child: Divider(
                                    thickness: 4,
                                    indent: 20,
                                    endIndent: 20,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    print(
                                        "progress page open ${MediaQuery.of(context).size.width}");
                                  },
                                  child: Text(
                                    "Progress",
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25.0),
                                  ),
                                ),
                                SizedBox(
                                  height: (graphHeight * 1.56 - (15 * 2)) *
                                      0.085, //20
                                ),
                                GestureDetector(
                                  onTap: () {
                                    print(
                                        "Plan tom page open ${graphHeight * 1.56} ${(graphHeight * 1.56 - (15 * 2)) * 0.085}");
                                  },
                                  child: Text(
                                    "Plan Tommorow",
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25.0),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      (graphHeight * 1.56 - (15 * 2)) * 0.085 +
                                          0, //45
                                ),
                                SizedBox(
                                  // height: 50,
                                  child: Divider(
                                    thickness: 4,
                                    indent: 20,
                                    endIndent: 20,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: GestureDetector(
                                    onTap: () {
                                      print("View more");
                                    },
                                    child: Text(
                                      "View More",
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: graphHeight,
                        decoration: BoxDecoration(
                          color: Color(0xFF272B4C),
                          // color: Colors.orange,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size * .5,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
