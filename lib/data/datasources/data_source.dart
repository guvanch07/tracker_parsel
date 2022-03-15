import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tracker_pkg/data/models/register.dart';

String key = '7B81A74097D71028ED9E0BB949C37CD6';

@override
Future<int> registerParcel(String number) async {
  List<Data> list;
  final response = await http.post(
      Uri.parse('https://api.17track.net/track/v1/register'),
      headers: {'17token': '$key', 'Content-Type': 'application/json'},
      body: "[{'number': 'SB071931150LV'}]");
  //print(response.body);
  if (response.statusCode == 200) {
    final data = json.decode(response.body);

    print('data  $data');
    var rest = data['data'];
    print('rest  $rest');
    list = await rest
        .map((Map<String, dynamic> json) => Data.fromJson(json))
        .toList();
    //
    print('cool');
    print(list);
    //print("List Size: ${list.length}");
    //print(json.decode(response.body));
  } else {
    print(response.statusCode);
    print(response.body);
    throw ServerException();
  }
  return 1;
}

class ServerException implements Exception {}
