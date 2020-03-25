import 'package:flutter/material.dart';
import 'package:piano_game/model/Note.dart';

class Tile extends StatelessWidget {
  final NoteState state;
  final double height;

  Tile({Key key, this.height, this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: Container(color: color),
    );
  }

  Color get color {
    switch (state) {
      case NoteState.missed : return Colors.red;
      case NoteState.ready : return Colors.blueAccent;
      case NoteState.tapped : return Colors.transparent;
      default: return Colors.blueAccent;
    }
  }
}
