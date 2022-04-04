import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tracker_pkg/auth/auth_service.dart';
import 'package:tracker_pkg/auth/authgoogle.dart';
import 'package:tracker_pkg/const/color.dart';
import 'package:tracker_pkg/const/styless.dart';
import 'package:tracker_pkg/data/datasources/data_source.dart';
import 'package:tracker_pkg/location/adding_screen.dart';
import 'package:tracker_pkg/location/following.dart';
import 'package:tracker_pkg/parsel/parsel_widget.dart';
import 'package:tracker_pkg/widget/dropdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

var time = '${DateTime.now().hour}:${DateTime.now().minute}';

class ParselScreen extends StatefulWidget {
  const ParselScreen({Key? key}) : super(key: key);

  @override
  State<ParselScreen> createState() => _ParselScreenState();
}

class _ParselScreenState extends State<ParselScreen> {
  ScrollController? _controller;
  String message = "";

  _scrollListener() {
    if (_controller!.offset >= _controller!.position.maxScrollExtent &&
        !_controller!.position.outOfRange) {
      setState(() {
        message = "reach the bottom";
      });
    }
    if (_controller!.offset <= _controller!.position.minScrollExtent &&
        !_controller!.position.outOfRange) {
      setState(() {
        message = "reach the top";
      });
    }
  }

  @override
  void initState() {
    _controller = ScrollController();
    _controller!.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _controller!.removeListener(_scrollListener);
    _controller!.dispose();
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
                Row(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width - 50,
                        child: DropButton()),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          NetworkService().updateInfoAboutParcel();
                          time =
                              '${DateTime.now().hour}:${DateTime.now().minute}';
                          //time = DateTime.now().isUtc;
                        });
                      },
                      icon: Icon(Icons.update),
                    ),
                  ],
                ),
                SizedBox(
                  height: 450,
                  child: ListView.builder(
                    controller: _controller,
                    //shrinkWrap: true,
                    itemCount: controllerData.infoParcel.length,
                    itemBuilder: (BuildContext context, int index) {
                      det() {
                        if (controllerData.infoParcel[index].accepted.first
                                .track.secondCarrierEvent.length ==
                            0) {
                          return 1;
                        } else {
                          return 2;
                        }
                      }

                      var current =
                          controllerData.infoParcel[index].accepted?.first;
                      DateTime tempData = DateTime.parse(det() == 1
                          ? current.track.firstCarrierEvent[0].eventTime
                          : current.track.secondCarrierEvent[0].eventTime);

                      return GestureDetector(
                        onTap: () {
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
                              ? current.track.firstCarrierEvent[0].eventContent
                              : current
                                  .track.secondCarrierEvent[0].eventContent,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 17.h,
                ),
              ],
            ),
          ),
        ));
  }
}
