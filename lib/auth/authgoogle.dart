import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSingInPro extends ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool _isSingingIn = false;

  // GoogleSingInPro() {
  //   _googleSignIn = false;
  // }

  bool get isSingingIn => _isSingingIn;

  set isSingingIn(bool isSiningIn) {
    _isSingingIn = _isSingingIn;
    notifyListeners();
  }

  Future login() async {
    isSingingIn = true;
    final user = await _googleSignIn.signIn();
    if (user == null) {
      isSingingIn = false;
      return;
    } else {
      final googleAuth = await user.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      await FirebaseAuth.instance.signInWithCredential(credential);

      isSingingIn = false;
    }
  }

  void logout() async {
    await _googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}
