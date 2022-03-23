import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tracker_pkg/const/color.dart';
import 'package:tracker_pkg/const/styless.dart';
import 'package:tracker_pkg/location/adding_screen.dart';
// import 'package:provider/provider.dart';
// import 'package:tracker_pkg/location/adding_screen.dart';
import 'package:tracker_pkg/widget/button.dart';

import 'package:tracker_pkg/widget/textfield.dart';
//
// import 'auth_service.dart';
// import 'login.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var features = [
      "Бесплатный пробный период - неделя",
      "Отслеживаем в максимальном\nколичестве систем",
      "Мультиязычность"
    ];
    //final size = MediaQuery.of(context).size;
    // final TextEditingController emailController = TextEditingController();
    // final TextEditingController passwordController = TextEditingController();
    // final authService = Provider.of<AuthService>(context);
    return Scaffold(
        backgroundColor: kbgc,
        body: SafeArea(
          top: false,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // Container(
                //   child: Image.asset('assets/mini.png'),
                // ),
                Logo(),
                Container(
                  child: Column(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 60),
                          child: Text(
                            'Почему с нами выгодно:',
                            style: kText30,
                          ),
                        ),
                      ),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: features.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.only(top: 28),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(31, 0, 15, 0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Container(
                                      color: kButton,
                                      width: 6,
                                      height: 6,
                                    ),
                                  ),
                                ),
                                Text(features[index], style: kText18)
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 50),
                      PaymentButton(
                        borderradius: 5.0,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TabScreen()),
                          );
                        },
                        text1: 'ПОПРОБОВАТЬ',
                        text2: '7 дней бесплатно. Затем 19,99\$ в месяц',
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 90),
                              child: InkWell(
                                  child: Text(
                                    "Terms of Service",
                                    style: TextStyle(
                                      fontFamily: "Tahoma",
                                      fontSize: 14,
                                      color: Color.fromRGBO(73, 89, 107, 1),
                                    ),
                                  ),
                                  onTap: () {}),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Image.asset(
                                  'assets/vector_vertical.png',
                                  color: Color.fromRGBO(73, 89, 107, 1),
                                )),
                            InkWell(
                                child: Text(
                                  "Pryvacy Policy",
                                  style: TextStyle(
                                    fontFamily: "Tahoma",
                                    fontSize: 14,
                                    color: Color.fromRGBO(73, 89, 107, 1),
                                  ),
                                ),
                                onTap: () {}),
                          ],
                        ),
                      ),
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

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Image.asset('assets/mini.png'),
          Positioned(
            left: MediaQuery.of(context).size.width / 2 - 110,
            top: 90,
            child: Image.asset('assets/logo.png'),
          ),
          Positioned(
            top: 70,
            left: 20,
            child: Image.asset('assets/pic3.png'),
          ),
          Positioned(
            top: 150,
            left: MediaQuery.of(context).size.width / 2 + 90,
            child: Image.asset('assets/unpack.png'),
          ),
        ],
      ),
    );
  }
}
