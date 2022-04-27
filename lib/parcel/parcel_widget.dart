import 'package:flutter/material.dart';
import 'package:tracker_pkg/const/color.dart';
import 'package:tracker_pkg/const/styless.dart';

class ParselWidget extends StatelessWidget {
  const ParselWidget(
      {required this.text,
      required this.time,
      required this.upgrade,
      required this.where})
      : super();

  final String text;
  final String where;
  final String time;
  final String upgrade;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      height: 90,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white),
      child: Row(
        children: <Widget>[
          Container(
            child: Text(
              time,
              style: TextStyle(
                color: kTextColor,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    text,
                    style: kText16,
                  ),
                  Text(
                    where,
                    style: kText14,
                  ),
                ]),
          ),
          Container(
            alignment: Alignment.topRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text('Обновлено', style: kText14),
                Text(upgrade, style: kText14)
              ],
            ),
          )
        ],
      ),
    );
  }
}
