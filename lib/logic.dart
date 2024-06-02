import 'package:flutter/material.dart';

class Note {
  String title;
  String deskripsi;

  Note({required this.title, required this.deskripsi});
}

class NoteData extends ChangeNotifier {
  TextEditingController titleController = TextEditingController(text: '');
  TextEditingController deskripsiController = TextEditingController(text: '');
  List<Note> _notes = [Note(title: 'title', deskripsi: 'deskripsi')];
  List<Note> get notes => _notes;
  set changNote(List<Note> note) {
    _notes = note;
    notifyListeners();
  }

  void addNote(String title, String deskripsi) {
    _notes.add(Note(title: title, deskripsi: deskripsi));
    notifyListeners();
  }

  void deleteNote(int index) {
    if (index >= 0 && index < notes.length) {
      _notes.removeAt(index);
      notifyListeners();
    }
  }

  void updateNote(int index, String title, String deskripsi) {
    _notes[index] = Note(title: title, deskripsi: deskripsi);
    notifyListeners();
  }

  void kirimData(int index) {
    titleController = TextEditingController(text: notes[index].title);
    deskripsiController = TextEditingController(text: notes[index].deskripsi);
  }
}
