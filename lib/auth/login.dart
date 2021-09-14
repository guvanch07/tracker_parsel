import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tracker_pkg/auth/auth_service.dart';
import 'package:tracker_pkg/auth/registration.dart';
import 'package:tracker_pkg/location/adding_screen.dart';
import 'package:tracker_pkg/widget/button.dart';
import 'package:tracker_pkg/widget/textfield.dart';

import 'authgoogle.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final authService = Provider.of<AuthService>(context);
    final provider = Provider.of<GoogleSingInPro>(context, listen: false);
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshop) {
        //final provider = Provider.of<GoogleSingInPro>(context);
        if (provider.isSingingIn) {
          return buildLoading();
        } else if (snapshop.hasData) {
          return TabScreen();
        } else {
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
                              'Вход',
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
                              GestureDetector(
                                onTap: () {
                                  provider.login();
                                },
                                child: Column(children: [
                                  SvgPicture.asset('assets/google.svg'),
                                  Text(
                                    'google',
                                    style: TextStyle(
                                        color: Color(0xffC8C8C8), fontSize: 14),
                                  ),
                                ]),
                              ),
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
                              onPressed: () {
                                authService.singInUserWithEmailAndPassword(
                                    emailController.text,
                                    passwordController.text);
                              },
                              text: 'Вход'),
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
                                          builder: (context) => RegistScreen()),
                                    );
                                  },
                                  child: Text('или pегистрация')),
                              divider(),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget divider() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: 100,
      height: 0.5,
      color: Colors.grey,
    );
  }

  Widget buildLoading() => Center(child: CircularProgressIndicator());
}
