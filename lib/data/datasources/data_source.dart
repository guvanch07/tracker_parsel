import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tracker_pkg/data/datasources/data.dart';
import 'package:tracker_pkg/data/models/info_parsel.dart';
import 'package:tracker_pkg/data/models/register.dart';
import 'package:tracker_pkg/parcel/parcel.dart';

//String key = '7B81A74097D71028ED9E0BB949C37CD6';
String key = '8EA3FE3E4450D6A26139B580C11DCB26';

/// + посылка не была зарегистрирована ни этим пользователем ни кем либо еще
/// + ваш номер был зарегистрирован в базе, информацию по нему можете посмотреть в ваших посылках
/// + номер посылки неизвестен, некорректен
/// + длина номера 0
/// + номер написан с маленькой буквы
/// + у номера лишние пробелы спереди, сзади и спереди
/// + если есть в посыле z2 показываем его, в противном случае z1
/// +  z1 and z2 пусто
/// + обновить данные при нажатии на кнопку
/// + accepted пуст
/// + кто то добавил посылку в базу(не наш пользователь или наш пользователь(но он удалил приложение и поставил его заново))
///
/// - обновлять данные при входе
/// - обновлять данные при отведении в низ
/// - отступы в самом номере(SB071    93  1150  LV)
///
///
/// 20  + 10 (with following.dart, parcel )- request
///  7  - add
///  3 - remove

final controllerData = Get.put(DataSource());

class NetworkService {
  @override
  Future<int> registerParcel(String number) async {
    final response = await http.post(
        Uri.parse('https://api.17track.net/track/v1/register'),
        headers: {'17token': '$key', 'Content-Type': 'application/json'},
        body: "[{'number': '$number'}]");
    if (response.statusCode == 200) {
      var decodedResponse =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      print(decodedResponse);
      var ret = Data1.fromJson(decodedResponse['data']);
      print('cool');
      if (ret.accepted?.length == 0) {
        print('ret.accepted?.length == 0');
        if (ret.rejected?.first.error?.code == -18019903 ||
            ret.rejected?.first.error?.code == -18010012 ||
            ret.rejected?.first.error?.code == -18010013) {
          print('номер некорректный');
          Get.snackbar('Tracker Parcel', 'Номер некорректный');
        }
        if (ret.rejected?.first.error?.code == -18019901) {
          print('номер уже был добавлен в базу');

          ///loadData (ontrollerData.register)
          if (controllerData.register.isNotEmpty) {
            int num = 0;
            print(num);

            ///loadData (ontrollerData.register)
            for (int i = 0; i < controllerData.register.length; i++) {
              print(1111);

              ///loadData (ontrollerData.register)
              print(controllerData.register[i].accepted.first.number);
              print(ret.rejected?.first.number);
              print('ok');

              ///loadData (ontrollerData.register)
              if (controllerData.register[i].accepted.first.number
                  .contains(ret.rejected?.first.number)) {
                num = 1;
                print(
                    'ваш номер был зарегистрирован в базе, информацию по нему можете посмотреть в ваших посылках)');

                Get.snackbar('Tracker Parcel',
                    'ваш номер был зарегистрирован в базе,\информациюпо нему можете посмотреть в ваших посылках');
              }
            }
            if (num != 1) {
              await carrierIdentify(ret.rejected!.first.number.toString());
              print('num !=1');
            }
          } else {
            print('этот номер есть в базе, но в листе его нет');
            print('register пуст');
            await carrierIdentify(ret.rejected!.first.number.toString());
          }
          // SB071931150LV  12021
          // LB013603058CN  3011
          // LV336687519CN  3011
        }
        if (ret.rejected?.first.error?.code != -18019903 &&
            ret.rejected?.first.error?.code != -18010012 &&
            ret.rejected?.first.error?.code != -18019901) {
          print('ошибка');
          print(ret.rejected?.first.error?.code);
          print(ret.rejected?.first.error?.message);
          Get.snackbar('Tracker Parcel', 'Номер некорректный');
        }
      } else {
        // await saveData(
        //     'register_${ret.accepted?.first.number}', ret.accepted?.single);
        // await loadData('register_${ret.accepted?.first.number}');
        print(
            'посылка не была зарегистраирована ни этим понльзователем ни кем либо еще');

        ///add (ontrollerData.register)
        ///
        ///
        // print('1');
        // saveData('register', 'qwer', Data1);
        // print('2');
        // loadData();
        // print('3');

        controllerData.register.add(ret);
        print(controllerData.register.length);
        print(controllerData.register.last.accepted?.first?.number);

        ///loadData (ontrollerData.register)
        await infoAboutParcel(
            controllerData.register.last.accepted?.first?.number,
            controllerData.register.last.accepted?.first?.carrier);
        print('no');
        Get.snackbar('Tracker Parcel', 'Ваша посылка была успешно добавлена');
      }
    } else {
      print(response.statusCode);
      print('Erroor');
      print(response.body);
      throw ServerException();
    }
    return 1;
  }

