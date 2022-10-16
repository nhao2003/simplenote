import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/model/note.dart';
import 'package:todoapp/screens/home_screen.dart';

import '../model/user.dart';

class AddNote extends StatelessWidget {
  static const String routeName = 'addNote_Screen';
  String noteID;
  final Function? moveToTrash;

  AddNote({this.noteID = "", this.moveToTrash});

  void _submitNote(BuildContext context, String title, String content) {
    if(noteID.isNotEmpty){
      int i = User.NotesList.indexWhere((element) => element.id == noteID);
      User.NotesList[i].title = title;
      User.NotesList[i].content = content;
      User.NotesList[i].date = DateTime.now();
    }
    if (title.isEmpty && content.isEmpty) {
      Navigator.pop(context);
    } else if (title.isEmpty) {
      Navigator.pop(context, Note('No title', content));
    } else {
      Navigator.pop(context, Note(title, content));
    }
  }

  final titleController = TextEditingController();

  final contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (noteID.isNotEmpty) {
      Note newNote = User.NotesList.firstWhere((element) => element.id == noteID);
      titleController.text = newNote.title;
      contentController.text = newNote.content;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actionsIconTheme: const IconThemeData(color: Colors.black),
        actions: [
          if (noteID.isNotEmpty)
            IconButton(
              onPressed: () {
                moveToTrash!(noteID);
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.delete,
              ),
            ),
          IconButton(
            onPressed: () {
              _submitNote(
                  context, titleController.text, contentController.text);
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              //title
              TextFormField(
                controller: titleController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                decoration: const InputDecoration(
                  hintText: "Enter title",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              TextField(
                autocorrect: true,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: contentController,
                style: const TextStyle(fontSize: 16, color: Colors.black),
                decoration: const InputDecoration(
                  hintText: "Enter content",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
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
