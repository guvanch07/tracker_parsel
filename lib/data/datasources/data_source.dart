import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tracker_pkg/data/models/info_parsel.dart';
import 'package:tracker_pkg/data/models/register.dart';

String key = '7B81A74097D71028ED9E0BB949C37CD6';

@override
Future<int> registerParcel(String number) async {
  final response = await http.post(
      Uri.parse('https://api.17track.net/track/v1/register'),
      headers: {'17token': '$key', 'Content-Type': 'application/json'},
      body: "[{'number': 'SB071931150LV'}]");

  /// change number
  //print(response.body);
  if (response.statusCode == 200) {
    var decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
    print(decodedResponse);
    var ret = Data1.fromJson(decodedResponse['data']);
    print('cool');
    print(ret.rejected?.first?.error.message);
  } else {
    print(response.statusCode);
    print('Erroor');
    print(response.body);
    throw ServerException();
  }
  return 1;
}

class ServerException implements Exception {}

@override
Future<Object> infoAboutParcel(String number) async {
  var client = http.Client();
  final request = await client.post(
      Uri.parse('https://api.17track.net/track/v1/gettrackinfo'),
      headers: {'17token': '$key', 'Content-Type': 'application/json'},
      body: "[{'number': 'SB071931150LV', 'carrier': '12021'}]");

  /// change carrier for number
  if (request.statusCode == 200) {
    var decodedResponse =
        jsonDecode(utf8.decode(request.bodyBytes)) as Map<String, dynamic>;
    print(decodedResponse);
    var ret = Data2.fromJson(decodedResponse['data']);
    print('cool');

    print(ret.accepted?.first?.track?.firstCarrierEvent?.first?.eventContent);
  } else {
    print(request.statusCode);
    print(request.body);
    throw ServerException();
  }
  return 2;
}
