import 'package:provider/provider.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:todoapp/model/note.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/widgets/my_drawer.dart';
import 'package:todoapp/widgets/note_list.dart';
import 'package:todoapp/screens/add_note_screen.dart';
import 'package:todoapp/model/notes.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen();

  static final controller = ScrollController();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {


    void _startAddNewNote() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (contex) => AddNote()),
      ).then((value) {
        if (value != null) {
          Provider.of<Notes>(context, listen: false).addNewNote(value['title'], value['content']);
        }
        setState(() {});
      });
    }

    return Scaffold(
      drawer: MyDrawer(),
      appBar: ScrollAppBar(
        title: const Text(
          'All notes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<Notes>(context, listen: false).clear();
            },
            icon: const Icon(
              Icons.restart_alt,
              color: Colors.black,
            ),
          ),
        ],
        controller: HomeScreen.controller,
      ),
      body: NotesList(),
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
