import 'package:flutter/material.dart';
import 'package:tracker_pkg/const/styless.dart';

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
            style: kText16.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class PaymentButton extends StatelessWidget {
  const PaymentButton(
      {required this.borderradius,
      required this.onPressed,
      required this.text1,
      required this.text2,
      this.width});
  final String text1;
  final String text2;
  final VoidCallback onPressed;
  final double borderradius;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 70,
        width: width ?? 269,
        decoration: BoxDecoration(
            color: Color(0xffF57300),
            borderRadius: BorderRadius.all(Radius.circular(borderradius))),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text1,
              style: kText18.copyWith(color: Colors.white),
            ),
            SizedBox(height: 5),
            Text(
              text2,
              style: kText10,
            )
          ],
        ),
      ),
    );
  }
}
