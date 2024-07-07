import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onenote/model/notes_model.dart';
import 'package:flutter_onenote/views/dashboard.dart';

import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoteData extends ChangeNotifier {
  var db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set setLoading(val) {
    _isLoading = val;
    notifyListeners();
  }

  String _uid = "";
  String get uid => _uid;
  set setUid(val) {
    _uid = val;
    notifyListeners();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController titleController = TextEditingController(text: '');
  TextEditingController deskripsiController = TextEditingController(text: '');
  String formattedDate =
      DateFormat('EEEE, dd MMMM yyyy  HH:mm').format(DateTime.now());

  void logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    setUid = '';
    emailController = TextEditingController(text: "");
    passwordController = TextEditingController(text: "");
  }

  Future<void> signIn(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      User? user = userCredential.user;
      if (user != null) {
        setUid = user.uid;
        print("Berhasil mendapatkan uid");
      }

      String? idToken = await user?.getIdToken();
      if (idToken != null) {
        await prefs.setString('token', idToken);
        print('Berhasil membuat token');
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const DashboardNote()));
      } else {
        print('Gagal membuat token');
      }
    } on FirebaseAuthException catch (e) {
      String _message = "";
      if (e.code == "invalid-email") {
        _message = "No user found for that user.";
      } else if (e.code == "invalid-credential") {
        _message = "Wrong password provided for that user";
      }
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(_message),
      ));
    }
  }

  Future<void> signUp(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

      User? user = userCredential.user;
      if (user != null) {
        setUid = user.uid;
        print("Berhasil mendapatkan uid");
      }

      String? idToken = await user?.getIdToken();
      if (idToken != null) {
        await prefs.setString('token', idToken);
        print('Berhasil membuat token');
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const DashboardNote()));
      } else {
        print('Gagal membuat token');
      }
    } on FirebaseAuthException catch (e) {
      String _message = "";
      print(e.code);
      if (e.code == "invalid-email") {
        _message = "Invalid Email. Please Enter The Email Correctly";
      } else if (e.code == "missing-password") {
        _message = "Password Is Empty. Please Enter The Password";
      }
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(_message),
      ));
    }
  }

  Future<bool> addNote({title, deskripsi, time}) async {
    late bool result;
    final docRef = db.collection('notes').doc();
    NotesModel notes = NotesModel(
        deskripsi: deskripsi,
        time: time,
        title: title,
        id: docRef.id,
        userId: _uid);
    await db.collection('notes').doc(docRef.id).set(notes.toJson()).then((val) {
      print('Notes added sucessfully');
      result = true;
    }, onError: (error) {
      print('Error while added: $error');
      result = false;
    });
    return result;
  }

  Stream<List<NotesModel>> getNotes() {
    return FirebaseFirestore.instance
        .collection('notes')
        .where('userId', isEqualTo: _uid)
        .orderBy('time', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              return NotesModel.fromJson(doc.data());
            }).toList());
  }

  void deleteNotes(String noteId) async {
    try {
      await db.collection('notes').doc(noteId).delete().then(
          (val) => print("Note delete"),
          onError: (error) => print("Gagal Delete : $error"));
    } catch (e) {
      print('Error delete note: $e');
    }
  }

  Future<bool> updateNote(String noteId, String title, String deskripsi) async {
    late bool result;
    try {
      await db.collection('notes').doc(noteId).update(
          {'title': title, 'time': DateTime.now(), 'deskripsi': deskripsi});
      result = true;
    } catch (e) {
      print("Error : $e");
      result = false;
    }
    return result;
  }
}
