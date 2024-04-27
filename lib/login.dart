import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_onenote/verified.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController loginController = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Row 1
          Center(
            child: Text(
              "Selamat Datang di OneNote",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),

          // Row 2
          Center(
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
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            width: MediaQuery.of(context).size.width,
            height: 50,
            alignment: Alignment.center,
            child: TextField(
              style: TextStyle(color: Colors.grey),
              controller: loginController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email, Nomor telepon, Nama Skype',
                  ),
            ),
          ),
          SizedBox(
            height: 20,
          ),

          // Row 5
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            height: 40,
            color: Colors.purple,
            width: MediaQuery.of(context).size.width,
            child: TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Verified()));
              },
              style: TextButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height),
              ),
              child: Text(
                "Masuk",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
