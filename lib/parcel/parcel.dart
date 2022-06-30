import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:tracker_pkg/auth/auth_service.dart';
import 'package:tracker_pkg/auth/authgoogle.dart';
import 'package:tracker_pkg/const/color.dart';
import 'package:tracker_pkg/const/styless.dart';
import 'package:tracker_pkg/data/datasources/data.dart';
import 'package:tracker_pkg/data/datasources/data_source.dart';
import 'package:tracker_pkg/location/adding_screen.dart';
import 'package:tracker_pkg/location/following.dart';
import 'package:tracker_pkg/parcel/parcel_widget.dart';
import 'package:tracker_pkg/widget/dropdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracker_pkg/widget/refresh_widget.dart';

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Все посылки"), value: "Все посылки"),
    DropdownMenuItem(
        child: Text("В процессе доставки"), value: "В процессе доставки"),
    DropdownMenuItem(child: Text("Доставлено"), value: "Доставлено"),
    //DropdownMenuItem(child: Text("Не найдено"), value: "Не найдено"),
  ];
  return menuItems;
}

String selectedValue = "Все посылки";

int tr = 2;
var time = '${DateTime.now().hour}:${DateTime.now().minute}';

class ParselScreen extends StatefulWidget {
  const ParselScreen({Key? key}) : super(key: key);

  @override
  State<ParselScreen> createState() => _ParselScreenState();
}

class _ParselScreenState extends State<ParselScreen> {
  final dataLocator = Get.put(DataSource());
  ScrollController? _controller;
  String message = "";
  List listOfNumbers = [];
  List listOfNumbersDelivered = [];
  List listOfNumbersDelivering = [];
  final box = GetStorage('MyStorage');

  //
  // _scrollListener() {
  //   if (_controller!.offset >= _controller!.position.maxScrollExtent &&
  //       !_controller!.position.outOfRange) {
  //     setState(() {
  //       message = "reach the bottom";
  //     });
  //   }
  //   if (_controller!.offset <= _controller!.position.minScrollExtent &&
  //       !_controller!.position.outOfRange) {
  //     setState(() {
  //       message = "reach the top";
  //     });
  //   }
  // }

  @override
  void initState() {
    // _controller = ScrollController();
    // //loadList()
    // _refresh();
    // _controller!.addListener(_scrollListener);
    //dataLocator.loadData();
    //print(box.read('info'));
    box.writeIfNull('numbers', listOfNumbers);
    listOfNumbers = box.read('numbers');

    box.writeIfNull('numbersDelivering', listOfNumbersDelivering);
    listOfNumbersDelivering = box.read('numbersDelivering');

    box.writeIfNull('numbersDelivered', listOfNumbersDelivered);
    listOfNumbersDelivered = box.read('numbersDelivered');

    // NetworkService()
    //     .infoAboutParcel();

    super.initState();
  }

  Future<void> _refresh() async {
    try {
      await NetworkService().infoAboutParcel();
      time = '${DateTime.now().hour}:${DateTime.now().minute}';
      setState(() {
        controllerData.infoParcel.length;
      });
    } catch (e) {
      print('i try');
    }

    // return Future.delayed(Duration(seconds: 400));
    // data = controllerData.infoParcel;
    // setState(() => this.data = data);
  }

