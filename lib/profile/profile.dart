import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tracker_pkg/const/color.dart';
import 'package:tracker_pkg/widget/button.dart';
import 'package:tracker_pkg/widget/textfield.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kbgc,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Профиль',
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
                Icons.star,
                color: Color(0xff666E6D),
                size: 30,
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
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 160,
                ),
                MySwitch(),
                SizedBox(
                  height: 30,
                ),
                TextFields(obscuretext: false, text: 'Email'),
                TextFields(obscuretext: true, text: 'Пароль'),
                SizedBox(
                  height: 80,
                ),
                PrimaryButton(
                    width: 140,
                    borderradius: 30,
                    onPressed: () {},
                    text: 'Изменить')
              ],
            ),
          ),
        ));
  }

  Widget dialog(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        height: 250,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close,
                  size: 30,
                ),
              ),
            ),
            Text(
              'Почему с нами выгодно:',
              style: TextStyle(
                  color: ktextColor,
                  fontSize: 20,
                  decoration: TextDecoration.underline),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: SvgPicture.asset('assets/3.svg')),
                Container(
                  width: 200,
                  child: Text(
                    'Бесплатно до 01.01. 2022',
                    style: TextStyle(color: ktextColor, fontSize: 16),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: SvgPicture.asset('assets/2.svg')),
                Container(
                  width: 230,
                  child: Text(
                    'Отслеживаем в максимальном количестве систем',
                    style: TextStyle(color: ktextColor, fontSize: 16),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: SvgPicture.asset('assets/1.svg')),
                Container(
                  width: 200,
                  child: Text(
                    'Мультиязычность',
                    style: TextStyle(color: ktextColor, fontSize: 16),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MySwitch extends StatefulWidget {
  const MySwitch({Key? key}) : super(key: key);

  @override
  _MySwitchState createState() => _MySwitchState();
}

class _MySwitchState extends State<MySwitch> {
  bool _switched = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Включить уведомления',
            style: TextStyle(fontSize: 16, color: ktextColor),
          ),
          Switch(
            value: _switched,
            onChanged: (value) {
              setState(() {
                _switched = value;
                print(_switched);
              });
            },
            activeTrackColor: Colors.white,
            activeColor: Color(0xfff57300),
          )
        ],
      ),
    );
  }
}