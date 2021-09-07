import 'package:flutter/material.dart';
import 'package:tracker_pkg/const/color.dart';
import 'package:sizer/sizer.dart';

class AddNumber extends StatelessWidget {
  const AddNumber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbgc,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Добавление',
          style: TextStyle(
              color: Color(0xff666E6D), fontSize: 24, fontFamily: 'Roboto'),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notification_important,
              color: Color(0xff666E6D),
            ),
          ),
        ],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xff666E6D),
          ),
          onPressed: () {},
        ),
        backgroundColor: kbgc,
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
