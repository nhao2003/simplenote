import 'dart:io';
import 'package:todoapp/model/note.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/widgets/note_list.dart';
import 'package:todoapp/widgets/add_todo.dart';

final List<Note> userNotesList = [];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    void _addNewNote() {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) {
              setState(() {

              });
              return AddNote(
                listNote: userNotesList,
              );
            }
          ),
      );
    }

    return Scaffold(
      drawer: Drawer(
          child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          const UserAccountsDrawerHeader(
            accountEmail: Text("nhathaodev@gmail.com"),
            accountName: Text("Nhật Hào"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://gamek.mediacdn.vn/133514250583805952/2021/3/10/-1615363324787806370969.jpg'),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage('https://i.imgur.com/oIC7W51.png'),
                  fit: BoxFit.fill),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.restore_from_trash,
              color: Colors.black,
            ),
            title: const Text('Trash'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
              color: Colors.black,
            ),
            title: const Text('Setting'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.exit_to_app,
              color: Colors.black,
            ),
            title: const Text('Exit'),
            onTap: () {
              exit(0);
            },
          )
        ],
      )),
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
              setState(() {});
            },
            icon: const Icon(Icons.restart_alt_sharp),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                userNotesList.clear();
              });
            },
            icon: const Icon(
              Icons.restart_alt,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          NotesList(userNotesList),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewNote,
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.edit,
          color: Colors.black,
        ),
      ),
    );
  }
}
