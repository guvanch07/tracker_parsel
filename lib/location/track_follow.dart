import 'package:flutter/material.dart';
import 'package:tracker_pkg/const/color.dart';

class FollowContainer extends StatelessWidget {
  const FollowContainer(
      {this.dateOrWidget,
      this.date,
      this.month,
      this.updash,
      this.circle,
      this.downdash,
      required this.maintext,
      this.locate});

  final Widget? dateOrWidget;
  final String? date;
  final String? month;
  final Widget? updash;
  final Widget? circle;
  final Widget? downdash;
  final String maintext;
  final String? locate;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: Colors.white,
      padding: EdgeInsets.only(left: 20, right: 10),
      child: Row(
        children: <Widget>[
          dateOrWidget ??
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    date ?? '18',
                    style: TextStyle(color: kTextColor, fontSize: 18),
                  ),
                  Text(
                    month ?? 'июль',
                    style: TextStyle(
                      color: Color(0xff666E6D),
                      fontSize: 10,
                    ),
                  )
                ],
              ),
          SizedBox(
            width: 15,
          ),
          Column(
            children: <Widget>[
              updash ??
                  Container(
                    height: 35,
                    width: 2,
                    color: kTextColor,
                  ),
              circle ??
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: kTextColor,
                      shape: BoxShape.circle,
                    ),
                  ),
              downdash ??
                  Container(
                    height: 35,
                    width: 2,
                    color: kTextColor,
                  )
            ],
          ),
          SizedBox(
            width: 7,
          ),
          Container(
            width: 270,
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  maintext,
                  textAlign: TextAlign.left,
                  style: TextStyle(color: kTextColor, fontSize: 16),
                ),
                Text(
                  locate ?? 'Минск, Беларусь',
                  style: TextStyle(color: kTextColor, fontSize: 12),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
