import 'dart:io';

import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

//
// class CoursePaidStatus {
//   static const firstTier = 'paid_course';
//   static const secondTier = 'second_tir';
//   static const thirdTier = 'third_tir';
//
//   static const allIds = [firstTier, secondTier, thirdTier];
// }

class PurchaseApi {
  static const _apiKeyIOS = '';

  /// add apiKey
  static const _apiKeyAndroid = 'goog_DOKlkpaFxlVzvOlXkApNUarXhAv';

  /// add apiKey

  static Future init() async {
    await Purchases.setDebugLogsEnabled(true);
    if (Platform.isIOS) {
      await Purchases.setup(_apiKeyIOS);
    } else {
      await Purchases.setup(_apiKeyAndroid);
    }
  }

  static Future<List<Offering>> fetchOffers() async {
    try {
      final offerings = await Purchases.getOfferings();
      final current = offerings.current;
      return current == null ? [] : [current];
    } on PlatformException catch (e) {
      return [];
    }
  }

  static Future<bool> purchasePackage(Package package) async {
    try {
      await Purchases.purchasePackage(package);
      return true;
    } catch (e) {
      return false;
    }
  }

  // static Future<List<Offering>> fetchOffersByIds(List<String> ids) async {
  //   final offers = await fetchOffers();
  //   return offers.where((offer) => ids.contains(offer.identifier)).toList();
  // }
  //
  // static Future<bool> purchasePackage(Package package) async {
  //   try {
  //     await Purchases.purchasePackage(package);
  //     return true;
  //   } catch (e) {
  //     return false;
  //   }
  // }
}
