import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tracker_pkg/const/color.dart';
import 'package:tracker_pkg/data/datasources/data.dart';
import 'package:tracker_pkg/data/datasources/data_source.dart';
import 'package:tracker_pkg/location/adding_screen.dart';
import 'package:tracker_pkg/logic/barcode.dart';
import 'package:tracker_pkg/location/track_follow.dart';
import 'package:tracker_pkg/widget/button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Following extends StatelessWidget {
  //String number;
  int indexParcel;

  Following({required this.indexParcel});

  List<String> months = [
    'January  ',
    'February',
    'March    ',
    'April    ',
    'May      ',
    'June     ',
    'July     ',
    'August   ',
    'September',
    'October  ',
    'November ',
    'December '
  ];

  //final NetworkService personService = NetworkService();

  // Future<Object> Function(String number) info;
  // Following({required this.info});
  //int lengt;

  det() {
    if (infoParcel[indexParcel]
            .accepted
            .first
            .track
            .secondCarrierEvent
            .toList()
            .length ==
        0) {
      return 1;
    } else {
      return 2;
    }
  }

  inf() {
    if (infoParcel[indexParcel]
            .accepted
            .first
            .track
            .secondCarrierEvent
            .toList()
            .length ==
        0) {
      return infoParcel[indexParcel]
              .accepted
              .first
              .track
              .firstCarrierEvent
              .toList()
              .length -
          1;
    } else {
      return infoParcel[indexParcel]
              .accepted
              .first
              .track
              .secondCarrierEvent
              .toList()
              .length -
          1;
    }
  }

  // len() {
  //   if(det() == 1){
  //     lengt = infoParcel[indexParcel]
  //         .accepted
  //         .first
  //         .track
  //         .secondCarrierEvent
  //         .toList()
  //         .length;
  //   } else {
  //     lengt = infoParcel[indexParcel]
  //         .accepted
  //         .first
  //         .track
  //         .secondCarrierEvent
  //         .toList()
  //         .length;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbgc,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Отслеживание',
          style: TextStyle(
              color: Color(0xff666E6D),
              fontSize: 24,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.normal),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () =>
                showDialog(context: context, builder: (_) => dialog(context)),
            icon: Icon(
              Icons.notifications,
              color: Color(0xff666E6D),
              size: 27,
            ),
          ),
        ],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xff666E6D),
            size: 27,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              left: 25.w,
              right: 25.w,
              top: 16.h,
              bottom: 23.h,
            ),
            height: 44.h,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(80)),
            child: Center(
              child: Text(
                infoParcel[indexParcel].accepted.first.number,
                //'${context.watch<LogicBarCode>().scanValue}',
                style: TextStyle(fontSize: 22.sp, color: kTextColor),
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          // Text(
          //   '',
          //   style: TextStyle(fontSize: 25.sp, color: kTextColor),
          // ),
          SizedBox(
            height: 700.h,
            child: ListView.builder(
              itemCount: det() == 1
                  ? infoParcel[indexParcel]
                      .accepted
                      .first
                      .track
                      .firstCarrierEvent
                      .toList()
                      .length
                  : infoParcel[indexParcel]
                      .accepted
                      .first
                      .track
                      .secondCarrierEvent
                      .toList()
                      .length,
              itemBuilder: (BuildContext context, int index) {
                var current = det() == 1
                    ? infoParcel[indexParcel]
                        .accepted
                        .first
                        .track
                        .firstCarrierEvent[index]
                    : infoParcel[indexParcel]
                        .accepted
                        .first
                        .track
                        .secondCarrierEvent[index];
                DateTime tempData = DateTime.parse(current.eventTime);
                return Column(
                  children: [
                    index == 0
                        ? FollowContainer(
                            month: months[tempData.month - 1],
                            date: tempData.day.toString(),
                            locate: current.eventLocation,
                            maintext: current.eventContent,
                            updash: Container(
                              height: 35,
                              width: 2,
                              color: Colors.white,
                            ),
                          )
                        : SizedBox(),
                    index != 0 && index != inf()
                        // infoParcel[indexParcel]
                        //         .accepted
                        //         .first
                        //         .track
                        //         .firstCarrierEvent
                        //         .toList()
                        //         .length -
                        //     1
                        ? FollowContainer(
                            month: months[tempData.month - 1],
                            date: tempData.day.toString(),
                            locate: current.eventLocation,
                            maintext: current.eventContent,
                          )
                        : SizedBox(),
                    index == inf()
                        // infoParcel[indexParcel]
                        //         .accepted
                        //         .first
                        //         .track
                        //         .firstCarrierEvent
                        //         .toList()
                        //         .length -
                        //     1
                        ? FollowContainer(
                            month: months[tempData.month - 1],
                            date: tempData.day.toString(),
                            locate: current.eventLocation,
                            maintext: current.eventContent,
                            downdash: Container(
                              height: 35,
                              width: 2,
                              color: Colors.white,
                            ))
                        : SizedBox(),
                  ],
                );
              },
            ),
          ),
          // SizedBox(
          //   height: 22.h,
          // ),
          // FollowContainer(
          //   maintext: 'Доставлено',
          //   updash: Container(
          //     height: 35,
          //     width: 2,
          //     color: Colors.white,
          //   ),
          // ),
          // FollowContainer(
          //   locate: '',
          //   maintext: 'Неизвестная ошибка',
          //   dateOrWidget: Icon(
          //     Icons.help_outline,
          //     color: Color(0xff666E6D),
          //     size: 26,
          //   ),
          // ),
          // FollowContainer(
          //   maintext:
          //       'Прибыло в сортировочный центр страны назначения ',
          //   date: '13',
          // ),
          // FollowContainer(
          //   maintext: 'Передано в доставку Беларуси',
          //   date: '12',
          //   locate: '',
          // ),
          // FollowContainer(
          //   maintext: 'Выпущено таможней (0. 05 кг)',
          //   date: '12',
          //   locate: 'Брест, Беларусь',
          // ),
          // FollowContainer(
          //   maintext: 'Прием на таможню (0. 05 кг)',
          //   date: '7',
          //   locate: 'Брест, Беларусь',
          // ),
          // FollowContainer(
          //     maintext: 'Прошло регистрацию',
          //     date: '2',
          //     locate: 'Варшава, Польша',
          //     downdash: Container(
          //       height: 35,
          //       width: 2,
          //       color: Colors.white,
          //     )),
        ],
      ),
    );
  }
}

