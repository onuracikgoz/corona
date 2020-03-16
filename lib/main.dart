import 'package:corona/index.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IndexPage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Bebas',
        textTheme: TextTheme(body1: TextStyle(fontSize: 25.0,color: Colors.white),)
      ),
    );
  }
}
