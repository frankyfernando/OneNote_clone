import 'package:flutter/material.dart';
import 'package:flutter_onenote/verified.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController loginController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loginController = TextEditingController(text: 'admin@gmail.com');
  }

  void username() {
    String username = loginController.text;
    if (username == 'admin@gmail.com') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Verified()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Maaf username salah'),),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Row 1
          const Center(
            child: Text(
              "Selamat Datang di OneNote",
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
              controller: loginController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email, Nomor telepon, Nama Skype',
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),

          // Row 5
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            height: 40,
            color: Colors.purple,
            width: MediaQuery.of(context).size.width,
            child: TextButton(
              onPressed: username,
              style: TextButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height),
              ),
              child: const Text(
                "Masuk",
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
