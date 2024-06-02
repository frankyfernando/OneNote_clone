import 'package:flutter/material.dart';
import 'package:flutter_onenote/logic.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class HalamanScreen extends StatefulWidget {
  String action;
  int index;
  HalamanScreen({super.key, required this.action, this.index = 0});

  @override
  State<HalamanScreen> createState() => _HalamanScreenState();
}

class _HalamanScreenState extends State<HalamanScreen> {
  late String formattedDate;
  @override
  void initState() {
    super.initState();
    formattedDate =
        DateFormat('EEEE, dd MMMM yyyy  HH:mm').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    final readNote = context.read<NoteData>();
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        shadowColor: Colors.grey,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                if (widget.action == 'add') {
                  readNote.addNote(readNote.titleController.text,
                      readNote.deskripsiController.text);
                  Navigator.pop(context);
                } else if (widget.action == 'update') {
                  readNote.updateNote(
                      widget.index,
                      readNote.titleController.text,
                      readNote.deskripsiController.text);
                  Navigator.pop(context);
                }
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
              Text(formattedDate),
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
