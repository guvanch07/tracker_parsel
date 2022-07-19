import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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
///
///
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
          final box = GetStorage('MyStorage');

          List listOfNumbers = box.read('numbers');
          if (listOfNumbers.isNotEmpty) {
            int num = 0;
            print(num);

            ///loadData (ontrollerData.register)
            for (int i = 0; i < listOfNumbers.length; i++) {
              print(1111);

              ///loadData (ontrollerData.register)
              print(listOfNumbers[i]);
              print(ret.rejected?.first.number);
              print('ok');

              ///loadData (ontrollerData.register)
              if (listOfNumbers[i].contains(ret.rejected?.first.number)) {
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
            number: controllerData.register.last.accepted?.first?.number,
            carrier: controllerData.register.last.accepted?.first?.carrier);
        print('register our parcel');
        //Get.snackbar('Tracker Parcel', 'Ваша посылка была успешно добавлена');
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
  Future<String?> infoAboutParcel({String? number, int? carrier}) async {
    final box = GetStorage('MyStorage');
    var client = http.Client();
    var response;
    if ((number == null && carrier == null) || number == null) {
      List listOfNumbers = box.read('numbers');
      List listOfCarriers = box.read('carriers');

      // List? listOfNumbersDelivering = box.read('numbersDelivering');
      // List? listOfCarriersDelivering = box.read('carriersDelivering');
      //
      // List? listOfNumbersDelivered = box.read('numbersDelivered');
      // List? listOfCarriersDelivered = box.read('carriersDelivered');
      print('listOfNumbers.length ${listOfNumbers.length}');
      for (int i = 0; i < listOfNumbers.length; i++) {
        response = await client.post(
            Uri.parse('https://api.17track.net/track/v1/gettrackinfo'),
            headers: {'17token': '$key', 'Content-Type': 'application/json'},
            body:
                "[{'number': '${listOfNumbers[i]}', 'carrier': '${listOfCarriers[i].toString()}'}]");
        if (response.statusCode == 200) {
          var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes))
              as Map<String, dynamic>;
          var ret = await Data2.fromJson(decodedResponse['data']);
          //loadData('register_${ret.accepted?.first?.number}');
          if (ret.accepted?.length == 0) {
            controllerData.bed.add(ret);
            // SB071931150LV  12021
            // LB013603058CN  3011
            // LV336687519CN  3011
            print('No tracking information at this time.');
            // Get.snackbar(
            //     'Tracker Parcel', 'No tracking information at this time.');
            return 'error';
          } else {
            //await loadData1('info');
            if (controllerData.infoParcel.isNotEmpty) {
              int n = 0;
              for (int art = 0; art < controllerData.infoParcel.length; art++) {
                if (controllerData.infoParcel[art].accepted.first.number ==
                    ret.accepted?.first?.number) {
                  print(controllerData.infoParcel.length);

                  ///remove (ontrollerData.infoParcel)
                  controllerData.infoParcel.removeAt(art);
                  print(controllerData.infoParcel.length);

                  ///add (ontrollerData.infoParcel)
                  controllerData.infoParcel.add(ret);
                  print(controllerData.infoParcel.length);
                  print('обновили');
                  n = 1;
                  break;
                }
              }
              if (n == 0) {
                controllerData.infoParcel.add(ret);

                print(
                    '  print(controllerData.infoParcel.length) : ${controllerData.infoParcel.length}');
                print(
                    '  print(controllerData.infoParcelDelivering.length) : ${controllerData.infoParcelDelivering.length}');
                print('  print(controllerData.infoParcelDelivered'
                    ''
                    '.length) : ${controllerData.infoParcelDelivered.length}');
              }
              //return 'hes data';
            } else {
              controllerData.infoParcel.add(ret);
              det() {
                print('det det det det');
                print('infoParsel : ${ret.accepted?.first}');
                var current = ret.accepted?.first;
                if (ret.accepted?.first?.track?.secondCarrierEvent?.length ==
                    0) {
                  String? content1 = current
                      ?.track?.firstCarrierEvent?[0]?.eventContent!
                      .toLowerCase();
                  return content1;
                } else {
                  String? content2 = current
                      ?.track?.secondCarrierEvent![0]?.eventContent
                      ?.toLowerCase();
                  return content2;
                }
              }

              if (det()!.contains('вручено') ||
                  det()!.contains('delivery') ||
                  det()!.contains('delivered') ||
                  det()!.contains('доставлено')) {
                print('4444444444444444444');
                print(det());
                //await saveDataDelivered(listOfNumbers[i], listOfCarriers[i]);
                controllerData.infoParcelDelivered.add(ret);
              } else {
                print(det());
                print('5555555555555');
                //await saveDataDelivering(listOfNumbers[i], listOfCarriers[i]);
                controllerData.infoParcelDelivering.add(ret);
              }
              print(
                  '  print(controllerData.infoParcel.length) : ${controllerData.infoParcel.length}');
              print(
                  '  print(controllerData.infoParcelDelivering.length) : ${controllerData.infoParcelDelivering.length}');
              print('  print(controllerData.infoParcelDelivered'
                  ''
                  '.length) : ${controllerData.infoParcelDelivered.length}');
            }

            if (controllerData.infoParcelDelivered.isNotEmpty) {
              int t = 0;
              for (int arti = 0;
                  arti < controllerData.infoParcelDelivered.length;
                  arti++) {
                if (controllerData
                        .infoParcelDelivered[arti].accepted.first.number ==
                    ret.accepted?.first?.number) {
                  controllerData.infoParcelDelivered.removeAt(arti);
                  controllerData.infoParcelDelivered.add(ret);
                  t = 1;
                }
              }
              if (t == 0) {
                controllerData.infoParcelDelivered.add(ret);
              }
            } else {
              det() {
                print('det det det det');
                print('infoParsel : ${ret.accepted?.first}');
                var current = ret.accepted?.first;
                if (ret.accepted?.first?.track?.secondCarrierEvent?.length ==
                    0) {
                  String? content1 = current
                      ?.track?.firstCarrierEvent?[0]?.eventContent!
                      .toLowerCase();
                  return content1;
                } else {
                  String? content2 = current
                      ?.track?.secondCarrierEvent![0]?.eventContent
                      ?.toLowerCase();
                  return content2;
                }
              }

              if (det()!.contains('вручено') ||
                  det()!.contains('delivery') ||
                  det()!.contains('delivered') ||
                  det()!.contains('доставлено')) {
                print('4444444444444444444');
                if (controllerData.infoParcelDelivered.isNotEmpty) {
                  int k = 0;
                  for (int arti = 0;
                      arti < controllerData.infoParcelDelivered.length;
                      arti++) {
                    if (controllerData
                            .infoParcelDelivered[arti].accepted.first.number ==
                        ret.accepted?.first?.number) {
                      controllerData.infoParcelDelivered.removeAt(arti);
                      controllerData.infoParcelDelivered.add(ret);
                      k = 1;
                    }
                  }
                  if (k == 0) {
                    controllerData.infoParcelDelivered.add(ret);
                  }
                } else {
                  controllerData.infoParcelDelivered.add(ret);
                }
              } else {
                print('5555555555555');
                if (controllerData.infoParcelDelivering.isNotEmpty) {
                  int f = 0;
                  for (int arti = 0;
                      arti < controllerData.infoParcelDelivering.length;
                      arti++) {
                    if (controllerData
                            .infoParcelDelivering[arti].accepted.first.number ==
                        ret.accepted?.first?.number) {
                      controllerData.infoParcelDelivering.removeAt(arti);
                      controllerData.infoParcelDelivering.add(ret);
                      f = 1;
                    }
                  }
                  if (f == 0) {
                    controllerData.infoParcelDelivering.add(ret);
                  }
                } else {
                  controllerData.infoParcelDelivering.add(ret);
                }
              }
            }
            if (controllerData.infoParcelDelivering.isNotEmpty) {
              int a = 0;
              for (int arti = 0;
                  arti < controllerData.infoParcelDelivering.length;
                  arti++) {
                if (controllerData
                        .infoParcelDelivering[arti].accepted.first.number ==
                    ret.accepted?.first?.number) {
                  det() {
                    print('det det det det');
                    print('infoParsel : ${ret.accepted?.first}');
                    var current = ret.accepted?.first;
                    if (ret.accepted?.first?.track?.secondCarrierEvent
                            ?.length ==
                        0) {
                      String? content1 = current
                          ?.track?.firstCarrierEvent?[0]?.eventContent!
                          .toLowerCase();
                      return content1;
                    } else {
                      String? content2 = current
                          ?.track?.secondCarrierEvent![0]?.eventContent
                          ?.toLowerCase();
                      return content2;
                    }
                  }

                  if (det()!.contains('вручено') ||
                      det()!.contains('delivery') ||
                      det()!.contains('delivered') ||
                      det()!.contains('доставлено')) {
                    print('4444444444444444444');
                    controllerData.infoParcelDelivering.removeAt(arti);
                    await saveDataDelivered(
                        listOfNumbers[i], listOfCarriers[i]);
                    controllerData.infoParcelDelivered.add(ret);
                    var listNumbers = [];
                    var listCarriers = [];
                    box.writeIfNull('numbersDelivering', listNumbers);
                    box.writeIfNull('carriersDelivering', listOfCarriers);

                    listNumbers = box.read('numbersDelivering');
                    listCarriers = box.read('carriersDelivering');
                    listNumbers.remove(listOfNumbers[i]);
                    listCarriers.remove(listOfCarriers[i]);
                    print('data saved Delivering');
                    box.remove('numbersDelivering');
                    box.remove('carriersDelivering');
                    box.write('numbersDelivering', listNumbers);
                    box.write('carriersDelivering', listCarriers);
                    a = 1;
                  } else {
                    print('5555555555555');
                    controllerData.infoParcelDelivering.removeAt(arti);
                    controllerData.infoParcelDelivering.add(ret);
                    a = 1;
                  }
                }
              }
              if (a == 0) {
                controllerData.infoParcelDelivering.add(ret);
              }
            } else {
              det() {
                print('det det det det');
                print('infoParsel : ${ret.accepted?.first}');
                var current = ret.accepted?.first;
                if (ret.accepted?.first?.track?.secondCarrierEvent?.length ==
                    0) {
                  String? content1 = current
                      ?.track?.firstCarrierEvent?[0]?.eventContent!
                      .toLowerCase();
                  return content1;
                } else {
                  String? content2 = current
                      ?.track?.secondCarrierEvent![0]?.eventContent
                      ?.toLowerCase();
                  return content2;
                }
              }

              if (det()!.contains('вручено') ||
                  det()!.contains('delivery') ||
                  det()!.contains('delivered') ||
                  det()!.contains('доставлено')) {
                print('4444444444444444444');
                if (controllerData.infoParcelDelivered.isNotEmpty) {
                  for (int arti = 0;
                      arti < controllerData.infoParcelDelivered.length;
                      arti++) {
                    if (controllerData
                            .infoParcelDelivered[arti].accepted.first.number ==
                        ret.accepted?.first?.number) {
                      controllerData.infoParcelDelivered.removeAt(arti);
                      controllerData.infoParcelDelivered.add(ret);
                    }
                  }
                } else {
                  controllerData.infoParcelDelivered.add(ret);
                }
              } else {
                print('5555555555555');
                if (controllerData.infoParcelDelivering.isNotEmpty) {
                  for (int arti = 0;
                      arti < controllerData.infoParcelDelivering.length;
                      arti++) {
                    if (controllerData
                            .infoParcelDelivering[arti].accepted.first.number ==
                        ret.accepted?.first?.number) {
                      controllerData.infoParcelDelivering.removeAt(arti);
                      controllerData.infoParcelDelivering.add(ret);
                    }
                  }
                } else {
                  controllerData.infoParcelDelivering.add(ret);
                }
              }
            }
          }
        } else {
          print(response.statusCode);
          print(response.body);
          //throw ServerException();
          return 'error';
        }
        print(
            '  print(controllerData.infoParcel.length) : ${controllerData.infoParcel.length}');
        print(
            '  print(controllerData.infoParcelDelivering.length) : ${controllerData.infoParcelDelivering.length}');
        print('  print(controllerData.infoParcelDelivered'
            ''
            '.length) : ${controllerData.infoParcelDelivered.length}');
      }
      return 'hes data';
    } else {
      response = await client.post(
          Uri.parse('https://api.17track.net/track/v1/gettrackinfo'),
          headers: {'17token': '$key', 'Content-Type': 'application/json'},
          body: "[{'number': '$number', 'carrier': '${carrier.toString()}'}]");
      if (response.statusCode == 200) {
        var decodedResponse =
            jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
        var ret = Data2.fromJson(decodedResponse['data']);
        if (ret.accepted?.length == 0) {
          print(ret);
          //controllerData.bed.add(ret);
          // SB071931150LV  12021
          // LB013603058CN  3011
          // LV336687519CN  3011
          print('No tracking information at this time.');
          Get.snackbar(
              'Tracker Parcel', 'Что-то пошло не так, попробуйте позже');
          return 'error';
        } else {
          print('1111111111111111111');
          await saveData1(number, carrier!);
          print('222222222222222222222222');
          //await loadData1('info');
          controllerData.infoParcel.add(ret);
          print('333333333333333333');

          det() {
            print('det det det det');
            print('infoParsel : ${ret.accepted?.first}');
            var current = ret.accepted?.first;
            if (ret.accepted?.first?.track?.secondCarrierEvent?.length == 0) {
              String? content1 = current
                  ?.track?.firstCarrierEvent?[0]?.eventContent!
                  .toLowerCase();
              return content1;
            } else {
              String? content2 = current
                  ?.track?.secondCarrierEvent![0]?.eventContent
                  ?.toLowerCase();
              return content2;
            }
          }

          if (det()!.contains('вручено') ||
              det()!.contains('delivery') ||
              det()!.contains('delivered') ||
              det()!.contains('доставлено')) {
            print('4444444444444444444');
            await saveDataDelivered(number, carrier);
            controllerData.infoParcelDelivered.add(ret);
          } else {
            print('5555555555555');
            await saveDataDelivering(number, carrier);
            controllerData.infoParcelDelivering.add(ret);
          }

          print(
              '  print(controllerData.infoParcel.length) : ${controllerData.infoParcel.length}');
          print(
              '  print(controllerData.infoParcelDelivering.length) : ${controllerData.infoParcelDelivering.length}');
          print('  print(controllerData.infoParcelDelivered'
              ''
              '.length) : ${controllerData.infoParcelDelivered.length}');
          Get.snackbar('Tracker Parcel', 'Ваша посылка была успешно добавлена');
          return 'has data';
        }
      } else {
        print(response.statusCode);
        print(response.body);
        return 'error';
      }
    }
  }
  //
  // @override
  // Future updateInfoAboutParcel() async {
  //   var client = http.Client();
  //
  //   ///loadData (ontrollerData.register)
  //   for (int i = 0; i < controllerData.register.length; i++) {
  //     final request = await client.post(
  //         Uri.parse('https://api.17track.net/track/v1/gettrackinfo'),
  //         headers: {'17token': '$key', 'Content-Type': 'application/json'},
  //
  //         ///loadData (ontrollerData.register)
  //         body:
  //             "[{'number': '${controllerData.register[i].accepted.first.number}', 'carrier': '${controllerData.register[i].accepted.first.carrier.toString()}'}]");
  //     if (request.statusCode == 200) {
  //       var decodedResponse =
  //           jsonDecode(utf8.decode(request.bodyBytes)) as Map<String, dynamic>;
  //       print(decodedResponse);
  //       var ret = Data2.fromJson(decodedResponse['data']);
  //       print('cool');
  //       if (ret.accepted?.length == 0) {
  //         print('0000000000000000000');
  //       } else {
  //         if (ret.accepted?.first?.track?.firstCarrierEvent?.length != 0 ||
  //             ret.accepted?.first?.track?.secondCarrierEvent?.length != 0) {
  //           ///loadData (ontrollerData.infoParcel)
  //           if (controllerData.infoParcel.length ==
  //               controllerData.register.length) {
  //             ///loadData (ontrollerData.infoParcel)
  //             for (int i = 0; i < controllerData.infoParcel.length; i++) {
  //               print(1111);
  //               print(controllerData.infoParcel[i].accepted.first.number);
  //               print(ret.accepted?.first?.number);
  //               print('ok');
  //
  //               ///loadData (ontrollerData.infoParcel)
  //               if (controllerData.infoParcel[i].accepted.first.number ==
  //                   ret.accepted?.first?.number) {
  //                 print(controllerData.infoParcel.length);
  //
  //                 ///remove (ontrollerData.infoParcel)
  //                 controllerData.infoParcel.removeAt(i);
  //                 print(controllerData.infoParcel.length);
  //
  //                 ///add (ontrollerData.infoParcel)
  //                 controllerData.infoParcel.add(ret);
  //                 print(controllerData.infoParcel.length);
  //                 print('обновили');
  //                 break;
  //               }
  //             }
  //           } else {
  //             ///loadData (ontrollerData.infoParcel)
  //             for (int i = 0; i < controllerData.infoParcel.length; i++) {
  //               print(1111);
  //               print(controllerData.infoParcel[i].accepted.first.number);
  //               print(ret.accepted?.first?.number);
  //               print('ok');
  //
  //               ///loadData (ontrollerData.infoParcel)
  //               if (controllerData.infoParcel[i].accepted.first.number ==
  //                   ret.accepted?.first?.number) {
  //                 print(controllerData.infoParcel.length);
  //
  //                 ///remove (ontrollerData.infoParcel)
  //                 controllerData.infoParcel.removeAt(i);
  //                 print(controllerData.infoParcel.length);
  //
  //                 ///add (ontrollerData.infoParcel)
  //                 controllerData.infoParcel.add(ret);
  //                 print(controllerData.infoParcel.length);
  //                 print('обновили');
  //                 break;
  //               }
  //             }
  //
  //             ///loadData (ontrollerData.bed)
  //             for (int i = 0; i < controllerData.bed.length; i++) {
  //               print(controllerData.bed[i].rejected.first.number);
  //               print(ret.accepted?.first?.number);
  //               print('ok');
  //
  //               ///loadData (ontrollerData.bed)
  //               if (controllerData.bed[i].rejected.first.number ==
  //                   ret.accepted?.first?.number) {
  //                 print(controllerData.infoParcel.length);
  //
  //                 /// add (ontrollerData.infoParcel)
  //                 controllerData.infoParcel.add(ret);
  //
  //                 /// remove (ontrollerData.bed)
  //                 controllerData.bed.removeAt(i);
  //                 print(controllerData.infoParcel.length);
  //                 print(controllerData.bed.length);
  //                 print('oбновили');
  //                 break;
  //               }
  //             }
  //           }
  //         }
  //       }
  //       print(ret);
  //     } else {
  //       print(request.statusCode);
  //       print(request.body);
  //       throw ServerException();
  //     }
  //   }
  //   Get.snackbar('Tracker Parcel', 'Обновили');
  // }

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
        //Get.snackbar('Tracker Parcel', 'Ваша посылка была успешно добавлена');

        ///loadData (ontrollerData.register)
        await infoAboutParcel(
            number: controllerData.register.last.accepted?.first?.number,
            carrier: controllerData.register.last.accepted?.first?.carrier);
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

