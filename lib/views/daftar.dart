import 'package:flutter/material.dart';
import 'package:flutter_onenote/provider/notes_provider.dart';

import 'package:flutter_onenote/views/login.dart';
import 'package:provider/provider.dart';

class Daftar extends StatefulWidget {
  const Daftar({super.key});

  @override
  State<Daftar> createState() => _DaftarState();
}

class _DaftarState extends State<Daftar> {
  @override
  Widget build(BuildContext context) {
    final readNote = context.read<NoteData>();
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Row 1
          const Center(
            child: Text(
              "Daftar Akun OneNote",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),

          // Row 2
          const Center(
            child: Text(
              "Buat catatan. Tetap Rapi.",
              style: TextStyle(fontWeight: FontWeight.w200),
            ),
          ),

          // Row 3
          Expanded(
            child: Image.asset('asset/images.png'),
          ),

          // Row 4
          Container(
            margin: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            width: MediaQuery.of(context).size.width,
            height: 50,
            alignment: Alignment.center,
            child: TextField(
              controller: readNote.emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
          ),

          const SizedBox(
            height: 20,
          ),

          Container(
            margin: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            width: MediaQuery.of(context).size.width,
            height: 50,
            alignment: Alignment.center,
            child: TextField(
              controller: readNote.passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: 10),
            child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ));
                },
                child: const Text(
                  "Sudah punya akun?",
                  style: TextStyle(color: Color.fromARGB(255, 47, 0, 255)),
                )),
          ),
          // Row 5
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            height: 40,
            color: Colors.purple,
            width: MediaQuery.of(context).size.width,
            child: TextButton(
              onPressed: () {
                readNote.signUp(context);
              },
              style: TextButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height),
              ),
              child: const Text(
                "Daftar",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
