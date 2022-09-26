import 'package:coinstat/home_page.dart';
import 'package:flutter/material.dart';

class Clicker extends StatelessWidget {
  const Clicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
          icon: const Icon(Icons.arrow_forward_outlined),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
      ),
    );
  }
}
