import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tracker_pkg/location/adding_screen.dart';
import 'package:tracker_pkg/widget/button.dart';

import 'package:tracker_pkg/widget/textfield.dart';

import 'auth_service.dart';
import 'login.dart';

class RegistScreen extends StatelessWidget {
  const RegistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
        body: SafeArea(
      top: false,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: Image.asset('assets/mini.png'),
            ),
            Container(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.all(55),
                    child: Text(
                      'Регистрация',
                      style: TextStyle(
                          color: Color(0xFF666E6D),
                          fontSize: 20,
                          fontFamily: 'Roboto'),
                    ),
                  ),
                  TextFields(
                    obscuretext: false,
                    text: 'Email',
                    controller: emailController,
                  ),
                  SizedBox(height: 15),
                  TextFields(
                    obscuretext: true,
                    text: 'Пароль',
                    controller: passwordController,
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.symmetric(horizontal: 58),
                    child: InkWell(
                      child: Text(
                        'Забыли пароль?',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Color(0xffAFAFAF),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(children: [
                        SvgPicture.asset('assets/google.svg'),
                        Text(
                          'google',
                          style:
                              TextStyle(color: Color(0xffC8C8C8), fontSize: 14),
                        ),
                      ]),
                      Column(
                        children: [
                          SvgPicture.asset('assets/apple.svg'),
                          Text(
                            'apple',
                            style: TextStyle(
                                color: Color(0xffC8C8C8), fontSize: 14),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  PrimaryButton(
                      borderradius: 9.0,
                      onPressed: () async {
                        await authService.createUserWithEmailAndPassword(
                            emailController.text, passwordController.text);
                        Navigator.pop(context);
                      },
                      text: 'Регистрация'),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      divider(),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                            );
                          },
                          child: Text('или вход')),
                      divider(),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  Widget divider() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: 120,
      height: 0.5,
      color: Colors.grey,
    );
  }
}
