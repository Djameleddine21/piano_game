import 'package:flutter/material.dart';
import 'package:piano_game/components/LineDivider.dart';
import 'package:piano_game/model/Note.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> notes = initNotes();
  static List<Note> initNotes() {
    return [
      Note(0, 0),
      Note(1, 1),
      Note(2, 2),
      Note(3, 1),
      Note(4, 3),
      Note(5, 0),
      Note(39, 2),
      Note(40, 3),
      Note(41, -1),
      Note(42, -1),
      Note(43, -1),
      Note(44, -1),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: Stack(
          fit: StackFit.passthrough,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.grey,
                  ],
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(child: Container()),
                LineDivider(),
                Expanded(child: Container()),
                LineDivider(),
                Expanded(child: Container()),
                LineDivider(),
                Expanded(child: Container()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
