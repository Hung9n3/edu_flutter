import 'package:edusoft/Navbar/NavBar.dart';
import 'package:flutter/material.dart';

class Blank extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
    child: Scaffold(
      appBar: AppBar(
        title: Text(
          "Blank Page"
        ),
      ),
    body: Navbar(),
    )
    );
  }
}
