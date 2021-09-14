import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker_pkg/location/adding_screen.dart';

import 'authgoogle.dart';
import 'login.dart';

class GlWrapper extends StatelessWidget {
  const GlWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshop) {
          final provider = Provider.of<GoogleSingInPro>(context);
          if (provider.isSingingIn) {
            return buildLoading();
          } else if (snapshop.hasData) {
            return TabScreen();
          } else {
            return LoginScreen();
          }
        });
  }

  Widget buildLoading() => Center(child: CircularProgressIndicator());
}