  @override
  Future infoAboutParcel(String number, int carrier) async {
    var client = http.Client();
    final request = await client.post(
        Uri.parse('https://api.17track.net/track/v1/gettrackinfo'),
        headers: {'17token': '$key', 'Content-Type': 'application/json'},
        body: "[{'number': '$number', 'carrier': '${carrier.toString()}'}]");
    if (request.statusCode == 200) {
      var decodedResponse =
          jsonDecode(utf8.decode(request.bodyBytes)) as Map<String, dynamic>;
      print(decodedResponse);
      var ret = Data2.fromJson(decodedResponse['data']);

      print('cool');
      //loadData('register_${ret.accepted?.first?.number}');
      if (ret.accepted?.length == 0) {
        print('ret.accepted?.length == 0');
        print('bed.length ==  ${controllerData.bed.length}');

        ///add (ontrollerData.bed)
        controllerData.bed.add(ret);
        print('bed.length ==  ${controllerData.bed.length}');
        // SB071931150LV  12021
        // LB013603058CN  3011
        // LV336687519CN  3011
        Get.snackbar('Tracker Parcel', 'No tracking information at this time.');
        print('0000000000000000000');
      } else {
        // if (ret.accepted?.first?.track?.firstCarrierEvent?.length == 0) {
        //   await saveData('info_${ret.accepted?.first?.number}',
        //       ret.accepted?.first?.track?.secondCarrierEvent);
        // } else {
        //   await saveData('info_${ret.accepted?.first?.number}',
        //       ret.accepted?.first?.track?.firstCarrierEvent);
        // }
        // await loadData('info_${ret.accepted?.first?.number}');
        await saveData1('info_${ret.accepted?.first?.number}',
            ret.accepted?.first?.track?.firstCarrierEvent);
        await loadData1('info_${ret.accepted?.first?.number}');

        ///add (ontrollerData.infoParsel)
        controllerData.infoParcel.add(ret);
      }
      print(ret);
    } else {
      print(request.statusCode);
      print(request.body);
      throw ServerException();
    }
  }

