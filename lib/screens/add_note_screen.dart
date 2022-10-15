import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/model/note.dart';
import 'package:todoapp/screens/home_screen.dart';

class AddNote extends StatelessWidget {
  static const String routeName = 'addNote_Screen';
  Note? newNote;
  final Function? moveToTrash;

  AddNote({this.newNote, this.moveToTrash});

  void _submitNote(BuildContext context, String title, String content) {
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
    if (newNote != null) {
      titleController.text = newNote!.title;
      contentController.text = newNote!.content;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actionsIconTheme: const IconThemeData(color: Colors.black),
        actions: [
          if (newNote != null)
            IconButton(
              onPressed: () {
                if (newNote != null) {
                  moveToTrash!(newNote);
                }
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
        child: Flexible(
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
      ),
    );
  }
}
