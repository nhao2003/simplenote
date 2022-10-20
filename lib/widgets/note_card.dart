import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/screens/add_note_screen.dart';

import '../model/note.dart';
import '../model/notes.dart';

class NoteCard extends StatelessWidget {
  late Note _note;

  //final Function _deleteNote;
  NoteCard(this._note, {super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Notes>(context);
    return OpenContainer(
      closedElevation: 0,
      openElevation: 0,
      openBuilder:
          (BuildContext context, void Function({Object? returnValue}) action) {
        return AddNote(
          noteID: _note.id,
        );
      },
      closedBuilder: (BuildContext context, void Function() action) {
        return GestureDetector(
          onLongPress: () {
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setModalState) {
                    return Container(
                      height: 125,
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Do you want to delete this note?',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll<Color>(
                                          Colors.white),
                                ),
                                onPressed: () {
                                  provider.moveToTrash(_note.id);
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.black,
                                ),
                                label: const Text(
                                  "Delete",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              ElevatedButton.icon(
                                style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll<Color>(
                                          Colors.white),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.cancel, color: Colors.black,),
                                label: const Text("Cancel", style: TextStyle(color: Colors.black),),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
            //color: Colors.grey,
            margin: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(
                    _note.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        overflow: TextOverflow.ellipsis),
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(_note.date).toString(),
                    style: const TextStyle(
                        fontSize: 15, fontStyle: FontStyle.italic),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    _note.content,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
