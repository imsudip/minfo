import 'package:flutter/material.dart';
import 'package:qoutes/homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minfo',
      theme: ThemeData(
      ),
      home: Homepage(),
    );
  }
}
