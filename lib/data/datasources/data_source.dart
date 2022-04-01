import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tracker_pkg/data/datasources/data.dart';
import 'package:tracker_pkg/data/models/info_parsel.dart';
import 'package:tracker_pkg/data/models/register.dart';
import 'package:tracker_pkg/parsel/parsel.dart';

String key = '7B81A74097D71028ED9E0BB949C37CD6';

/// + посылка не была зарегистрирована ни этим пользователем ни кем либо еще
/// + ваш номер был зарегистрирован в базе, информацию по нему можете посмотреть в ваших посылках
/// + номер посылки неизвестен, некорректен
/// + длина номера 0
/// + номер написан с маленькой буквы
/// + у номера лишние пробелы спереди, сзади и спереди
/// + если есть в посыле z2 показываем его, в противном случае z1
///
///
///
///
///  обновлять данные при входе
///  обновлять данные при отведении в низ
///  accepted пуст
///
///
/// - кто то добавил посылку в базу(не наш пользователь или наш пользователь(но он удалил приложение и поставил его заново))
/// - отступы в самом номере(SB071    93  1150  LV)
///
///

class NetworkService {
  @override
  Future<int> registerParcel(String number) async {
    final response = await http.post(
        Uri.parse('https://api.17track.net/track/v1/register'),
        headers: {'17token': '$key', 'Content-Type': 'application/json'},
        body: "[{'number': '$number'}]");

    //print(response.body);
    if (response.statusCode == 200) {
      var decodedResponse =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      print(decodedResponse);
      var ret = Data1.fromJson(decodedResponse['data']);

      print('cool');
      //print(ret.rejected?.first?.error?.message);
      if (ret.accepted?.length == 0) {
        print('ret.accepted?.length == 0');
        if (ret.rejected?.first.error?.code == -18019903 ||
            ret.rejected?.first.error?.code == -18010012 ||
            ret.rejected?.first.error?.code == -18010013) {
          print('номер некорректный');

          /// Show SnackBar(номер некорректный)
        }
        if (ret.rejected?.first.error?.code == -18019901) {
          print('номер уже был добавлен в базу');
          if (register.isNotEmpty) {
            for (int i = 0; i < register.length; i++) {
              print(1111);
              print(register[i].accepted.first.number);
              print(ret.rejected?.first.number);
              print('ok');
              if (register[i].accepted.first.number ==
                  ret.rejected?.first.number) {
                print(
                    'ваш номер был зарегистрирован в базе, информацию по нему можете посмотреть в ваших посылках)');

                /// Show SnackBar(ваш номер был зарегистрирован в базе, информацию по нему можете посмотреть в ваших посылках)
                break;
              }
            }
          } else {
            // SnackBar(ваш номер был зарегистрирован в базе, инфы нет)
            print('этот номер есть в базе, но в листе его нет');
            print('register пуст');
          }
          // SB071931150LV  12021
          // LB013603058CN  3011
          // LV336687519CN  3011

          //   I/flutter (11616): {code: 0, data: {accepted: [],
          //       rejected: [{number: LV336687519CN,
          //       error: {code: -18019909, message: No tracking information at this time.}}]}}
          // show snackBar (e)
        }
        if (ret.rejected?.first.error?.code != -18019903 &&
            ret.rejected?.first.error?.code != -18010012 &&
            ret.rejected?.first.error?.code != -18019901) {
          print('ошибка');
          print(ret.rejected?.first.error?.code);
          print(ret.rejected?.first.error?.message);

          /// Show SnackBar(номер некорректный)
        }
        //print('as');
        //print(register[0].rejected?.first?.error?.code);
      } else {
        print(
            'посылка не была зарегистраирована ни этим понльзователем ни кем либо еще');
        register.add(ret);
        print(register.length);
        print(register.last.accepted?.first?.number);
        infoAboutParcel(register.last.accepted?.first?.number,
            register.last.accepted?.first?.carrier);

        //print(ret.accepted);
        print('no');

        ///Show snackBar(ваша посылка была успешно добавлена)
      }
      //print(register[0].rejected?.first?.error?.message);
    } else {
      print(response.statusCode);
      print('Erroor');
      print(response.body);
      throw ServerException();
    }
    return 1;
  }

//List infoParcel = [];
  @override
  Future infoAboutParcel(String number, int carrier) async {
    var client = http.Client();
    final request = await client.post(
        Uri.parse('https://api.17track.net/track/v1/gettrackinfo'),
        headers: {'17token': '$key', 'Content-Type': 'application/json'},
        body: "[{'number': '$number', 'carrier': '${carrier.toString()}'}]");

    /// change carrier for number
    if (request.statusCode == 200) {
      var decodedResponse =
          jsonDecode(utf8.decode(request.bodyBytes)) as Map<String, dynamic>;
      print(decodedResponse);
      var ret = Data2.fromJson(decodedResponse['data']);
      print('cool');

      /// пробежатся по листу и убедится что данные перезаписываются

      if (ret.accepted?.length == 0) {
        /// проверка
        //   I/flutter (11616): {code: 0, data: {accepted: [],
        //       rejected: [{number: LV336687519CN,
        //       error: {code: -18019909, message: No tracking information at this time.}}]}}
        // show snackBar (e)
        ///переделать
        print('0000000000000000000');
      } else {
        infoParcel.add(ret);
      }

      print(ret);

      //print(ret.accepted?.first?.track?.firstCarrierEvent?[0]?.eventTime);
    } else {
      print(request.statusCode);
      print(request.body);
      throw ServerException();
    }
    // return 2;
  }
}

class ServerException implements Exception {}
