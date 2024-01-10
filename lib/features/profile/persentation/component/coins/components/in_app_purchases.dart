// ignore_for_file: avoid_print
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/service/navigation_service.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/coins/widgets/coins_tab_view.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/pay_manager/pay_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/pay_manager/pay_event.dart';

class PurchaseService {
  final InAppPurchase connection = InAppPurchase.instance;

  Future<void> handlePurchaseUpdates(List<PurchaseDetails> detailsList) async {
    for (PurchaseDetails purchaseDetails in detailsList) {
      print("status: ${purchaseDetails.status.name}");
      if (purchaseDetails.status == PurchaseStatus.purchased) {
        await acknowledgePurchase(purchaseDetails).then((value) {
          if (Platform.isAndroid) {
            Map<String, dynamic> map = {
              "merchantInfo": {
                "merchantId": ConstentApi.merchantId,
                "merchantName": ConstentApi.merchantName
              },
              "processInfo": {
                "item_id": purchaseDetails.productID.toString(),
                "token":
                    purchaseDetails.verificationData.serverVerificationData,
              }
            };

            final encryptedData = encryptMap(map,
                "${MyDataModel.getInstance().id}-${ConstentApi.encryptionKey}");
            BlocProvider.of<PayBloc>(
                    getIt<NavigationService>().navigatorKey.currentContext!)
                .add(GooglePay(data: encryptedData));
          } else {
            BlocProvider.of<PayBloc>(
                    getIt<NavigationService>().navigatorKey.currentContext!)
                .add(ApplePayNow(
                    data: purchaseDetails
                        .verificationData.serverVerificationData
                        .toString()));
          }
        });
      } else if (purchaseDetails.status == PurchaseStatus.error) {
        print("status error: ${purchaseDetails.error!.message}");
      }
    }
  }

  Future<void> acknowledgePurchase(PurchaseDetails purchaseDetails) async {
    try {
      if (purchaseDetails.pendingCompletePurchase) {
        print("pendingCompletePurchase");
        await InAppPurchase.instance.completePurchase(purchaseDetails);
      }
    } catch (e) {
      log("acknowledgePurchase error $e");
    }
  }

  Future<void> buyProduct(ProductDetails product) async {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);
    try {
      await connection.buyConsumable(purchaseParam: purchaseParam);
    } catch (e) {
      log("error in buy function: $e");
    }
  }

  String encryptMap(Map<String, dynamic> map, String key) {
    String jsonString = json.encode(map);
    List<int> inputBytes = utf8.encode(jsonString);
    List<int> keyBytes = utf8.encode(key);

    for (int i = 0; i < inputBytes.length; i++) {
      inputBytes[i] ^= keyBytes[i % keyBytes.length];
    }

    return base64.encode(inputBytes);
  }
}
