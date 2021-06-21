import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/Screen/main_Screen.dart';
import 'package:todo/Screen/HomeScreen.dart';
import 'package:todo/constrant.dart';

class SplashScreen extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              child: Column(
                children: [
                  Expanded(
                    // flex: 3,
                    child: Container(
                      // height: size * 0.3,
                      color: Color(0xFFFFA012),
                      // TODO: bettor looking looding screen
                      // decoration: BoxDecoration(
                      //     gradient: LinearGradient(
                      //         begin: Alignment.topCenter,
                      //         end: Alignment.bottomCenter,
                      //         colors: [
                      //       Color(0xFFFFA012),
                      //       // Color(0xFF141438),
                      //       // Color(0xFF141438),
                      //       // Color(0xFF141438),
                      //     ])),

                      //  Color(0xFFFFA012),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 120,
              right: 0.0,
              left: 0.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      child: Hero(
                          tag: "Todotag",
                          child: Text(
                            'TODO',
                            style: kTodoStyle,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
