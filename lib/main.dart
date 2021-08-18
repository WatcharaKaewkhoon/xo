import 'package:flutter/material.dart';
import 'package:xo/Pages/home.dart';


void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: home(),
    );
  }
}
