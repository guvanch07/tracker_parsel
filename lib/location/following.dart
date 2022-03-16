import 'package:flutter/material.dart';
import 'package:tracker_pkg/const/color.dart';
import 'package:tracker_pkg/location/adding_screen.dart';
import 'package:tracker_pkg/logic/barcode.dart';
import 'package:tracker_pkg/location/track_follow.dart';
import 'package:tracker_pkg/widget/button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Following extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbgc,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Отслеживание',
          style: TextStyle(
              color: Color(0xff666E6D),
              fontSize: 24,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.normal),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () =>
                showDialog(context: context, builder: (_) => dialog(context)),
            icon: Icon(
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
      body: SingleChildScrollView(
        child: SafeArea(
          top: false,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  left: 25.w,
                  right: 25.w,
                  top: 16.h,
                  bottom: 23.h,
                ),
                height: 44.h,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(80)),
                child: Center(
                  child: Text(
                    '${context.watch<LogicBarCode>().scanValue}',
                    style: TextStyle(fontSize: 22.sp, color: kTextColor),
                  ),
                ),
              ),
              Text(
                'Наушники',
                style: TextStyle(fontSize: 25.sp, color: kTextColor),
              ),
              SizedBox(
                height: 22.h,
              ),
              FollowContainer(
                maintext: 'Доставлено',
                updash: Container(
                  height: 35,
                  width: 2,
                  color: Colors.white,
                ),
              ),
              FollowContainer(
                locate: '',
                maintext: 'Неизвестная ошибка',
                dateOrWidget: Icon(
                  Icons.help_outline,
                  color: Color(0xff666E6D),
                  size: 26,
                ),
              ),
              FollowContainer(
                maintext: 'Прибыло в сортировочный центр страны назначения ',
                date: '13',
              ),
              FollowContainer(
                maintext: 'Передано в доставку Беларуси',
                date: '12',
                locate: '',
              ),
              FollowContainer(
                maintext: 'Выпущено таможней (0. 05 кг)',
                date: '12',
                locate: 'Брест, Беларусь',
              ),
              FollowContainer(
                maintext: 'Прием на таможню (0. 05 кг)',
                date: '7',
                locate: 'Брест, Беларусь',
              ),
              FollowContainer(
                  maintext: 'Прошло регистрацию',
                  date: '2',
                  locate: 'Варшава, Польша',
                  downdash: Container(
                    height: 35,
                    width: 2,
                    color: Colors.white,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
