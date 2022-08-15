import 'package:flutter/material.dart';
import 'package:todoapp/model/note.dart';
import 'package:todoapp/widgets/home_screen.dart';

class AddNote extends StatefulWidget {
  Note? newNote;
  List<Note> listNote;
  AddNote({required this.listNote, this.newNote});
  void _submitNote(String tittle, String content) {
    if (newNote != null) {
      newNote!.title =tittle;
      newNote!.content =content;
      newNote!.date = DateTime.now();
    } else {
      if (tittle.isEmpty && content.isEmpty) {
        return;
      } else if (tittle.isEmpty) {
        listNote.add(
            Note(DateTime.now().toString(), DateTime.now(), 'No title',
                content));
      } else {
        listNote.add(
            Note(DateTime.now().toString(), DateTime.now(), tittle, content));
      }
    }
  }

  @override
  _AddtodoState createState() => _AddtodoState();
}

class _AddtodoState extends State<AddNote> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if(widget.newNote!=null){
      titleController.text = widget.newNote!.title;
      contentController.text = widget.newNote!.content;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actionsIconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () {
              if(widget.newNote!=null) {
                userNotesList.removeWhere((element) => element.id==widget.newNote!.id);
              }
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.delete,
            ),
          ),
          IconButton(
            onPressed: () {
              widget._submitNote(titleController.text,contentController.text);
              setState(() {
                Navigator.of(context).pop();
              });
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: SizedBox(
        height: double.infinity,
        child: Column(
          children: [
            //title
            TextFormField(
              controller: titleController,
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

            TextFormField(
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
    );
  }
}
