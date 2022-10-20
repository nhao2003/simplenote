import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/model/note.dart';
import 'package:todoapp/screens/home_screen.dart';
import 'package:todoapp/widgets/note_card.dart';
import 'package:todoapp/model/notes.dart';

class NotesList extends StatefulWidget {
  const NotesList({super.key});

  @override
  State<NotesList> createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  void _moveToTrash(String noteID) {
      Provider.of<Notes>(context).moveToTrash(noteID);
  }

  @override
  Widget build(BuildContext context) {
    int screenWidth = MediaQuery.of(context).size.width ~/ 250;
    return ListView.builder(
      controller: HomeScreen.controller,
      itemCount: Provider.of<Notes>(context).NotesList.length,
      itemBuilder: (BuildContext context, int index) {
        return NoteCard(Provider.of<Notes>(context, listen: false).NotesList[index]);
      },
    );
  }
}
