import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tracker_pkg/auth/auth_service.dart';
import 'package:tracker_pkg/auth/authgoogle.dart';
import 'package:tracker_pkg/const/color.dart';
import 'package:tracker_pkg/const/styless.dart';
import 'package:tracker_pkg/location/adding_screen.dart';
import 'package:tracker_pkg/parsel/parsel_widget.dart';
import 'package:tracker_pkg/widget/button.dart';
import 'package:tracker_pkg/widget/dropdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ParselScreen extends StatelessWidget {
  const ParselScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final provider = Provider.of<GoogleSingInPro>(context, listen: false);
    return Scaffold(
        backgroundColor: kbgc,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Посылки',
            style: kTextAppBar,
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () =>
                  showDialog(context: context, builder: (_) => dialog(context)),
              icon: Icon(
                Icons.notifications,
                color: kTextColor,
                size: 27,
              ),
            ),
          ],
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: kTextColor,
              size: 27,
            ),
            onPressed: () {},
            //=> Navigator.pop(context),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 11.h,
                ),
                DropButton(),
                SizedBox(
                  height: 450,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        return ParselWidget(
                          text: 'Наушники',
                          time: '19.08',
                          upgrade: '$index',
                          where: 'Прошло регистрацию',
                        );
                      }),
                ),
                SizedBox(
                  height: 17.h,
                ),
                // ParselWidget(
                //   text: 'Наушники',
                //   time: '19.08',
                //   upgrade: '13:24',
                //   where: 'Прошло регистрацию',
                // ),
                // ParselWidget(
                //   text: 'Платье',
                //   time: '15.08',
                //   upgrade: '15:40',
                //   where: 'Доставлено',
                // ),
              ],
            ),
          ),
        ));
  }
}
