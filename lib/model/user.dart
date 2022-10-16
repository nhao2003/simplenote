import 'note.dart';

class User {
  static List<Note> NotesList = [
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
    Note('Hello world', 'Welcome to my note app <3'),
    Note('Hello world', 'Welcome to my note app <3'),
    Note('Hello world', 'Welcome to my note app <3')
  ];
  static List<Note> deletedNotesList = [
    Note('Hello world', 'Welcome to my note app <3')
  ];

  static void moveToTrash(String noteID) {
    Note note = NotesList.firstWhere((element) => element.id == noteID);
    deletedNotesList.insert(0, note);
    NotesList.removeWhere((element) => element == note);
  }

  static void restoreFromTrash(String noteID) {
    Note note = deletedNotesList.firstWhere((element) => element.id == noteID);
    NotesList.add(note);
    deletedNotesList.removeWhere((element) => element == note);
  }
}
