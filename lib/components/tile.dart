import 'package:flutter/material.dart';
import 'package:piano_game/model/Note.dart';

class Tile extends StatelessWidget {
  final NoteState state;
  final double height;
  final VoidCallback onTap;

  Tile({Key key, this.height, this.state, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: GestureDetector(
        onTapDown: (_) => onTap,
        child: Container(color: color),
      ),
    );
  }

  Color get color {
    switch (state) {
      case NoteState.missed:
        return Colors.red;
      case NoteState.ready:
        return Colors.blueAccent;
      case NoteState.tapped:
        return Colors.transparent;
      default:
        return Colors.blueAccent;
    }
  }
}
