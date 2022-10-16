import 'dart:io';
import 'package:todoapp/model/note.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/screens/deleted_note_screen.dart';
import 'package:todoapp/widgets/my_drawer.dart';
import 'package:todoapp/widgets/note_list.dart';
import 'package:todoapp/screens/add_note_screen.dart';
import 'package:todoapp/model/user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    void _addNewNote(Note note) {
      setState(() {
        User.NotesList.insert(0, note);
      });
    }

    void _startAddNewNote() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => AddNote()),
      ).then((value) {
        if (value != null) {
          _addNewNote(value);
        }
        setState(() {});
      });
    }

    void _restoreAllNote() {
      setState(() {
        User.NotesList.addAll(User.deletedNotesList);
        User.deletedNotesList.clear();
      });
    }

    return Scaffold(
      drawer: MyDrawer(_addNewNote, _restoreAllNote),
      appBar: AppBar(
        title: const Text(
          'All notes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                User.NotesList.clear();
              });
            },
            icon: const Icon(
              Icons.restart_alt,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: NotesList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _startAddNewNote,
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.edit,
          color: Colors.black,
        ),
      ),
    );
  }
}
