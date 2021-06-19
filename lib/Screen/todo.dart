import 'dart:math';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:todo/chart/graph.dart';
import 'package:todo/database/db_helper.dart';
import '../model/AddTask.dart';
import '../constrant.dart';
// import 'Barchart.dart';
// import 'background.dart';
import 'dart:math' as math;
import 'package:charts_flutter/flutter.dart' as charts;

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  double hh = 10;

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
  var random = new Random();

  SliverPersistentHeader makeHeader(String headerText) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: 75.0,
        maxHeight: 180.0,
        child: Container(
            color: Color(0xFFFFA012),
            child: Center(child: Text(headerText, style: kTodoStyle))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height;
    double graphHeight = size * 0.21;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    // height: size * 0.3,
                    color: Color(0xFFFFA012),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Container(
                    // height: size * 0.6,
                    color: Color(0xFF141438),
                  ),
                )
              ],
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: CustomScrollView(
                slivers: <Widget>[
                  // Hero(tag: "Todotag", child: makeHeader('Todo')),
                  //  TODO: add hero animation
                  makeHeader('Todo'),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Container(
                          child: IconButton(
                            onPressed: () async {
                              print(
                                  "---------------------------------------------------------------");
                              DB_Helper db = DB_Helper();
                              List<StoreTask> Todos = await db.getTodos();
                              for (int i = 0; i < Todos.length; i++) {
                                var storeddata = Todos[i];
                                print(
                                    "${storeddata.dateTime}: ${storeddata.alltask} , ${storeddata.score}");
                              }
                              print(
                                  "---------------------------------------------------------------");
                            },
                            icon: const Icon(Icons.android),
                          ),
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                              minHeight: 266, maxHeight: 350, maxWidth: 250),
                          child: Container(
                            height: graphHeight * 1.86,
                            decoration: BoxDecoration(
                              color: Color(0xFF272B4C),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                            ),
                            child: detailWidget(graphHeight),
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
                          child: Graph(),
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
      ),
    );
  }

  Widget detailWidget(double graphHeight) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 10.0,
            right: 0.0,
            left: 0.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${(kScore * 10).toStringAsPrecision(3)}",
                          style: kTextStyle(30),
                        ),
                        Text(
                          "${ktaskdone == ktotaltask && ktotaltask != 0 ? "All done" : ktotaltask == 0 ? "New day New Start" : "Still ${(ktotaltask - ktaskdone)} left out of $ktotaltask tasks to goal"}",
                          style: new TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 15.0),
                        ),
                      ],
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
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Color(0xFFFFA012), //Color(0xFF026FE7),
                      backgroundColor: Color(0xFF868686),
                    ),
                  ],
                ),
                Divider(
                  thickness: 2,
                  indent: 20,
                  endIndent: 20,
                ),
                rTilelist(
                  avatarColor: Color(0xFF399500),
                  image: 'assets/images/progress.png',
                  text: klable1,
                  subtext: ksubtext1,
                  onPress: () {},
                ),
                rTilelist(
                  avatarColor: Color(0xFFFFA012),
                  image: 'assets/images/future.png',
                  text: klable2,
                  subtext: ksubtext2,
                  onPress: () {},
                ),
              ],
            ),
          ),
          Positioned(
              bottom: 5.0,
              right: 0.0,
              left: 0.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Divider(
                    thickness: 2,
                    indent: 20,
                    endIndent: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                        // color: Colors.blue,
                        child: Text(
                      'View More',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

class rTilelist extends StatelessWidget {
  final String text;
  final String subtext;
  final String image;
  final Function onPress;
  final Color avatarColor;

  const rTilelist(
      {@required this.text,
      @required this.avatarColor,
      @required this.subtext,
      @required this.image,
      @required this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Align(
        alignment: Alignment.topLeft,
        child: ListTile(
          // minVerticalPadding: 10,
          contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
          leading: CircleAvatar(
              backgroundColor: avatarColor,
              child: Center(
                child: Image.asset(
                  image,
                  height: 20,
                  width: 20,
                ),
              )),
          title: Text(
            "$text",
            style: kTextStyle(25),
          ),
          subtitle: Text("$subtext", style: kSubTextStyle),
        ),
      ),
    );
  }
}
