import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/widgets/note_list.dart';
import 'note.dart';

class Notes with ChangeNotifier{
  final List<Note> _notesList = [
    Note('Hello world', 'Welcome to my note app <3'),
    Note('Hello world', 'Welcome to my note app <3'),
    Note('Hello world', 'Welcome to my note app <3'),
    Note('Hello world', 'Welcome to my note app <3'),
    Note('Hello world', 'Welcome to my note app <3'),
    Note('Hello world', 'Welcome to my note app <3'),
    Note('Hello world', 'Welcome to my note app <3'),
    Note('Hello world', 'Welcome to my note app <3'),
    Note('Hello world', 'Welcome to my note app <3'),
    Note('Hello world', 'Welcome to my note app <3'),
    Note('Hello world', 'Welcome to my note app <3'),
    Note('Hello world', 'Welcome to my note app <3'),
  ];
  List<Note> get NotesList => _notesList;
  final List<Note> _deletedNotesList = [
    Note('Hello world', 'Welcome to my note app <3')
  ];
  List<Note> get DeletedNotesList => _deletedNotesList;
  void addNewNote(Note note) {
    _notesList.insert(0, note);
    notifyListeners();
  }
  void moveToTrash(String noteID) {
    Note note = _notesList.firstWhere((element) => element.id == noteID);
    _deletedNotesList.insert(0, note);
    _notesList.removeWhere((element) => element == note);
    notifyListeners();
  }

  void restoreFromTrash(String noteID) {
    Note note = _deletedNotesList.firstWhere((element) => element.id == noteID);
    _notesList.add(note);
    _deletedNotesList.removeWhere((element) => element == note);
    notifyListeners();
  }
  void deleteFromTrash(String id){
    _deletedNotesList.removeWhere((element) => element.id == id);
    notifyListeners();
  }
  void clear(){
    _notesList.clear();
    notifyListeners();
  }
  void restoreAllNote() {
      _notesList.addAll(_deletedNotesList);
      _deletedNotesList.clear();
      notifyListeners();
  }
}
