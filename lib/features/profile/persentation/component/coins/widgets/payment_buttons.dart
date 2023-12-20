// ignore_for_file: must_be_immutable
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/service/payment_config.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/pay_manager/pay_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/pay_manager/pay_event.dart';
import 'package:pay/pay.dart';

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
        //callBack(map, context);
      },
      onError: (e) => debugPrint('Payment error $e'),
      loadingIndicator: const Center(
        child: CircularProgressIndicator(),
      ),
    ) : GooglePayButton(
      paymentConfiguration: PaymentConfiguration.fromJsonString(defaultGooglePay),
      paymentItems: paymentItems,
      type: GooglePayButtonType.pay,
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
        Navigator.pop(context);

        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(ConfigSize.defaultSize!),
              ),
              child: Container(
                height: ConfigSize.defaultSize! * 20,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: ColorManager.bageGriedinet),
                  borderRadius: BorderRadius.circular(ConfigSize.defaultSize!),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Payment Success",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ConfigSize.defaultSize! * 3,
                          overflow: TextOverflow.fade),
                    ),
                  ],
                ),
              ),
            );
          }
        );


        //log(result.toString());

        Map<String, dynamic> myMap = json.decode(result['paymentMethodData']['tokenizationData']['token']);

        log(myMap['signature'].toString());

        callBack(map, context, myMap['signature'].toString());
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



  Future<void> callBack(Map <String, dynamic> map, BuildContext context, String token)async {

    //final encryptedData = encryptMap(map, "${MyDataModel.getInstance().id}-${ConstentApi.encryptionKey}");

    BlocProvider.of<PayBloc>(context).add(PayNow(message: productId.toString(), type: Platform.isIOS ? 'apple' : 'google', token: token));

  }
}