import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:huawei_iap/huawei_iap.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/coins/widgets/coins_tab_view.dart';

Future<void> getConsumableProducts() async {
  try {
    ProductInfoReq req = ProductInfoReq(priceType: IapClient.IN_APP_CONSUMABLE, skuIds: ["140", "1400", "4200", "14000", "28000", "70000"]);


    ProductInfoResult res = await IapClient.obtainProductInfo(req);

    CoinsTabView.list = res.productInfoList!;

  } on PlatformException catch (e) {
    log(e.toString());
  }
}

Future<PurchaseResultInfo?> purchaseConsumableProduct(String productId) async {
  try {
    PurchaseIntentReq req = PurchaseIntentReq(priceType: IapClient.IN_APP_CONSUMABLE, productId: productId, developerPayload: "Test");

    PurchaseResultInfo res = await IapClient.createPurchaseIntent(req);
    IsSandboxActivatedResult result = await IapClient.isSandboxActivated();
    log("result1111 ${result.isSandboxUser}");
    return res;
  } on PlatformException catch (e) {
    log(e.toString());
    return null;
  }
}