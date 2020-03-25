import 'package:flutter/material.dart';
import 'package:piano_game/components/tile.dart';
import 'package:piano_game/model/Note.dart';

class Line extends StatelessWidget {
  final int lineIndex;
  final List<Note> currentNotes;

  const Line({Key key, this.lineIndex, this.currentNotes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double tileHeight = MediaQuery.of(context).size.height / 4;

    List<Note> lineNotes =
        currentNotes.where((note) => note.line == this.lineIndex).toList();

    List<Widget> tiles = lineNotes.map((note) {
      int index = currentNotes.indexOf(note);
      double offset = (3 - index) * tileHeight;
      return Transform.translate(
        offset: Offset(0, offset),
        child: Tile(
          height: tileHeight,
          state: note.state,
        ),
      );
    }).toList();

    return SizedBox.expand(
      child: Stack(
        children: tiles,
      ),
    );
  }

}
