import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
              icon: Icon(Icons.save),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_vert),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(40),
            child: TextField(
              controller: title,
              decoration: InputDecoration(
                labelText: "",
                contentPadding: EdgeInsets.only(right: 40),
                border: UnderlineInputBorder(),
              ),
            ),
          ),
          Row(
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
              decoration: InputDecoration(
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

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Color.fromARGB(255, 236, 234, 234)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final double startY = size.height / 2;
    const double startX = 0;
    final double endX = size.width;

    canvas.drawLine(Offset(startX, startY), Offset(endX, startY), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
