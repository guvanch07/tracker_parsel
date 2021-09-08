import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tracker_pkg/const/color.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'dart:async';

import 'package:tracker_pkg/widget/button.dart';

class AddNumber extends StatefulWidget {
  const AddNumber({Key? key}) : super(key: key);

  @override
  _AddNumberState createState() => _AddNumberState();
}

class _AddNumberState extends State<AddNumber> {
  String _scanBarcode = 'Unknown';

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
            icon: Icon(
              Icons.notification_important,
              color: Color(0xff666E6D),
            ),
          ),
        ],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xff666E6D),
          ),
          onPressed: () {},
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Center(
              child: GestureDetector(
                onTap: () => scanQrcode(),
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
              height: 30,
            ),
            textfield(),
            SizedBox(
              height: 20,
            ),
            PrimaryButton(
                borderradius: 100, onPressed: () {}, text: '+   Добавить')
          ],
        ),
      ),
    );
  }

  Future<void> scanQrcode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Отмена', true, ScanMode.BARCODE);
      if (!mounted) return;
      setState(() {
        this._scanBarcode = qrCode;
      });
    } on PlatformException {
      _scanBarcode = '';
    }
  }

  Widget textfield() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(50)),
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        decoration: InputDecoration(
          hintText: '         Введите номер посылки',
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
                SvgPicture.asset('assets/first.svg'),
                Icon(Icons.ac_unit),
                SvgPicture.asset('assets/person.svg'),
              ],
              labelColor: Colors.black,
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
          children: [AddNumber(), AddNumber(), AddNumber()],
        ),
      ),
    );
  }
}
