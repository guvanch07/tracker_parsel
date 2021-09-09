import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:tracker_pkg/const/color.dart';
import 'package:sizer/sizer.dart';

import 'package:provider/provider.dart';
import 'package:tracker_pkg/parsel/parsel.dart';
import 'package:tracker_pkg/widget/button.dart';

import '../logic/barcode.dart';
import 'following.dart';

class AddNumber extends StatefulWidget {
  const AddNumber({Key? key}) : super(key: key);

  @override
  _AddNumberState createState() => _AddNumberState();
}

class _AddNumberState extends State<AddNumber> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbgc,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Добавление',
          style: TextStyle(
              color: Color(0xff666E6D), fontSize: 24, fontFamily: 'Roboto'),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications, color: Color(0xff666E6D), size: 27),
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Color(0xff666E6D), size: 27),
          onPressed: () {},
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          top: false,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    context.read<LogicBarCode>().scanQrcode();
                  },
                  child: Container(
                    width: 270,
                    height: 250,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white),
                    child: SvgPicture.asset('assets/barcode.svg'),
                  ),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              textfield(),
              SizedBox(
                height: 40,
              ),
              PrimaryButton(
                  borderradius: 100,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Following()),
                    );
                  },
                  text: '+   Добавить')
            ],
          ),
        ),
      ),
    );
  }

  Widget textfield() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(45)),
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        decoration: InputDecoration(
          hintStyle: TextStyle(fontFamily: 'Roboto', fontSize: 14),
          hintText: '  ${context.watch<LogicBarCode>().scanValue}',
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isselected = false;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
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
            child: TabBar(
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(width: 0, color: Colors.transparent),
              ),
              tabs: [
                // SvgPicture.asset(
                //   'assets/first.svg',
                // ),
                Icon(
                  Icons.folder_shared,
                  size: 50,
                ),

                Icon(
                  Icons.add_location_alt_rounded,
                  size: 50,
                ),
                // SvgPicture.asset(
                //   'assets/person.svg',
                // ),
                Icon(
                  Icons.person,
                  size: 50,
                ),
              ],
              labelColor: Color(0xffF57300),
              unselectedLabelColor: Color(0xFF9FABBF),
              indicatorPadding: EdgeInsets.all(2),
              controller: _tabController,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: [ParselScreen(), AddNumber(), AddNumber()],
        ),
      ),
    );
  }
}