//
// class Following extends StatelessWidget {
//   String number;
//   Following({required this.number});
//   List<String> months = [
//     'January  ',
//     'February',
//     'March    ',
//     'April    ',
//     'May      ',
//     'June     ',
//     'July     ',
//     'August   ',
//     'September',
//     'October  ',
//     'November ',
//     'December '
//   ];
//   final NetworkService personService = NetworkService();
//
//   // Future<Object> Function(String number) info;
//   // Following({required this.info});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kbgc,
//       appBar: AppBar(
//         elevation: 0,
//         title: Text(
//           'Отслеживание',
//           style: TextStyle(
//               color: Color(0xff666E6D),
//               fontSize: 24,
//               fontFamily: 'Roboto',
//               fontWeight: FontWeight.normal),
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             onPressed: () =>
//                 showDialog(context: context, builder: (_) => dialog(context)),
//             icon: Icon(
//               Icons.notifications,
//               color: Color(0xff666E6D),
//               size: 27,
//             ),
//           ),
//         ],
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back_ios,
//             color: Color(0xff666E6D),
//             size: 27,
//           ),
//           onPressed: () => Navigator.pop(context),
//         ),
//         backgroundColor: Colors.transparent,
//       ),
//       body: FutureBuilder(
//           future: personService.infoAboutParcel(number),
//           builder: (BuildContext context, AsyncSnapshot snapshot) {
//             if (snapshot.hasData) {
//               return Column(
//                 children: <Widget>[
//                   Container(
//                     margin: EdgeInsets.only(
//                       left: 25.w,
//                       right: 25.w,
//                       top: 16.h,
//                       bottom: 23.h,
//                     ),
//                     height: 44.h,
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(80)),
//                     child: Center(
//                       child: Text(
//                         number,
//                         //'${context.watch<LogicBarCode>().scanValue}',
//                         style: TextStyle(fontSize: 22.sp, color: kTextColor),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10.h,
//                   ),
//                   // Text(
//                   //   '',
//                   //   style: TextStyle(fontSize: 25.sp, color: kTextColor),
//                   // ),
//                   SizedBox(
//                     height: 700.h,
//                     child: ListView.builder(
//                       itemCount: snapshot
//                           .data.accepted.first.track.firstCarrierEvent
//                           .toList()
//                           .length,
//                       itemBuilder: (BuildContext context, int index) {
//                         var current = snapshot
//                             .data.accepted.first.track.firstCarrierEvent[index];
//                         DateTime tempData = DateTime.parse(current.eventTime);
//                         return Column(
//                           children: [
//                             index == 0
//                                 ? FollowContainer(
//                                     month: months[tempData.month - 1],
//                                     date: tempData.day.toString(),
//                                     locate: current.eventLocation,
//                                     maintext: current.eventContent,
//                                     updash: Container(
//                                       height: 35,
//                                       width: 2,
//                                       color: Colors.white,
//                                     ),
//                                   )
//                                 : SizedBox(),
//                             index != 0 &&
//                                     index !=
//                                         snapshot.data.accepted.first.track
//                                                 .firstCarrierEvent
//                                                 .toList()
//                                                 .length -
//                                             1
//                                 ? FollowContainer(
//                                     month: months[tempData.month - 1],
//                                     date: tempData.day.toString(),
//                                     locate: current.eventLocation,
//                                     maintext: current.eventContent,
//                                   )
//                                 : SizedBox(),
//                             index ==
//                                     snapshot.data.accepted.first.track
//                                             .firstCarrierEvent
//                                             .toList()
//                                             .length -
//                                         1
//                                 ? FollowContainer(
//                                     month: months[tempData.month - 1],
//                                     date: tempData.day.toString(),
//                                     locate: current.eventLocation,
//                                     maintext: current.eventContent,
//                                     downdash: Container(
//                                       height: 35,
//                                       width: 2,
//                                       color: Colors.white,
//                                     ))
//                                 : SizedBox(),
//                           ],
//                         );
//                       },
//                     ),
//                   ),
//                   // SizedBox(
//                   //   height: 22.h,
//                   // ),
//                   // FollowContainer(
//                   //   maintext: 'Доставлено',
//                   //   updash: Container(
//                   //     height: 35,
//                   //     width: 2,
//                   //     color: Colors.white,
//                   //   ),
//                   // ),
//                   // FollowContainer(
//                   //   locate: '',
//                   //   maintext: 'Неизвестная ошибка',
//                   //   dateOrWidget: Icon(
//                   //     Icons.help_outline,
//                   //     color: Color(0xff666E6D),
//                   //     size: 26,
//                   //   ),
//                   // ),
//                   // FollowContainer(
//                   //   maintext:
//                   //       'Прибыло в сортировочный центр страны назначения ',
//                   //   date: '13',
//                   // ),
//                   // FollowContainer(
//                   //   maintext: 'Передано в доставку Беларуси',
//                   //   date: '12',
//                   //   locate: '',
//                   // ),
//                   // FollowContainer(
//                   //   maintext: 'Выпущено таможней (0. 05 кг)',
//                   //   date: '12',
//                   //   locate: 'Брест, Беларусь',
//                   // ),
//                   // FollowContainer(
//                   //   maintext: 'Прием на таможню (0. 05 кг)',
//                   //   date: '7',
//                   //   locate: 'Брест, Беларусь',
//                   // ),
//                   // FollowContainer(
//                   //     maintext: 'Прошло регистрацию',
//                   //     date: '2',
//                   //     locate: 'Варшава, Польша',
//                   //     downdash: Container(
//                   //       height: 35,
//                   //       width: 2,
//                   //       color: Colors.white,
//                   //     )),
//                 ],
//               );
//             }
//             if (snapshot.hasError) {
//               return Text('Something went wrong');
//             }
//             // if (snapshot.has) {
//             //   return Text('f');
//             // }
//             return Center(
//                 child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 CircularProgressIndicator(),
//                 SizedBox(
//                   height: 20.0,
//                 ),
//                 Text("Loading, please wait this may take some time")
//               ],
//             ));
//           }),
//     );
//   }
// }
