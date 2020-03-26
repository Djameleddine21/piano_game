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
  int score = 0;

  static List<Note> initNotes() {
    return [
      Note(0, 0),
      Note(1, 1),
      Note(2, 2),
      Note(3, 1),
      Note(4, 3),
      Note(5, 0),
      Note(6, 2),
      Note(7, 3),
      Note(8, 2),
      Note(9, 1),
      Note(10, 0),
      Note(11, 2),
      Note(12, 1),
      Note(13, 0),
      Note(14, 3),
      Note(15, 1),
      Note(16, 0),
      Note(17, 2),
      Note(18, 1),
      Note(19, 3),
      Note(20, 2),
      Note(21, 0),
      Note(22, 1),
      Note(23, 3),
      Note(24, 2),
      Note(25, 1),
      Note(26, 0),
      Note(27, 3),
      Note(28, 1),
      Note(29, 0),
      Note(30, 2),
      Note(31, 3),
      Note(32, 1),
      Note(33, 2),
      Note(34, 0),
      Note(35, 1),
      Note(36, 3),
      Note(37, 1),
      Note(38, 0),
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
        if (currentNoteIndex == notes.length - 5) {
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
        currentNotes: notes.sublist(currentNoteIndex, currentNoteIndex + 5),
        animation: animationController,
        onTileTap: _onTap,
      ),
    );
  }

  void _onTap(Note note) {
    setState(() {
      note.state = NoteState.tapped;
      score++;
    });
  }

  _drawScore() {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Text(
          "$score",
          style: TextStyle(
            color: Colors.orangeAccent,
            fontSize: 50.0,
          ),
        ),
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
            _drawScore(),
          ],
        ),
      ),
    );
  }
}
