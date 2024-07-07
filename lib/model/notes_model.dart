import 'package:cloud_firestore/cloud_firestore.dart';

class NotesModel {
  String? userId;
  String? id;
  String? title;
  String? deskripsi;
  DateTime? time;

  NotesModel({this.id, this.title, this.deskripsi, this.time, this.userId});

  NotesModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    deskripsi = json['deskripsi'];
    time = (json['time'] as Timestamp).toDate();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['deskripsi'] = this.deskripsi;
    data['time'] = Timestamp.fromDate(this.time!);
    return data;
  }
}
