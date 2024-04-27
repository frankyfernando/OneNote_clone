import 'package:flutter/material.dart';

class Verified extends StatelessWidget {
  const Verified({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController password = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Image.asset(
            'asset/microsoftlogo.jpg',
            width: 200,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Row 1
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                'Masukkan kata sandi',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),

            // Row 2
            TextField(
              controller: password,
              decoration: InputDecoration(
                labelText: 'Kata sandi',
              ),
            ),
            SizedBox(
              height: 10,
            ),

            // Row 3
            Container(
              alignment: Alignment.topLeft,
              child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Lupa kata sandi?',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 91, 247),
                    ),
                  )),
            ),

            // Row 4
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 100,
                  height: 40,
                  color: Color.fromARGB(255, 45, 76, 255),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height)
                    ),
                    onPressed: () {},
                    child: Text("Masuk", style: TextStyle(color: Colors.white),),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
