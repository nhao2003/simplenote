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

  static void moveToTrash(Note note) {
    deletedNotesList.add(note);
    NotesList.removeWhere((element) => element == note);
  }

  static void restoreFromTrash(Note note) {
    NotesList.add(note);
    deletedNotesList.removeWhere((element) => element == note);
  }
}
