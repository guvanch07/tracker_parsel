import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class LogicBarCode extends ChangeNotifier {
  String _scanBarcode = 'Введите номер посылки';

  String get scanValue => _scanBarcode;

  scanQrcode() async {
    await FlutterBarcodeScanner.scanBarcode(
            '#ff6666', 'Отмена', true, ScanMode.BARCODE)
        .then((value) => _scanBarcode = value);
    notifyListeners();
  }
}
