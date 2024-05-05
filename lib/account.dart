import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(50),
      ),
      width: 40,
      height: 40,
      child: const Center(
        child: Text('A', style: TextStyle(color: Colors.white, fontSize: 20),),
      ),
    );
  }
}
