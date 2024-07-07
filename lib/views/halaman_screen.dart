import 'package:flutter/material.dart';
import 'package:flutter_onenote/provider/notes_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class HalamanScreen extends StatefulWidget {
  String metode;
  String noteId;
  HalamanScreen(
      {super.key,
      required this.metode,
      required this.noteId,});

  @override
  State<HalamanScreen> createState() => _HalamanScreenState();
}

class _HalamanScreenState extends State<HalamanScreen> {
  @override
  Widget build(BuildContext context) {
    final readNote = context.read<NoteData>();
    final watchNote = context.watch<NoteData>();
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        shadowColor: Colors.grey,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: widget.metode == 'update'
                  ? () async {
                      bool response = await watchNote.updateNote(
                          widget.noteId,
                          readNote.titleController.text,
                          readNote.deskripsiController.text);
                      if (response) {
                        print('update berhasil');
                      } else {
                        print('update gagal');
                      }
                      Navigator.pop(context);
                    }
                  : () async {
                      bool response = await watchNote.addNote(
                          deskripsi: readNote.deskripsiController.text,
                          time: DateTime.now(),
                          title: readNote.titleController.text);
                      if (response) {
                        print('add berhasil');
                      } else {
                        print('error');
                      }
                      Navigator.pop(context);
                    },
              icon: const Icon(Icons.save),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(40),
            child: TextField(
              controller: readNote.titleController,
              decoration: const InputDecoration(
                labelText: "",
                contentPadding: EdgeInsets.only(right: 40),
                border: UnderlineInputBorder(),
              ),
            ),
          ),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 40),
              ),
              Text(readNote.formattedDate),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: TextField(
              controller: readNote.deskripsiController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.only(left: 40),
              ),
            ),
          )
        ],
      ),
    );
  }
}