  @override
  Future updateInfoAboutParcel() async {
    var client = http.Client();

    ///loadData (ontrollerData.register)
    for (int i = 0; i < controllerData.register.length; i++) {
      final request = await client.post(
          Uri.parse('https://api.17track.net/track/v1/gettrackinfo'),
          headers: {'17token': '$key', 'Content-Type': 'application/json'},

          ///loadData (ontrollerData.register)
          body:
              "[{'number': '${controllerData.register[i].accepted.first.number}', 'carrier': '${controllerData.register[i].accepted.first.carrier.toString()}'}]");
      if (request.statusCode == 200) {
        var decodedResponse =
            jsonDecode(utf8.decode(request.bodyBytes)) as Map<String, dynamic>;
        print(decodedResponse);
        var ret = Data2.fromJson(decodedResponse['data']);
        print('cool');
        if (ret.accepted?.length == 0) {
          print('0000000000000000000');
        } else {
          if (ret.accepted?.first?.track?.firstCarrierEvent?.length != 0 ||
              ret.accepted?.first?.track?.secondCarrierEvent?.length != 0) {
            ///loadData (ontrollerData.infoParcel)
            if (controllerData.infoParcel.length ==
                controllerData.register.length) {
              ///loadData (ontrollerData.infoParcel)
              for (int i = 0; i < controllerData.infoParcel.length; i++) {
                print(1111);
                print(controllerData.infoParcel[i].accepted.first.number);
                print(ret.accepted?.first?.number);
                print('ok');

                ///loadData (ontrollerData.infoParcel)
                if (controllerData.infoParcel[i].accepted.first.number ==
                    ret.accepted?.first?.number) {
                  print(controllerData.infoParcel.length);

                  ///remove (ontrollerData.infoParcel)
                  controllerData.infoParcel.removeAt(i);
                  print(controllerData.infoParcel.length);

                  ///add (ontrollerData.infoParcel)
                  controllerData.infoParcel.add(ret);
                  print(controllerData.infoParcel.length);
                  print('обновили');
                  break;
                }
              }
            } else {
              ///loadData (ontrollerData.infoParcel)
              for (int i = 0; i < controllerData.infoParcel.length; i++) {
                print(1111);
                print(controllerData.infoParcel[i].accepted.first.number);
                print(ret.accepted?.first?.number);
                print('ok');

                ///loadData (ontrollerData.infoParcel)
                if (controllerData.infoParcel[i].accepted.first.number ==
                    ret.accepted?.first?.number) {
                  print(controllerData.infoParcel.length);

                  ///remove (ontrollerData.infoParcel)
                  controllerData.infoParcel.removeAt(i);
                  print(controllerData.infoParcel.length);

                  ///add (ontrollerData.infoParcel)
                  controllerData.infoParcel.add(ret);
                  print(controllerData.infoParcel.length);
                  print('обновили');
                  break;
                }
              }

              ///loadData (ontrollerData.bed)
              for (int i = 0; i < controllerData.bed.length; i++) {
                print(controllerData.bed[i].rejected.first.number);
                print(ret.accepted?.first?.number);
                print('ok');

                ///loadData (ontrollerData.bed)
                if (controllerData.bed[i].rejected.first.number ==
                    ret.accepted?.first?.number) {
                  print(controllerData.infoParcel.length);

                  /// add (ontrollerData.infoParcel)
                  controllerData.infoParcel.add(ret);

                  /// remove (ontrollerData.bed)
                  controllerData.bed.removeAt(i);
                  print(controllerData.infoParcel.length);
                  print(controllerData.bed.length);
                  print('oбновили');
                  break;
                }
              }
            }
          }
        }
        print(ret);
      } else {
        print(request.statusCode);
        print(request.body);
        throw ServerException();
      }
    }
    Get.snackbar('Tracker Parcel', 'Обновили');
  }

  @override
  Future<int> carrierIdentify(String number) async {
    final response = await http.post(
        Uri.parse('https://api.17track.net/track/v1/carrierIdentify'),
        headers: {'17token': '$key', 'Content-Type': 'application/json'},
        body: "[{'number': '$number'}]");
    if (response.statusCode == 200) {
      var decodedResponse =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      print(decodedResponse);
      var ret = Data1.fromJson(decodedResponse['data']);
      print('cool');
      if (ret.accepted?.length != 0) {
        ///add (ontrollerData.register)
        controllerData.register.add(ret);
        print(controllerData.register.length);
        print(controllerData.register.last.accepted?.first?.number);
        print('no');
        Get.snackbar('Tracker Parcel', 'Ваша посылка была успешно добавлена');

        ///loadData (ontrollerData.register)
        await infoAboutParcel(
            controllerData.register.last.accepted?.first?.number,
            controllerData.register.last.accepted?.first?.carrier);
      } else {
        print('accepted.leangt == 0');
      }
    } else {
      print(response.statusCode);
      print('Erroor');
      print(response.body);
      throw ServerException();
    }
    return 1;
  }
}

class ServerException implements Exception {}
