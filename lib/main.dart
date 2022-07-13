import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:tracker_pkg/auth/auth_service.dart';
import 'package:tracker_pkg/services/payments/payment_cat.dart';
import 'package:tracker_pkg/services/payments/purchse_api.dart';
import 'package:tracker_pkg/services/payments/revenue_cat_provider.dart';

import 'auth/auth_google.dart';
import 'auth/authgoogle.dart';
import 'auth/wrapper.dart';
import 'data/datasources/data.dart';
import 'location/adding_screen.dart';
import 'auth/registration.dart';
import 'logic/barcode.dart';
import 'onboarding.dart';

// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//   'high_importance_channel',
//   'High Importance Notifications',
//   'This channnel is used for important notifications',
//   importance: Importance.high,
//   playSound: true,
// );

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print('a bg massage just showed up : ${message.messageId}');
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PurchaseApi.init();
  await GetStorage.init('MyStorage');
  await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // await flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<
  //         AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(channel);

  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  //final controller = Get.find<RevenueCatProvider>();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        /
        ChangeNotifierProvider<GoogleSingInPro>(
            create: (_) => GoogleSingInPro()),
        ChangeNotifierProvider<LogicBarCode>(create: (_) => LogicBarCode()),
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
        ChangeNotifierProvider<RevenueCatProvider>(
            create: (_) => RevenueCatProvider()),
      ],
      child: ScreenUtilInit(
        builder: () => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
              // //primarySwatch: Colors.blue,
              // buttonColor: Colors.red,
              // buttonTheme: ButtonThemeData(
              //   buttonColor: Colors.red,
              // )
              ),

          home: PaymentScreen(),

          ///home: TabScreen(),
        ),
        designSize: const Size(414, 896),
      ),
    );
  }
}
