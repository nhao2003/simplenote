import 'package:flutter/material.dart';
import 'package:todoapp/model/note.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/widgets/home_screen.dart';
import 'package:todoapp/widgets/add_todo.dart';
class NotesList extends StatelessWidget {
  final List<Note> listNotes;

  NotesList(this.listNotes);
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
          itemCount: listNotes.length,
          itemBuilder: (ctx, index) {
            return Card(
              elevation: 3,
              shadowColor: Colors.black,
                child: GestureDetector(
                  onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AddNote(listNote: listNotes, newNote: listNotes[index],),
                          )
                      );
                    },

                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    margin: const EdgeInsets.all(10),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          listNotes[index].title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          DateFormat.yMMMd().format(listNotes[index].date).toString(),
                          style: const TextStyle(
                            fontSize: 15,
                            fontStyle: FontStyle.italic
                          ),
                        ),
                        Text(
                          listNotes[index].content,
                          style: const TextStyle(
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
