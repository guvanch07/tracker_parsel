import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {required this.borderradius,
      required this.onPressed,
      required this.text,
      this.width});
  final String text;
  final VoidCallback onPressed;
  final double borderradius;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 42,
        width: width ?? 190,
        decoration: BoxDecoration(
            color: Color(0xffF57300),
            borderRadius: BorderRadius.all(Radius.circular(borderradius))),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