//
// final controllerData = Get.put(DataSource());
//
// class NetworkService {
//   @override
//   Future<int> registerParcel(String number) async {
//     final response = await http.post(
//         Uri.parse('https://api.17track.net/track/v1/register'),
//         headers: {'17token': '$key', 'Content-Type': 'application/json'},
//         body: "[{'number': '$number'}]");
//     if (response.statusCode == 200) {
//       var decodedResponse =
//           jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
//       print(decodedResponse);
//       var ret = Data1.fromJson(decodedResponse['data']);
//       print('cool');
//       if (ret.accepted?.length == 0) {
//         print('ret.accepted?.length == 0');
//         if (ret.rejected?.first.error?.code == -18019903 ||
//             ret.rejected?.first.error?.code == -18010012 ||
//             ret.rejected?.first.error?.code == -18010013) {
//           print('номер некорректный');
//           Get.snackbar('Tracker Parcel', 'Номер некорректный');
//         }
//         if (ret.rejected?.first.error?.code == -18019901) {
//           print('номер уже был добавлен в базу');
//
//           ///loadData (ontrollerData.register)
//           if (controllerData.register.isNotEmpty) {
//             int num = 0;
//             print(num);
//
//             ///loadData (ontrollerData.register)
//             for (int i = 0; i < controllerData.register.length; i++) {
//               print(1111);
//
//               ///loadData (ontrollerData.register)
//               print(controllerData.register[i].accepted.first.number);
//               print(ret.rejected?.first.number);
//               print('ok');
//
//               ///loadData (ontrollerData.register)
//               if (controllerData.register[i].accepted.first.number
//                   .contains(ret.rejected?.first.number)) {
//                 num = 1;
//                 print(
//                     'ваш номер был зарегистрирован в базе, информацию по нему можете посмотреть в ваших посылках)');
//
//                 Get.snackbar('Tracker Parcel',
//                     'ваш номер был зарегистрирован в базе,\информациюпо нему можете посмотреть в ваших посылках');
//               }
//             }
//             if (num != 1) {
//               await carrierIdentify(ret.rejected!.first.number.toString());
//               print('num !=1');
//             }
//           } else {
//             print('этот номер есть в базе, но в листе его нет');
//             print('register пуст');
//             await carrierIdentify(ret.rejected!.first.number.toString());
//           }
//           // SB071931150LV  12021
//           // LB013603058CN  3011
//           // LV336687519CN  3011
//         }
//         if (ret.rejected?.first.error?.code != -18019903 &&
//             ret.rejected?.first.error?.code != -18010012 &&
//             ret.rejected?.first.error?.code != -18019901) {
//           print('ошибка');
//           print(ret.rejected?.first.error?.code);
//           print(ret.rejected?.first.error?.message);
//           Get.snackbar('Tracker Parcel', 'Номер некорректный');
//         }
//       } else {
//         // await saveData(
//         //     'register_${ret.accepted?.first.number}', ret.accepted?.single);
//         // await loadData('register_${ret.accepted?.first.number}');
//         print(
//             'посылка не была зарегистраирована ни этим понльзователем ни кем либо еще');
//
//         ///add (ontrollerData.register)
//         ///
//         ///
//         // print('1');
//         // saveData('register', 'qwer', Data1);
//         // print('2');
//         // loadData();
//         // print('3');
//
//         controllerData.register.add(ret);
//         print(controllerData.register.length);
//         print(controllerData.register.last.accepted?.first?.number);
//
//         ///loadData (ontrollerData.register)
//         await infoAboutParcel(
//             number: controllerData.register.last.accepted?.first?.number,
//             carrier: controllerData.register.last.accepted?.first?.carrier);
//         print('register parcel');
//         //Get.snackbar('Tracker Parcel', 'Ваша посылка была успешно добавлена');
//       }
//     } else {
//       print(response.statusCode);
//       print('Erroor');
//       print(response.body);
//       throw ServerException();
//     }
//     return 1;
//   }
//
//   @override
//   Future<String?> infoAboutParcel({String? number, int? carrier}) async {
//     final box = GetStorage('MyStorage');
//     var client = http.Client();
//     var response;
//     if ((number == null && carrier == null) || number == null) {
//       print('no number carrieer');
//       List listOfNumbers = box.read('numbers');
//       List listOfCarriers = box.read('carrier');
//       if (listOfNumbers.isNotEmpty) {
//         for (int i = 0; i < listOfNumbers.length; i++) {
//           response = await client.post(
//               Uri.parse('https://api.17track.net/track/v1/gettrackinfo'),
//               headers: {'17token': '$key', 'Content-Type': 'application/json'},
//               body:
//                   "[{'number': '${listOfNumbers[i]}', 'carrier': '${listOfCarriers[i].toString()}'}]");
//           if (response.statusCode == 200) {
//             var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes))
//                 as Map<String, dynamic>;
//             var ret = Data2.fromJson(decodedResponse['data']);
//             //loadData('register_${ret.accepted?.first?.number}');
//             if (ret.accepted?.length == 0) {
//               controllerData.bed.add(ret);
//               // SB071931150LV  12021
//               // LB013603058CN  3011
//               // LV336687519CN  3011
//               print('No tracking information at this time.');
//               Get.snackbar(
//                   'Tracker Parcel', 'No tracking information at this time.');
//               return 'error';
//             } else {
//               //await loadData1('info');
//               if (controllerData.infoParcel.isNotEmpty) {
//                 print('not Empty');
//                 for (int r = 0; r < controllerData.infoParcel.length; r++) {
//                   if (controllerData.infoParcel[r].accepted.first.number ==
//                       ret.accepted?.first?.number) {
//                     print('rrrrrr $r');
//                     print(controllerData.infoParcel.length);
//
//                     ///remove (ontrollerData.infoParcel)
//                     controllerData.infoParcel.removeAt(r);
//                     print(controllerData.infoParcel.length);
//
//                     ///add (ontrollerData.infoParcel)
//                     controllerData.infoParcel.add(ret);
//                     print(controllerData.infoParcel.length);
//                     print('обновили');
//
//                     //
//                     print('ppppppppppppppppppppppppppppppppppppppppppppp1');
//                     print(controllerData.infoParcel[r].accepted.first.number);
//                   } else {
//                     controllerData.infoParcel.add(ret);
//                     print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa1');
//                     print(controllerData.infoParcel[r].accepted.first.number);
//                   }
//                 }
//                 // return 'has data';
//               } else {
//                 print('was empry');
//                 controllerData.infoParcel.add(ret);
//                 // return 'has data';
//               }
//               //return 'has data';
//               // return 'has data';
//               //     controllerData.infoParcel.accepted.first.number ==
//               //     ret.accepted?.first?.number
//               //       print('ppppppppppppppppppppppppppppppppppppppppppppp');
//               //     } else {
//               //   controllerData.infoParcel.add(ret);
//               // })
//
//             }
//           } else {
//             print(response.statusCode);
//             print(response.body);
//             //throw ServerException();
//             return 'error';
//           }
//         }
//         return 'has data';
//       }
//       return 'has data';
//     } else {
//       print('has number carrieer');
//       response = await client.post(
//           Uri.parse('https://api.17track.net/track/v1/gettrackinfo'),
//           headers: {'17token': '$key', 'Content-Type': 'application/json'},
//           body: "[{'number': '$number', 'carrier': '${carrier.toString()}'}]");
//       if (response.statusCode == 200) {
//         var decodedResponse =
//             jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
//         //print(decodedResponse);
//         var ret = Data2.fromJson(decodedResponse['data']);
//
//         // print('cool');
//         // print(ret);
//         //loadData('register_${ret.accepted?.first?.number}');
//         if (ret.accepted?.length == 0) {
//           for (int n = 0; n < 100; n++) {
//             print('no tracing repet $n');
//             response = await client.post(
//                 Uri.parse('https://api.17track.net/track/v1/gettrackinfo'),
//                 headers: {
//                   '17token': '$key',
//                   'Content-Type': 'application/json'
//                 },
//                 body:
//                     "[{'number': '$number', 'carrier': '${carrier.toString()}'}]");
//             if (response.statusCode == 200) {
//               var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes))
//                   as Map<String, dynamic>;
//               //print(decodedResponse);
//               var ret = Data2.fromJson(decodedResponse['data']);
//               if (ret.accepted?.length != 0) {
//                 await saveData1(number, carrier!);
//                 //await loadData1('info');
//                 print('save 21111');
//
//                 if (controllerData.infoParcel.isNotEmpty) {
//                   print('not Empty');
//                   for (int r = 0; r < controllerData.infoParcel.length; r++) {
//                     if (controllerData.infoParcel[r].accepted.first.number ==
//                         ret.accepted?.first?.number) {
//                       print(controllerData.infoParcel.length);
//
//                       ///remove (ontrollerData.infoParcel)
//                       controllerData.infoParcel.removeAt(r);
//                       print(controllerData.infoParcel.length);
//
//                       ///add (ontrollerData.infoParcel)
//                       controllerData.infoParcel.add(ret);
//                       print(controllerData.infoParcel.length);
//                       print('обновили');
//
//                       //
//                       print('ppppppppppppppppppppppppppppppppppppppppppppp2');
//                     }
//                   }
//                   return 'has data';
//                 } else {
//                   print('was empry');
//                   controllerData.infoParcel.add(ret);
//                   return 'has data';
//                 }
//
//                 break;
//
//                 //
//                 // if (controllerData.infoParcel.contains(ret)) {
//                 //   print('no pppppppppppppppppppppp');
//                 // } else {
//                 //   controllerData.infoParcel.add(ret);
//                 // }
//
//               }
//             }
//           }
//
//           // controllerData.bed.add(ret);
//           // for(int n =0 ; n<40 ; n++){
//           //
//           // }
//           // // SB071931150LV  12021
//           // // LB013603058CN  3011
//           // // LV336687519CN  3011
//           // Get.snackbar(
//           //     'Tracker Parcel', 'No tracking information at this time.');
//           // return 'error';
//         } else {
//           await saveData1(number, carrier!);
//           //await loadData1('info');
//           print('save 21111');
//
//           if (controllerData.infoParcel.isNotEmpty) {
//             print('not Empty');
//             for (int r = 0; r < controllerData.infoParcel.length; r++) {
//               if (controllerData.infoParcel[r].accepted.first.number ==
//                   ret.accepted?.first?.number) {
//                 print(controllerData.infoParcel.length);
//
//                 ///remove (ontrollerData.infoParcel)
//                 controllerData.infoParcel.removeAt(r);
//                 print(controllerData.infoParcel.length);
//
//                 ///add (ontrollerData.infoParcel)
//                 controllerData.infoParcel.add(ret);
//                 print(controllerData.infoParcel.length);
//                 print('обновили');
//
//                 //
//                 print('ppppppppppppppppppppppppppppppppppppppppppppp');
//               }
//             }
//           } else {
//             print('was empry');
//             controllerData.infoParcel.add(ret);
//           }
//           return 'has data';
//
//           //
//           // if (controllerData.infoParcel.contains(ret)) {
//           //   print('no pppppppppppppppppppppp');
//           // } else {
//           //   controllerData.infoParcel.add(ret);
//           // }
//
//         }
//       } else {
//         print(response.statusCode);
//         print(response.body);
//         //throw ServerException();
//         return 'error';
//       }
//     }
//   }

