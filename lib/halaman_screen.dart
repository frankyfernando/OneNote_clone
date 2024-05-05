import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HalamanScreen extends StatefulWidget {
  String? titleInit;
  String? deskripsiInit;
  HalamanScreen({super.key, this.titleInit = '', this.deskripsiInit = ''});

  @override
  State<HalamanScreen> createState() => _HalamanScreenState();
}

class _HalamanScreenState extends State<HalamanScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController deskripsi = TextEditingController();
  Map<String, String> notes = {'title': '', 'deskripsi': ''};
  @override
  void initState() {
    super.initState();
    title = TextEditingController(text: widget.titleInit);
    deskripsi = TextEditingController(text: widget.deskripsiInit);
  }

  // fungsi add note
  void addNote(String title, String deskripsi) {
    setState(() {
      notes.addAll({
        'title': title,
        'deskripsi': deskripsi,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        shadowColor: Colors.grey,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                addNote(title.text, deskripsi.text);
                Navigator.pop(context, notes);
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
              controller: title,
              decoration: const InputDecoration(
                labelText: "",
                contentPadding: EdgeInsets.only(right: 40),
                border: UnderlineInputBorder(),
              ),
            ),
          ),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 40),
              ),
              Text("Rabu, 01 Mei 2024      15.51"),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: TextField(
              controller: deskripsi,
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