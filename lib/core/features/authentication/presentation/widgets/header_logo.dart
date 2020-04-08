import 'package:flutter/material.dart';

class HeaderLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Bando',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 64,
          color: Colors.black54),
      ),
    );
  }
}
