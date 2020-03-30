import 'package:audioplayers/audio_cache.dart';
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
  bool isStarted = false;
  AudioCache _player = AudioCache();
  bool isPlaying = true;

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
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed && isPlaying) {
        if (notes[currentNoteIndex].state != NoteState.tapped) {
          setState(() {
            isPlaying = false;
            notes[currentNoteIndex].state = NoteState.missed;
          });
          animationController.reverse().then((_) => _showFinishDialog());
        } else if (currentNoteIndex == notes.length - 5) {
          //song finished
          _showFinishDialog();
        } else {
          setState(() => ++currentNoteIndex);
          animationController.forward(from: 0);
        }
      }
    });
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
    bool _previousTapped = notes
        .sublist(0, note.orderNumber)
        .every((n) => n.state == NoteState.tapped);
    if (_previousTapped) {
      if (!isStarted) {
        setState(() {
          isStarted = false;
          animationController.forward();
        });
      }
      _playnote(note);
      setState(() {
        note.state = NoteState.tapped;
        score++;
      });
    }
  }

  _playnote(Note note) {
    switch (note.line) {
      case 0:
        _player.play('a.wav');
        return;
      case 1:
        _player.play('c.wav');
        return;
      case 2:
        _player.play('e.wav');
        return;
      case 3:
        _player.play('f.wav');
        return;
    }
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

  void _showFinishDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Score: $score"),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("RESTART"),
            ),
          ],
        );
      },
    ).then((_) => _restart());
  }

  void _restart() {
    setState(() {
      isStarted = false;
      isPlaying = true;
      notes = initNotes();
      score = 0;
      currentNoteIndex = 0;
    });
    animationController.reset();
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
