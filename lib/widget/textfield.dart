import 'package:flutter/material.dart';

class TextFields extends StatelessWidget {
  const TextFields({
    required this.obscuretext,
    required this.text,
    this.controller,
  });

  final String text;
  final bool obscuretext;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      child: TextField(
        controller: controller,
        obscureText: obscuretext,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelStyle: TextStyle(height: 0),
          labelText: text,
        ),
      ),
    );
  }
}
