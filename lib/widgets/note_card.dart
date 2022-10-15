import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/screens/add_note_screen.dart';

import '../model/note.dart';

class NoteCard extends StatelessWidget {
  final Note? _note;
  Function _moveToTrash;

  //final Function _deleteNote;
  NoteCard(this._note, this._moveToTrash, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shadowColor: Colors.black,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNote(
                newNote: _note,
                moveToTrash: _moveToTrash,
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          margin: const EdgeInsets.all(10),
          width: double.infinity,
          child: Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                trailing: IconButton(
                  onPressed: () {
                    if (_note != null) _moveToTrash(_note);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.black,
                  ),
                ),
                title: Text(
                  _note!.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      overflow: TextOverflow.ellipsis),
                ),
                subtitle: Text(
                  DateFormat.yMMMd().format(_note!.date).toString(),
                  style: const TextStyle(
                      fontSize: 15, fontStyle: FontStyle.italic),
                ),
              ),
              Flexible(
                child: Container(
                  alignment: Alignment.topLeft,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Text(
                      _note!.content,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
