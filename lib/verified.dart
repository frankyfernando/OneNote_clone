import 'package:flutter/material.dart';
import 'package:flutter_onenote/dashboard.dart';

class Verified extends StatefulWidget {
  const Verified({super.key});

  @override
  State<Verified> createState() => _VerifiedState();
}

class _VerifiedState extends State<Verified> {
  TextEditingController password = TextEditingController();
  @override
  void initState() {
    super.initState();
    password = TextEditingController(text: 'password');
  }

  void verifiedPassword() {
    if (password.text == 'password') {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const DashboardNote()),
          (route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Maaf Password Anda Salah"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'asset/microsoftlogo.jpg',
          width: 200,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Row 1
            Container(
              alignment: Alignment.topLeft,
              child: const Text(
                'Masukkan kata sandi',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),

            // Row 2
            TextField(
              controller: password,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Kata sandi',
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            // Row 3
            Container(
              alignment: Alignment.topLeft,
              child: TextButton(
                  onPressed: verifiedPassword,
                  child: const Text(
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
                  color: const Color.fromARGB(255, 45, 76, 255),
                  child: TextButton(
                    style: TextButton.styleFrom(
                        fixedSize: Size(MediaQuery.of(context).size.width,
                            MediaQuery.of(context).size.height)),
                    onPressed: verifiedPassword,
                    child: const Text(
                      "Masuk",
                      style: TextStyle(color: Colors.white),
                    ),
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
