// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/service/payment_config.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';

class PaymentButtons extends StatelessWidget {

  List<PaymentItem> paymentItems;
  int productId;
  PaymentButtons({super.key, required this.paymentItems, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? ApplePayButton(
      paymentConfiguration: PaymentConfiguration.fromJsonString(defaultApplePay),
      paymentItems: paymentItems,
      style: ApplePayButtonStyle.black,
      width: double.infinity,
      type: ApplePayButtonType.buy,
      onPaymentResult: (result) {
        Map <String, dynamic> map = {
          "merchantInfo": {
            "merchantId": ConstentApi.merchantId,
            "merchantName": ConstentApi.merchantName
          },
          "processInfo": {
            "item_id": productId.toString(),
            "cost": paymentItems[0].amount,
            "cardDetails": result['paymentMethodData']['info']['cardDetails'],
            "cardNetwork": result['paymentMethodData']['info']['cardNetwork']
          }
        };
        callBack(map);
      },
      onError: (e) => debugPrint('Payment error $e'),
      loadingIndicator: const Center(
        child: CircularProgressIndicator(),
      ),
    ) : GooglePayButton(
      paymentConfiguration: PaymentConfiguration.fromJsonString(defaultGooglePay),
      paymentItems: paymentItems,
      type: GooglePayButtonType.buy,
      margin: const EdgeInsets.only(top: 15.0),
      onPaymentResult: (result) {
        Map <String, dynamic> map = {
          "merchantInfo": {
            "merchantId": ConstentApi.merchantId,
            "merchantName": ConstentApi.merchantName
          },
          "processInfo": {
            "item_id": productId.toString(),
            "cost": paymentItems[0].amount,
            "cardDetails": result['paymentMethodData']['info']['cardDetails'],
            "cardNetwork": result['paymentMethodData']['info']['cardNetwork']
          }
        };
        callBack(map);
      },
      onError: (e) => debugPrint('Payment error $e'),
      loadingIndicator: const Center(
        child: CircularProgressIndicator(),
      ),
    );
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



  Future<void> callBack(Map <String, dynamic> map)async {
    //TODO add end point

    final encryptedData = encryptMap(map, "${MyDataModel.getInstance().id}-${ConstentApi.encryptionKey}");

    print(encryptedData);
  }
}