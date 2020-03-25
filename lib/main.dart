import 'package:flutter/material.dart';
import 'package:piano_game/pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Piano Game',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}