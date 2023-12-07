// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:tik_chat_v2/core/service/payment_config.dart';

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
      onPaymentResult: (result) {
        debugPrint('Payment Result $result');
        callBack();
      },
      onError: (e) => debugPrint('Payment error $e'),
      loadingIndicator: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future<void> callBack()async {
    //TODO add end point

  }

}
