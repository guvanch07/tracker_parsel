import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          "assets/boarding.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(backgroundColor: Colors.transparent, body: LogoTrack()),
        Positioned(
          top: 180,
          left: 24,
          child: Image.asset('assets/pic2.png'),
        ),
        Positioned(
          top: 150,
          left: 260,
          child: Image.asset('assets/pic1.png'),
        ),
        Positioned(
          top: 240,
          left: 158,
          child: Image.asset('assets/vector.png'),
        ),
        Positioned(
          top: 480,
          left: 236,
          child: Image.asset('assets/plane.png'),
        ),
        Positioned(
          top: 510,
          left: 67,
          child: Image.asset('assets/mail.png'),
        ),
        Positioned(
          top: 630,
          left: 60,
          child: Image.asset('assets/last.png'),
        ),
        Positioned(
          top: 600,
          left: 260,
          child: Image.asset('assets/unpack.png'),
        ),
      ],
    );
  }
}

class LogoTrack extends StatelessWidget {
  const LogoTrack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        //alignment: Alignment.centerLeft,
        width: 180,
        //margin: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: <Widget>[
                SvgPicture.asset('assets/marker.svg'),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Text(
                    'Трекер',
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  ),
                ))
              ],
            ),
            Center(
                child: Text(
              'посылок',
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
              ),
            ))
          ],
        ),
      ),
    );
  }
}
