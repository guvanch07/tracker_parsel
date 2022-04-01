import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
import 'package:tracker_pkg/const/color.dart';
import 'package:provider/provider.dart';
import 'package:tracker_pkg/const/styless.dart';
import 'package:tracker_pkg/data/datasources/data.dart';
import 'package:tracker_pkg/data/datasources/data_source.dart';
import 'package:tracker_pkg/parsel/parsel.dart';
import 'package:tracker_pkg/profile/profile.dart';
import 'package:tracker_pkg/widget/button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../logic/barcode.dart';

class AddNumber extends StatefulWidget {
  const AddNumber({Key? key}) : super(key: key);

  @override
  _AddNumberState createState() => _AddNumberState();
}

class _AddNumberState extends State<AddNumber> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final NetworkService personService = NetworkService();
    return Scaffold(
      backgroundColor: kbgc,
      appBar: AppBar(
        elevation: 0,
        title: Text('Добавление', style: kTextAppBar),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () =>
                showDialog(context: context, builder: (_) => dialog(context)),
            icon: Icon(Icons.notifications, color: kTextColor, size: 27),
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: kTextColor, size: 27),
          onPressed: () {
            print('Pop Adding');
          },
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          top: false,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 114.h,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    context.read<LogicBarCode>().scanQrcode();
                  },
                  child: Container(
                    width: 323.w,
                    height: 281.h,
                    child: Image.asset('assets/Group 64.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 54.h,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(45)),
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: myController,
                  cursorColor: kTextColor,
                  style: kText22,
                  decoration: InputDecoration(
                    hintStyle: kText14,
                    hintText: '  ${context.watch<LogicBarCode>().scanValue}',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      //SB071931150LV
                    ),
                  ),
                ),
              ),
              SizedBox(height: 54.h),
              PrimaryButton(
                  borderradius: 30.r,
                  onPressed: () {
                    //Navigator.pop(context);
                    // Get.snackbar('Well be', 'Данные сохранены',
                    //     snackPosition: SnackPosition.TOP);
                    // final snackBar = SnackBar(
                    //   content: Text('Yay! A SnackBar!'),
                    //   action: SnackBarAction(
                    //     label: 'Undo',
                    //     onPressed: () {},
                    //   ),
                    // );
                    // Get.snackbar(
                    //   'message',
                    //   'message body',
                    //   duration: Duration(seconds: 4),
                    //   animationDuration: Duration(milliseconds: 800),
                    //   snackPosition: SnackPosition.TOP,
                    // );
                    //ScaffoldMessenger.of(context).showSnackBar(Sneck);
                    // print(infoParcel.length);
                    // // print(infoParcel[0]
                    // //     .accepted
                    // //     ?.first
                    // //     ?.track
                    // //     ?.firstCarrierEvent?[0]
                    // //     ?.eventTime);
                    // //print(myController.text);
                    //-18019909
                    if (myController.text.toString().length != 0) {
                      personService.registerParcel(myController.text);
                    } else {
                      print('Введите пожалуйста номер посылки');

                      // Get.snackbar(
                      //   "Подсказка",
                      //   "Введите пожалуйста номер посылки",
                      //   icon: Icon(Icons.person, color: Colors.white),
                      //   snackPosition: SnackPosition.TOP,
                      // );

                      ///ShowSnackBar(введите пожалуста номер посылки)
                    }
                    // // var ret = infoAboutParcel('11');
                    // // print(ret);
                    // //personService.registerParcel('11');
                    // // print(myController.text);
                    // // Navigator.push(
                    // //     context,
                    // //     MaterialPageRoute(
                    // //       builder: (context) =>
                    // //           Following(number: myController.text),
                    // //     ));
                  },
                  text: '+   Добавить')
            ],
          ),
        ),
      ),
    );
  }

  // get() async {
  //   var ret = await infoAboutParcel('11');
  //   return ret;
  // }

//
// Widget textfield() {
//
//   return Container(
//     height: 50,
//     decoration: BoxDecoration(
//         color: Colors.white, borderRadius: BorderRadius.circular(45)),
//     margin: EdgeInsets.symmetric(horizontal: 20),
//     child: TextField(
//       controller: myController,
//       cursorColor: kTextColor,
//       style: kText22,
//       decoration: InputDecoration(
//         hintStyle: kText14,
//         hintText: '  ${context.watch<LogicBarCode>().scanValue}',
//         border: OutlineInputBorder(
//           borderSide: BorderSide.none,
//         ),
//       ),
//     ),
//   );
// }
}

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbgc,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          bottom: 13,
          left: 13,
          right: 13,
        ),
        child: Material(
          //elevation: 10,
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
          child: Container(
            height: 80,
            width: double.infinity,
            child: GestureDetector(
              child: TabBar(
                indicatorColor: Colors.transparent,
                tabs: [
                  Tab(
                    icon: SvgPicture.asset(
                      'assets/one.svg',
                      color:
                          _tabController.index == 0 ? kButton : kBottomButton,
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/two.svg',
                    color: _tabController.index == 1 ? kButton : kBottomButton,
                  ),
                  SvgPicture.asset(
                    'assets/three.svg',
                    color: _tabController.index == 2 ? kButton : kBottomButton,
                  ),
                ],
                controller: _tabController,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: [ParselScreen(), AddNumber(), ProfileScreen()],
        ),
      ),
    );
  }
}

Widget dialog(BuildContext context) {
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    child: Container(
      height: 290.h,
      width: 344.w,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.close,
                size: 30.sp,
              ),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Text(
            'Если у Вас возникли какие-нибудь\nвопросы, напишите нам на почту',
            style: kText16,
            textAlign: TextAlign.center,
          ),
          GestureDetector(
            onTap: () {},
            child: Text('@dgrhrw.',
                style: kText16.copyWith(
                    color: kBlue,
                    decoration: TextDecoration.underline,
                    decorationColor: kBlue)),
          ),
          Text(
            'Наши разработчики незамедлительно\nсвяжутся с Вами ;)',
            style: kText16,
            textAlign: TextAlign.center,
          )
        ],
      ),
    ),
  );
}
