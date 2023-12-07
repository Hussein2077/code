// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:tik_chat_v2/core/service/payment_config.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class PaymentButtons extends StatelessWidget {

  List<PaymentItem> paymentItems;
  PaymentButtons({super.key, required this.paymentItems});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? ApplePayButton(
      paymentConfiguration: PaymentConfiguration.fromJsonString(defaultApplePay),
      paymentItems: paymentItems,
      style: ApplePayButtonStyle.black,
      width: double.infinity,
      type: ApplePayButtonType.buy,
      onPaymentResult: (result) {
        debugPrint('Payment Result $result');
        callBack();
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
      onPressed: (){
        callBack();
      },
      onPaymentResult: (result) {
        log(result["paymentMethodData"]["tokenizationData"]['token']);
        callBack();
      },
      onError: (e) => debugPrint('Payment error $e'),
      loadingIndicator: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  String encryptMessage(String message) {
    final plainText = '{item_id:1}';
    final key = encrypt.Key.fromLength(32);
    final iv = encrypt.IV.fromLength(16);

    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    final encrypted = encrypter.encrypt(plainText, iv: iv);
    final decrypted = encrypter.decrypt(encrypted, iv: iv);

    print(decrypted);
    print(encrypted.base16);
    return encrypted.base64;
  }

  Future<void> callBack()async {
    //TODO add end point

    log(encryptMessage("{item_id:1}"));
  }

}
