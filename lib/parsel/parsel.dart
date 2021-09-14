import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker_pkg/auth/auth_service.dart';
import 'package:tracker_pkg/auth/authgoogle.dart';
import 'package:tracker_pkg/const/color.dart';
import 'package:tracker_pkg/parsel/parsel_widget.dart';
import 'package:tracker_pkg/widget/button.dart';

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
        body: SafeArea(
          child: Column(
            children: <Widget>[
              ParselWidget(
                text: 'Наушники',
                time: '19.08',
                upgrade: '13:24',
                where: 'Прошло регистрацию',
              ),
              ParselWidget(
                text: 'Платье',
                time: '15.08',
                upgrade: '15:40',
                where: 'Доставлено',
              ),
              PrimaryButton(
                  borderradius: 9.0,
                  onPressed: () async {
                    await authService.singOut();
                  },
                  text: 'Вход'),
              PrimaryButton(
                  borderradius: 9.0,
                  onPressed: () {
                    provider.logout();
                  },
                  text: 'Вход'),
            ],
          ),
        ));
  }
}
