import 'package:flutter/material.dart';
import 'package:flutter_onenote/model/notes_model.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NoteData extends ChangeNotifier {
  NoteData() {
    getNotes();
  }
  var db = FirebaseFirestore.instance;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set setLoading(val) {
    _isLoading = val;
    notifyListeners();
  }

  List<NotesModel> _dataNote = [];
  List<NotesModel> get dataNote => _dataNote;
  set setDataNote(val) {
    _dataNote.add(val);
    notifyListeners();
  }

  TextEditingController titleController = TextEditingController(text: '');
  TextEditingController deskripsiController = TextEditingController(text: '');
  String formattedDate =
      DateFormat('EEEE, dd MMMM yyyy  HH:mm').format(DateTime.now());

  Future<bool> addNote({title, deskripsi, time}) async {
    late bool result;
    final docRef = db.collection('notes').doc();
    NotesModel notes = NotesModel(
        deskripsi: deskripsi, time: time, title: title, id: docRef.id);
    await db.collection('notes').add(notes.toJson()).then((val) {
      print('Notes added sucessfully');
      result = true;
    }, onError: (error) {
      print('Error while added: $error');
      result = false;
    });
    return result;
  }

  void hapusData() {
    _dataNote = [];
  }

  void getNotes() async {
    try {
      setLoading = true;
      await db.collection('notes').get().then((snapShot) {
        snapShot.docs.forEach((element) {
          setDataNote = NotesModel.fromJson(element.data());
        });
      });
    } catch (e) {
      print('Error while fetching data : $e');
    } finally {
      setLoading = false;
    }
  }

  void deleteNotes(String noteId) async {
    try {
      db.collection('notes').doc(noteId).delete();
      dataNote.removeWhere((note) => note.id == noteId);
    } catch (e) {
      print('Error delete note: $e');
    }
  }
}
