import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/model/note.dart';
import 'package:todoapp/screens/home_screen.dart';

import '../model/notes.dart';

class AddNote extends StatelessWidget {
  static const String routeName = 'addNote_Screen';
  String noteID;

  AddNote({this.noteID = ""});

  void _submitNote(BuildContext context, String title, String content) {
    List<Note> listNote = Provider.of<Notes>(context, listen: false).NotesList;
    if(noteID.isNotEmpty){
      int i = listNote.indexWhere((element) => element.id == noteID);
      listNote[i].title = title;
      listNote[i].content = content;
      listNote[i].date = DateTime.now();
    }
    if (title.isEmpty && content.isEmpty) {
      Navigator.pop(context);
    } else if (title.isEmpty) {
      Navigator.pop(context, {'title': 'No title','content': content});
    } else {
      Navigator.pop(context, {'title': title,'content': content});
    }
  }

  final titleController = TextEditingController();

  final contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (noteID.isNotEmpty) {
      Note newNote = Provider.of<Notes>(context, listen: false).NotesList.firstWhere((element) => element.id == noteID);
      titleController.text = newNote.title;
      contentController.text = newNote.content;
    }
    var provider = Provider.of<Notes>(context);
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
                provider.moveToTrash(noteID);
                Navigator.of(context).pop((){});
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
