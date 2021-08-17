import 'package:flutter/material.dart';
import 'package:xo/Pages/game.dart';
import 'package:xo/Pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'XO Game',
      home: home(),
      // home: game(size: 3,),
    );
  }
}
