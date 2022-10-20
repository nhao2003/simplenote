import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/model/http_exception.dart';
import 'package:todoapp/widgets/note_list.dart';
import 'note.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Notes with ChangeNotifier {
  List<Note> _notesList = [
    Note(
      id: "1",
      date: DateTime.now(),
      title: 'Hello world',
      content: 'Welcome to my note app <3',
    ),
  ];

  List<Note> get NotesList => _notesList;
  List<Note> _deletedNotesList = [
  ];
  final String authToken;
  Notes(this.authToken, this._notesList, this._deletedNotesList);
  List<Note> get DeletedNotesList => _deletedNotesList;

  Future<void> addNewNote(String title, String content) async {
    final url = Uri.parse(
        'https://simplenote-ffef6-default-rtdb.asia-southeast1.firebasedatabase.app/notes.json?auth=$authToken');
    try {
      DateTime dateTime = DateTime.now();
      final response = await post(
        url,
        body: json.encode(
          {
            'title': title,
            'content': content,
            'date': dateTime.toString(),
          },
        ),
      );
      print(response.body);
      final Note newNote = Note(
        id: json.decode(response.body)['name'],
        title: title,
        content: content,
        date: dateTime,
      );
      _notesList.insert(0, newNote);
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  void moveToTrash(String noteID) {
    Note note = _notesList.firstWhere((element) => element.id == noteID);
    _deletedNotesList.insert(0, note);
    _notesList.removeWhere((element) => element == note);
    notifyListeners();
  }
  Future<void> deleteNote(String id) async {
    final url = Uri.parse(
        'https://simplenote-ffef6-default-rtdb.asia-southeast1.firebasedatabase.app/notes/$id.json?auth=$authToken');
    int existingNoteIndex = _notesList.indexWhere((prod) => prod.id == id);
    Note existingNote = _notesList[existingNoteIndex];
    _notesList.remove(existingNote);
    notifyListeners();
    final response = await delete(url);

    if (response.statusCode >= 400) {
      _notesList.insert(existingNoteIndex, existingNote);
      notifyListeners();
      throw HttpException('Could not delete product!');
    }
  }

  void restoreFromTrash(String noteID) {
    Note note = _deletedNotesList.firstWhere((element) => element.id == noteID);
    _notesList.add(note);
    _deletedNotesList.removeWhere((element) => element == note);
    notifyListeners();
  }

  void deleteFromTrash(String id) {
    _deletedNotesList.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void clear() {
    _notesList.clear();
    notifyListeners();
  }

  void restoreAllNote() {
    _notesList.addAll(_deletedNotesList);
    _deletedNotesList.clear();
    notifyListeners();
  }
}