  @override
  void dispose() {
    // _controller!.removeListener(_scrollListener);
    // _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final provider = Provider.of<GoogleSingInPro>(context, listen: false);
    // var time = '${DateTime.now().hour}:${DateTime.now().minute}';

    /// accepted пуст
    // SB071931150LV  12021 z1
    // LB013603058CN  3011  z1 z2
    // LV336687519CN  3011 z1 z2

    return Scaffold(
      backgroundColor: kbgc,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Посылки',
          style: kTextAppBar,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () =>
                showDialog(context: context, builder: (_) => dialog(context)),
            icon: Icon(
              Icons.notifications,
              color: kTextColor,
              size: 27,
            ),
          ),
        ],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: kTextColor,
            size: 27,
          ),
          onPressed: () {},
          //=> Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 11.h,
              ),
              Container(
                //height: 47.h,
                width: 361.w,
                margin: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      // hintText: 'filtr',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      // border: OutlineInputBorder(
                      //   borderSide: BorderSide(color: Colors.white, width: 2),
                      //   borderRadius: BorderRadius.circular(20),
                      // ),
                      //filled: true,
                      //fillColor: Colors.white,
                    ),
                    dropdownColor: Colors.white,
                    value: selectedValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue!;
                      });
                    },
                    items: dropdownItems),
              ),
              //DropButton(),
              selectedValue == 'Все посылки'
                  ? SizedBox(
                      height: 450,
                      // child: controllerData.infoParcel.isNotEmpty || tr == 1
                      //     ? Center(child: CircularProgressIndicator())
                      child: RefreshWidget(
                        //triggerMode: RefreshIndicatorTriggerMode.onEdge,
                        onRefresh: _refresh,
                        child: FutureBuilder(
                          future: NetworkService().infoAboutParcel(),
                          builder: (context, snapshot) {
                            if (snapshot.data == 'hes data') {
                              return ListView.builder(
                                controller: _controller,
                                physics: AlwaysScrollableScrollPhysics(),
                                // scrollDirection: Axis.vertical,
                                shrinkWrap: false,
                                primary: true,
                                itemCount: listOfNumbers.length,
                                itemBuilder: (BuildContext context, int index) {
                                  det() {
                                    print(
                                        'infoParsel : ${controllerData.infoParcel[index].accepted.first}');
                                    if (controllerData
                                            .infoParcel[index]
                                            .accepted
                                            .first
                                            .track
                                            .secondCarrierEvent
                                            .length ==
                                        0) {
                                      return 1;
                                    } else {
                                      return 2;
                                    }
                                  }

                                  var current = controllerData
                                      .infoParcel[index].accepted?.first;
                                  DateTime tempData = DateTime.parse(det() == 1
                                      ? current
                                          .track.firstCarrierEvent[0].eventTime
                                      : current.track.secondCarrierEvent[0]
                                          .eventTime);

                                  return GestureDetector(
                                    onTap: () {
                                      final box = GetStorage('MyStorage');
                                      print('data: ${box.read('info')}');
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Following(
                                            indexParcel: index,
                                          ),
                                        ),
                                      );
                                    },
                                    child: ParselWidget(
                                      text: current.number,
                                      time:
                                          '${tempData.day}.${tempData.month.toString().length == 1 ? "0${tempData.month}" : tempData.month}',
                                      upgrade: time.toString(),
                                      where: det() == 1
                                          ? current.track.firstCarrierEvent[0]
                                              .eventContent
                                          : current.track.secondCarrierEvent[0]
                                              .eventContent,
                                    ),
                                  );
                                },
                              );
                            } else if (snapshot.data == 'error') {
                              return Text(
                                'Произошла ошибка',
                                style: kTextAppBar,
                              );
                            } else if (listOfNumbers.isNotEmpty) {
                              return Center(child: CircularProgressIndicator());
                            } else {
                              return Center(child: Text('ADD PARCEl'));
                            }
                          },
                        ),
                      ),
                    )
                  : selectedValue == 'В процессе доставки'
                      ? SizedBox(
                          height: 450,
                          // child: controllerData.infoParcel.isNotEmpty || tr == 1
                          //     ? Center(child: CircularProgressIndicator())
                          child: listOfNumbersDelivering.isEmpty
                              ? Text('Empty')
                              : RefreshWidget(
                                  //triggerMode: RefreshIndicatorTriggerMode.onEdge,
                                  onRefresh: _refresh,
                                  child: FutureBuilder(
                                    future: NetworkService().infoAboutParcel(),
                                    builder: (context, snapshot) {
                                      if (snapshot.data == 'hes data') {
                                        return ListView.builder(
                                          controller: _controller,
                                          physics:
                                              AlwaysScrollableScrollPhysics(),
                                          // scrollDirection: Axis.vertical,
                                          shrinkWrap: false,
                                          primary: true,
                                          itemCount:
                                              listOfNumbersDelivering.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            det() {
                                              print(
                                                  'infoParsel : ${controllerData.infoParcelDelivering[index].accepted.first}');
                                              if (controllerData
                                                      .infoParcelDelivering[
                                                          index]
                                                      .accepted
                                                      .first
                                                      .track
                                                      .secondCarrierEvent
                                                      .length ==
                                                  0) {
                                                return 1;
                                              } else {
                                                return 2;
                                              }
                                            }

                                            var current = controllerData
                                                .infoParcelDelivering[index]
                                                .accepted
                                                ?.first;
                                            DateTime tempData = DateTime.parse(
                                                det() == 1
                                                    ? current
                                                        .track
                                                        .firstCarrierEvent[0]
                                                        .eventTime
                                                    : current
                                                        .track
                                                        .secondCarrierEvent[0]
                                                        .eventTime);

                                            return GestureDetector(
                                              onTap: () {
                                                final box =
                                                    GetStorage('MyStorage');
                                                print(
                                                    'data: ${box.read('info')}');
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        FollowingDelivering(
                                                      indexParcel: index,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: ParselWidget(
                                                text: current.number,
                                                time:
                                                    '${tempData.day}.${tempData.month.toString().length == 1 ? "0${tempData.month}" : tempData.month}',
                                                upgrade: time.toString(),
                                                where: det() == 1
                                                    ? current
                                                        .track
                                                        .firstCarrierEvent[0]
                                                        .eventContent
                                                    : current
                                                        .track
                                                        .secondCarrierEvent[0]
                                                        .eventContent,
                                              ),
                                            );
                                          },
                                        );
                                      } else if (snapshot.data == 'error') {
                                        return Text(
                                          'Произошла ошибка',
                                          style: kTextAppBar,
                                        );
                                      } else if (listOfNumbers.isNotEmpty) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      } else {
                                        return Center(
                                            child: Text('ADD PARCEl'));
                                      }
                                    },
                                  ),
                                ),
                        )
                      : selectedValue == 'Доставлено'
                          ? SizedBox(
                              height: 450,
                              // child: controllerData.infoParcel.isNotEmpty || tr == 1
                              //     ? Center(child: CircularProgressIndicator())
                              child: listOfNumbersDelivered.isEmpty
                                  ? Text('Empty')
                                  : RefreshWidget(
                                      //triggerMode: RefreshIndicatorTriggerMode.onEdge,
                                      onRefresh: _refresh,
                                      child: FutureBuilder(
                                        future:
                                            NetworkService().infoAboutParcel(),
                                        builder: (context, snapshot) {
                                          if (snapshot.data == 'hes data') {
                                            return ListView.builder(
                                              controller: _controller,
                                              physics:
                                                  AlwaysScrollableScrollPhysics(),
                                              // scrollDirection: Axis.vertical,
                                              shrinkWrap: false,
                                              primary: true,
                                              itemCount:
                                                  listOfNumbersDelivered.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                det() {
                                                  print(
                                                      'infoParsel : ${controllerData.infoParcelDelivered[index].accepted.first}');
                                                  if (controllerData
                                                          .infoParcelDelivered[
                                                              index]
                                                          .accepted
                                                          .first
                                                          .track
                                                          .secondCarrierEvent
                                                          .length ==
                                                      0) {
                                                    return 1;
                                                  } else {
                                                    return 2;
                                                  }
                                                }

                                                var current = controllerData
                                                    .infoParcelDelivered[index]
                                                    .accepted
                                                    ?.first;
                                                DateTime tempData =
                                                    DateTime.parse(det() == 1
                                                        ? current
                                                            .track
                                                            .firstCarrierEvent[
                                                                0]
                                                            .eventTime
                                                        : current
                                                            .track
                                                            .secondCarrierEvent[
                                                                0]
                                                            .eventTime);

                                                return GestureDetector(
                                                  onTap: () {
                                                    final box =
                                                        GetStorage('MyStorage');
                                                    print(
                                                        'data: ${box.read('info')}');
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            FollowingDelivered(
                                                          indexParcel: index,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: ParselWidget(
                                                    text: current.number,
                                                    time:
                                                        '${tempData.day}.${tempData.month.toString().length == 1 ? "0${tempData.month}" : tempData.month}',
                                                    upgrade: time.toString(),
                                                    where: det() == 1
                                                        ? current
                                                            .track
                                                            .firstCarrierEvent[
                                                                0]
                                                            .eventContent
                                                        : current
                                                            .track
                                                            .secondCarrierEvent[
                                                                0]
                                                            .eventContent,
                                                  ),
                                                );
                                              },
                                            );
                                          } else if (snapshot.data == 'error') {
                                            return Text(
                                              'Произошла ошибка',
                                              style: kTextAppBar,
                                            );
                                          } else if (listOfNumbers.isNotEmpty) {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          } else {
                                            return Center(
                                                child: Text('ADD PARCEl'));
                                          }
                                        },
                                      ),
                                    ),
                            )
                          : Text('no state'),

              SizedBox(
                height: 17.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
