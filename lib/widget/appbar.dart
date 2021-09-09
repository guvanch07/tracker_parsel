import 'package:flutter/material.dart';
import 'package:tracker_pkg/const/color.dart';

class AppBarScreen extends StatelessWidget {
  const AppBarScreen({this.icon, required this.text}) : super();

  final String text;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbgc,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          text,
          style: TextStyle(
              color: Color(0xff666E6D),
              fontSize: 24,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.normal),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: icon ??
                Icon(
                  Icons.notifications,
                  color: Color(0xff666E6D),
                  size: 27,
                ),
          ),
        ],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xff666E6D),
            size: 27,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