//
// @override
// Future updateInfoAboutParcel() async {
//   var client = http.Client();
//
//   ///loadData (ontrollerData.register)
//   for (int i = 0; i < controllerData.register.length; i++) {
//     final request = await client.post(
//         Uri.parse('https://api.17track.net/track/v1/gettrackinfo'),
//         headers: {'17token': '$key', 'Content-Type': 'application/json'},
//
//         ///loadData (ontrollerData.register)
//         body:
//             "[{'number': '${controllerData.register[i].accepted.first.number}', 'carrier': '${controllerData.register[i].accepted.first.carrier.toString()}'}]");
//     if (request.statusCode == 200) {
//       var decodedResponse =
//           jsonDecode(utf8.decode(request.bodyBytes)) as Map<String, dynamic>;
//       print(decodedResponse);
//       var ret = Data2.fromJson(decodedResponse['data']);
//       print('cool');
//       if (ret.accepted?.length == 0) {
//         print('0000000000000000000');
//       } else {
//         if (ret.accepted?.first?.track?.firstCarrierEvent?.length != 0 ||
//             ret.accepted?.first?.track?.secondCarrierEvent?.length != 0) {
//           ///loadData (ontrollerData.infoParcel)
//           if (controllerData.infoParcel.length ==
//               controllerData.register.length) {
//             ///loadData (ontrollerData.infoParcel)
//             for (int i = 0; i < controllerData.infoParcel.length; i++) {
//               print(1111);
//               print(controllerData.infoParcel[i].accepted.first.number);
//               print(ret.accepted?.first?.number);
//               print('ok');
//
//               ///loadData (ontrollerData.infoParcel)
//               if (controllerData.infoParcel[i].accepted.first.number ==
//                   ret.accepted?.first?.number) {
//                 print(controllerData.infoParcel.length);
//
//                 ///remove (ontrollerData.infoParcel)
//                 controllerData.infoParcel.removeAt(i);
//                 print(controllerData.infoParcel.length);
//
//                 ///add (ontrollerData.infoParcel)
//                 controllerData.infoParcel.add(ret);
//                 print(controllerData.infoParcel.length);
//                 print('обновили');
//                 break;
//               }
//             }
//           } else {
//             ///loadData (ontrollerData.infoParcel)
//             for (int i = 0; i < controllerData.infoParcel.length; i++) {
//               print(1111);
//               print(controllerData.infoParcel[i].accepted.first.number);
//               print(ret.accepted?.first?.number);
//               print('ok');
//
//               ///loadData (ontrollerData.infoParcel)
//               if (controllerData.infoParcel[i].accepted.first.number ==
//                   ret.accepted?.first?.number) {
//                 print(controllerData.infoParcel.length);
//
//                 ///remove (ontrollerData.infoParcel)
//                 controllerData.infoParcel.removeAt(i);
//                 print(controllerData.infoParcel.length);
//
//                 ///add (ontrollerData.infoParcel)
//                 controllerData.infoParcel.add(ret);
//                 print(controllerData.infoParcel.length);
//                 print('обновили');
//                 break;
//               }
//             }
//
//             ///loadData (ontrollerData.bed)
//             for (int i = 0; i < controllerData.bed.length; i++) {
//               print(controllerData.bed[i].rejected.first.number);
//               print(ret.accepted?.first?.number);
//               print('ok');
//
//               ///loadData (ontrollerData.bed)
//               if (controllerData.bed[i].rejected.first.number ==
//                   ret.accepted?.first?.number) {
//                 print(controllerData.infoParcel.length);
//
//                 /// add (ontrollerData.infoParcel)
//                 controllerData.infoParcel.add(ret);
//
//                 /// remove (ontrollerData.bed)
//                 controllerData.bed.removeAt(i);
//                 print(controllerData.infoParcel.length);
//                 print(controllerData.bed.length);
//                 print('oбновили');
//                 break;
//               }
//             }
//           }
//         }
//       }
//       print(ret);
//     } else {
//       print(request.statusCode);
//       print(request.body);
//       throw ServerException();
//     }
//   }
//   Get.snackbar('Tracker Parcel', 'Обновили');
// }

