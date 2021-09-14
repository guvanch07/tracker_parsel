import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:tracker_pkg/auth/auth_service.dart';
import 'package:tracker_pkg/auth/login.dart';
import 'package:tracker_pkg/auth/user_model.dart';
import 'package:tracker_pkg/location/adding_screen.dart';
import 'package:tracker_pkg/main.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  // void initState() {
  //   super.initState();
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     RemoteNotification? notification = message.notification;
  //     AndroidNotification? android = message.notification?.android;
  //     if (notification != null && android != null) {
  //       flutterLocalNotificationsPlugin.show(
  //         notification.hashCode,
  //         notification.title,
  //         notification.body,
  //         NotificationDetails(
  //           android: AndroidNotificationDetails(
  //               channel.id, channel.name, channel.description,
  //               color: Colors.blue, playSound: true),
  //         ),
  //       );
  //     }
  //   });
  // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //   print('aaaaaa');
  //   RemoteNotification? notification = message.notification;
  //   AndroidNotification? android = message.notification?.android;
  // });

  @override
  Widget build(BuildContext context) {
    final authservice = Provider.of<AuthService>(context);
    return StreamBuilder<User?>(
        stream: authservice.user,
        builder: (_, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final User? user = snapshot.data;
            return user == null ? LoginScreen() : TabScreen();
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
