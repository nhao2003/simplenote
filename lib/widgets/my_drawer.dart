import 'dart:io';

import 'package:flutter/material.dart';

import '../screens/deleted_note_screen.dart';

class MyDrawer extends StatelessWidget {
  final Function _addNewNote;
  final Function _restoreAllNote;
  MyDrawer(this._addNewNote, this._restoreAllNote, {super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
            Icons.delete,
            color: Colors.black,
          ),
          title: const Text('Trash'),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DeletedNoteScreen(_addNewNote, _restoreAllNote)));
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
    ));
  }
}
