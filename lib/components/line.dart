import 'package:flutter/material.dart';
import 'package:piano_game/components/tile.dart';
import 'package:piano_game/model/Note.dart';

class Line extends AnimatedWidget {
  final int lineIndex;
  final List<Note> currentNotes;
  final Function(Note note) onTileTap;

  const Line(
      {Key key, this.lineIndex, this.currentNotes, Animation<double> animation , this.onTileTap})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    Animation<double> animation = super.listenable;
    double tileHeight = MediaQuery.of(context).size.height / 4;

    List<Note> lineNotes =
        currentNotes.where((note) => note.line == this.lineIndex).toList();

    List<Widget> tiles = lineNotes.map((note) {
      int index = currentNotes.indexOf(note);
      double offset = (3 - index) * tileHeight;
      return Transform.translate(
        offset: Offset(3 - index + animation.value, offset),
        child: Tile(
          height: tileHeight,
          state: note.state,
          onTap: () => onTileTap(note),
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
