import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:purchases_flutter/purchases_flutter.dart';

enum Entitlement { free, premium }

class RevenueCatProvider extends GetxController {
  Entitlement _entitlement = Entitlement.free;
  Entitlement get entitlement => _entitlement;

  Future init() async {
    Purchases.addPurchaserInfoUpdateListener((purchaserInfo) async {
      updatePurchaseStatus();
    });
  }

  Future updatePurchaseStatus() async {
    final purchaserInfo = await Purchases.getPurchaserInfo();
    final entitlements = purchaserInfo.entitlements.active.values.toList();
    _entitlement =
        entitlements.isEmpty ? Entitlement.free : Entitlement.premium;
    update();
  }

  @override
  void onInit() {
    init();
    super.onInit();
  }
}
