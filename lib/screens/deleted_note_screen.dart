import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/model/notes.dart';

import '../model/note.dart';

class DeletedNoteScreen extends StatefulWidget {
  const DeletedNoteScreen();

  @override
  State<DeletedNoteScreen> createState() => _DeletedNoteScreenState();
}

class _DeletedNoteScreenState extends State<DeletedNoteScreen> {


  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Notes>(context);
    void _restoreFromTrash(Note note) {
      provider.restoreFromTrash(note.id);
    }
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                provider.clear();
              },
              icon: const Icon(Icons.delete_outline_sharp)),
          IconButton(
              onPressed: () {
                provider.restoreAllNote();
              },
              icon: const Icon(Icons.restore))
        ],
      ),
      body: ListView.builder(
          itemCount: provider.DeletedNotesList.length,
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
                        _restoreFromTrash(provider.DeletedNotesList[index]),
                    icon: const Icon(
                      Icons.restart_alt_outlined,
                      color: Colors.black,
                    ),
                  ),
                  title: Text(
                    provider
                        .DeletedNotesList[index]
                        .title,
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
                            .format(provider.DeletedNotesList[index].date)
                            .toString(),
                        style: const TextStyle(
                            fontSize: 15, fontStyle: FontStyle.italic),
                      ),
                      Text(
                        provider.DeletedNotesList[index].content,
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
    );
  }
}
