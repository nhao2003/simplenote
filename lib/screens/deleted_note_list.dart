import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/model/user.dart';

import '../model/note.dart';

class DeletedNoteList extends StatefulWidget {
  final Function _restoreNote;
  final Function _restoreAllNote;

  const DeletedNoteList(
    this._restoreNote,
    this._restoreAllNote,
  );

  @override
  State<DeletedNoteList> createState() => _DeletedNoteListState();
}

class _DeletedNoteListState extends State<DeletedNoteList> {
  void _restoreFromTrash(Note note) {
    setState(() {
      widget._restoreNote(note);
      User.deletedNotesList.remove(note);
    });
  }

  void _restoreAllFromTrash() {
    setState(() {
      widget._restoreAllNote();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actionsIconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  User.deletedNotesList.clear();
                });
              },
              icon: const Icon(Icons.delete_outline_sharp)),
          IconButton(
              onPressed: () {
                _restoreAllFromTrash();
              },
              icon: const Icon(Icons.restore))
        ],
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
                itemCount: User.deletedNotesList.length,
                itemBuilder: (ctx, index) {
                  return Card(
                    elevation: 3,
                    shadowColor: Colors.black,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      margin: const EdgeInsets.all(10),
                      width: double.infinity,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        trailing: IconButton(
                          onPressed: () =>
                              _restoreFromTrash(User.deletedNotesList[index]),
                          icon: const Icon(
                            Icons.restart_alt_outlined,
                            color: Colors.black,
                          ),
                        ),
                        title: Text(
                          User.deletedNotesList[index].title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat.yMMMd()
                                  .format(User.deletedNotesList[index].date)
                                  .toString(),
                              style: const TextStyle(
                                  fontSize: 15, fontStyle: FontStyle.italic),
                            ),
                            Text(
                              User.deletedNotesList[index].content,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 19,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
