// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/buy_coins_uc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/buy_coins_manger/buy_coins_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/buy_coins_manger/buy_coins_event.dart';
import '../../../../../../core/utils/config_size.dart';

class PaymentMethodDialog extends StatefulWidget {

  var coinPackageId;
  var product;
  InAppPurchase inAppPurchase;
  PaymentMethodDialog({super.key, required this.coinPackageId, this.product, required this.inAppPurchase});

  @override
  State<PaymentMethodDialog> createState() => _PaymentMethodDialogState();
}

class _PaymentMethodDialogState extends State<PaymentMethodDialog> {


  Future<void> _buyProduct(ProductDetails product) async {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);
    try {
      await widget.inAppPurchase.buyConsumable(purchaseParam: purchaseParam);
    } catch (e) {
      log("error in buy function: $e");
      // Handle purchase errors, if any.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(10),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
      child: Container(
        width: double.infinity,
        height: ConfigSize.defaultSize! * 23,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white
        ),
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Payment Method", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
            const SizedBox(height: 30,),

            InkWell(
              onTap: (){
                BlocProvider.of<BuyCoinsBloc>(context).add(
                    BuyCoins(buyCoinsParameter:BuyCoinsParameter(coinsID: widget.coinPackageId , paymentMethod: 'opay')));
                },
              child: Container(
                height: ConfigSize.defaultSize! * 5,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(ConfigSize.defaultSize!*2),
                  color: const Color.fromRGBO(101, 111, 221, 1.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Pay With Strip", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
                      Image.asset(AssetsPath.stripeIcon, color: Colors.white,),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15,),

            InkWell(
              onTap: (){
                _buyProduct(widget.product);
              },
              child: Container(
                height: ConfigSize.defaultSize! * 5,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(ConfigSize.defaultSize!*2),
                  color: Colors.black,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Pay With Apple", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
                      Image.asset(AssetsPath.appleIcon, color: Colors.white,),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