//
//   @override
//   Future<int> carrierIdentify(String number) async {
//     final response = await http.post(
//         Uri.parse('https://api.17track.net/track/v1/carrierIdentify'),
//         headers: {'17token': '$key', 'Content-Type': 'application/json'},
//         body: "[{'number': '$number'}]");
//     if (response.statusCode == 200) {
//       var decodedResponse =
//           jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
//       print(decodedResponse);
//       var ret = Data1.fromJson(decodedResponse['data']);
//       print('cool');
//       if (ret.accepted?.length != 0) {
//         ///add (ontrollerData.register)
//         controllerData.register.add(ret);
//         print(controllerData.register.length);
//         print(controllerData.register.last.accepted?.first?.number);
//         print('no');
//         Get.snackbar('Tracker Parcel', 'Ваша посылка была успешно добавлена');
//
//         ///loadData (ontrollerData.register)
//         await infoAboutParcel(
//             number: controllerData.register.last.accepted?.first?.number,
//             carrier: controllerData.register.last.accepted?.first?.carrier);
//       } else {
//         print('accepted.leangt == 0');
//       }
//     } else {
//       print(response.statusCode);
//       print('Erroor');
//       print(response.body);
//       throw ServerException();
//     }
//     return 1;
//   }
// }
//
// class ServerException implements Exception {}
