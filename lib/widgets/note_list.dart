import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:todoapp/model/note.dart';
import 'package:todoapp/widgets/note_card.dart';
import 'package:todoapp/model/user.dart';

class NotesList extends StatefulWidget {
  const NotesList({super.key});

  @override
  State<NotesList> createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  void _moveToTrash(String noteID) {
    setState(() {
      User.moveToTrash(noteID);
    });
  }

  @override
  Widget build(BuildContext context) {
    int screenWidth = MediaQuery.of(context).size.width ~/ 250;
    return SingleChildScrollView(
      child: Column(
        children: User.NotesList.map((element) => NoteCard(element, _moveToTrash))
            .toList(),
      ),
    );
  }
}
