import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huawei_iap/huawei_iap.dart';
import 'package:tik_chat_v2/core/service/navigation_service.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/core/widgets/snackbar.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/coins/widgets/coins_tab_view.dart';

// Future<void> getConsumableProducts() async {
//   try {
//     ProductInfoReq req = ProductInfoReq(priceType: IapClient.IN_APP_CONSUMABLE, skuIds: ["20", "21", "22", "23", "24", "25"]);
//
//     ProductInfoResult res = await IapClient.obtainProductInfo(req);
//     CoinsTabView.list = res.productInfoList!;
//
//   } on PlatformException catch (e) {
//     log("e.toString()"+e.toString());
//   }
// }

Future<PurchaseResultInfo?> purchaseConsumableProduct(String productId) async {
  try {
    PurchaseIntentReq req = PurchaseIntentReq(
      priceType: IapClient.IN_APP_CONSUMABLE,
      productId: productId,
    );
    PurchaseResultInfo res = await IapClient.createPurchaseIntent(req);
    return res;
  } on PlatformException catch (e) {
    ScaffoldMessenger.of(
            getIt<NavigationService>().navigatorKey.currentContext!)
        .showSnackBar(errorSnackBar(
            getIt<NavigationService>().navigatorKey.currentContext!,
            e.message.toString()));
    return null;
  }
}
