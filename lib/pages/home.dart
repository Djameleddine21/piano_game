import 'package:flutter/material.dart';
import 'package:piano_game/components/LineDivider.dart';
import 'package:piano_game/components/line.dart';
import 'package:piano_game/model/Note.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  List<Note> notes = initNotes();
  int currentNoteIndex = 0;
  AnimationController animationController;

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
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (currentNoteIndex == notes.length - 4) {
        } else {
          setState(() => currentNoteIndex++);
          animationController.forward(from: 0);
        }
      }
    });
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  _drawLine(int lineNumber) {
    return Expanded(
      child: Line(
        lineIndex: lineNumber,
        currentNotes: notes.sublist(currentNoteIndex, currentNoteIndex + 4),
      ),
    );
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
                _drawLine(0),
                LineDivider(),
                _drawLine(1),
                LineDivider(),
                _drawLine(2),
                LineDivider(),
                _drawLine(3),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
