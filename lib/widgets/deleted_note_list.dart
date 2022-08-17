import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/widgets/note_list.dart';

import '../model/note.dart';
class DeletedNoteList extends StatefulWidget {
  final List<Note> deletedNoteList;
  final Function restoreToUserList;
  const DeletedNoteList({Key? key, required this.deletedNoteList, required this.restoreToUserList}) : super(key: key);

  @override
  State<DeletedNoteList> createState() => _DeletedNoteListState();
}

class _DeletedNoteListState extends State<DeletedNoteList> {
  void _restoreNote(Note note) {
    setState(() {
      widget.restoreToUserList(note);
      widget.deletedNoteList.removeWhere((element) => element == note);
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
            IconButton(onPressed: (){}, icon: const Icon(Icons.restore))
        ],
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
                itemCount: widget.deletedNoteList.length,
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
                          onPressed: () => _restoreNote(widget.deletedNoteList[index]),
                          icon: const Icon(
                            Icons.restore_from_trash,
                            color: Colors.black,
                          ),
                        ),
                        title: Text(
                          widget.deletedNoteList[index].title,
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
                                  .format(widget.deletedNoteList[index].date)
                                  .toString(),
                              style: const TextStyle(
                                  fontSize: 15, fontStyle: FontStyle.italic),
                            ),
                            Text(
                              widget.deletedNoteList[index].content,
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
