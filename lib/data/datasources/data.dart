import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracker_pkg/const/color.dart';
import 'package:tracker_pkg/data/models/info_parsel.dart';
import 'package:tracker_pkg/data/models/register.dart';

// class SharedPreferencesUtil {
//
// loadData(String key) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//
//   String? json = prefs.getString(key);
//   print("Loaded json $json");
//   if (json == null) {
//     print('No data in SharedPreferences');
//   } else {
//     Map<String, dynamic> map = jsonDecode(json);
//     print('map $map');
//     final user = Accepted.fromJson(map);
//     print('User ${user.carrier},  ${user.number}');
//   }
// }

loadData1(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? json = prefs.getString(key);
  print("Loaded json $json");
  if (json == null) {
    print('No data in SharedPreferences');
  } else {
    //final List<dynamic> jsonData = jsonDecode(json);
    List<FirstCarrierEvent> posts = List<FirstCarrierEvent>.from(
        jsonDecode(json).map((model) => FirstCarrierEvent.fromJson(model)));
    print(posts);
    print(posts.length);
    print(posts[0]);
    print(posts[0].eventContent);

    // final List<dynamic> jsonData = jsonDecode(json);
    // var list = jsonData.map<List<FirstCarrierEvent>>((jsonList) {
    //   return jsonList.map<FirstCarrierEvent>((jsonItem) {
    //     return FirstCarrierEvent.fromJson(jsonItem);
    //   }).toList();
    // }).toList();
    // print(list.length);
    // print(list[0].first);

    // Map<String, dynamic> map = jsonDecode(json);
    // print('map $map');
    // final user = FirstCarrierEvent.fromJson(map);
    // print('User ${user.eventTime},  ${user.eventLocation}');
  }
}
//
// saveData(String key, ret) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//
//   // final test1Acepted = Accepted(
//   //   carrier: ret.first.carrier,
//   //   number: ret.first.number,
//   // );
//
//   String json = jsonEncode(ret);
//   print('Generated json ${json}');
//   prefs.setString(key, json);
//   //
//   // List<String> jsonList = model.map((mod) => mod.toJson()).toList();
//   // prefs.setStringList(key, jsonList);
//   // print('Generated json ${jsonList}');
//
//   // prefs3.setStringList(json);
// }

saveData1(String key, List<FirstCarrierEvent?>? ret) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // final test1Acepted = Accepted(
  //   carrier: ret.first.carrier,
  //   number: ret.first.number,
  // );

  String json = jsonEncode(ret);
  print('Generated json ${json}');
  prefs.setString(key, json);
  //
  // List<String> jsonList = model.map((mod) => mod.toJson()).toList();
  // prefs.setStringList(key, jsonList);
  // print('Generated json ${jsonList}');

  // prefs3.setStringList(json);
}

// clearData() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//
//   prefs.clear();
//   print('Data cleared');
// }

// static saveData<T>(String key, T value) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//
//   switch (T) {
//     case String:
//       prefs.setString(key, value as String);
//       break;
//     case int:
//       prefs.setInt(key, value as int);
//       break;
//     case bool:
//       prefs.setBool(key, value as bool);
//       break;
//     case double:
//       prefs.setDouble(key, value as double);
//       break;
//   }
// }

/// Чтение данных
// static Future<T> getData<T>(String key) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//
//   T res;
//   switch (T) {
//     case String:
//       res = prefs.getString(key) as T;
//       break;
//     case int:
//       res = prefs.getInt(key) as T;
//       break;
//     case bool:
//       res = prefs.getBool(key) as T;
//       break;
//     case double:
//       res = prefs.getDouble(key) as T;
//       break;
//   }
//   return res;
// }
// }

class DataSource extends GetxController {
  List infoParcel = [];
  List register = [];
  List bed = [];

  @override
  void onInit() {
    infoParcel;
    register;
    bed;
    super.onInit();
  }
}

//
//
// class User {
//   String? name;
//   String? email;
//   int? age;
//
//   User({this.name, this.age, this.email});
//
//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'email': email,
//       'age': age,
//     };
//   }
//
//   User.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     email = json['email'];
//     age = json['age'];
//   }
// }
//
// class Shared extends StatelessWidget {
//   const Shared({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kbgc,
//       body: SafeArea(
//         child: Center(
//           child: Column(
//             children: [
//               ElevatedButton(
//                 onPressed: () {},
//                 child: Text('Save'),
//               ),
//               ElevatedButton(
//                 onPressed: loadData,
//                 child: Text('Load'),
//               ),
//               ElevatedButton(
//                 onPressed: clearData,
//                 child: Text('Clear'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
