// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huawei_iap/huawei_iap.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/buy_coins_uc.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/coins/components/huawei_in_app_purchases.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/coins/components/in_app_purchases.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/coins/widgets/coins_tab_view.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/buy_coins_manger/buy_coins_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/buy_coins_manger/buy_coins_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/pay_manager/pay_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/pay_manager/pay_event.dart';
import 'package:tik_chat_v2/splash.dart';
import '../../../../../../core/utils/config_size.dart';

class PaymentMethodDialog extends StatefulWidget {

  var coinPackageId;
  ProductDetailsResponse productDetailsResponse;
  PaymentMethodDialog({super.key, required this.coinPackageId, required this.productDetailsResponse});

  @override
  State<PaymentMethodDialog> createState() => _PaymentMethodDialogState();
}

class _PaymentMethodDialogState extends State<PaymentMethodDialog> {

  @override
  Widget build(BuildContext context) {

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(10),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
      child: Container(
        width: double.infinity,
        height: ConfigSize.defaultSize! * 25,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white
        ),
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Payment Method",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight:FontWeight.bold),),

            SizedBox(height: ConfigSize.defaultSize! * 3.5,),

            if (Platform.isAndroid || SplashScreen.isHuawei) InkWell(
              onTap: (){
                BlocProvider.of<BuyCoinsBloc>(context).add(
                    BuyCoins(buyCoinsParameter:BuyCoinsParameter(coinsID: widget.coinPackageId.toString(), paymentMethod: 'opay')));
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

            if (Platform.isAndroid || SplashScreen.isHuawei) SizedBox(height: ConfigSize.defaultSize!,),

            if(SplashScreen.isHuawei) InkWell(
              onTap: (){
                IapClient.isEnvReady().then((res) {
                  purchaseConsumableProduct(widget.coinPackageId.toString()).then((res) {
                    if(res?.returnCode == '0'){
                      log("success");
                    }
                   BlocProvider.of<PayBloc>(context)
                       .add(HuaweiPayNow(product_id: widget.coinPackageId.toString(),
                       token: res!.inAppPurchaseData!.purchaseToken.toString()));
                   Navigator.pop(context);
                  });
                });
              },
              child: Container(
                height: ConfigSize.defaultSize! * 5,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(ConfigSize.defaultSize!*2),
                  color: Colors.red,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Pay With Huawei", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
                      Image.asset(AssetsPath.huaweiIcon, color: Colors.white,),
                    ],
                  ),
                ),
              ),
            ),

            if(!SplashScreen.isHuawei)
              InkWell(
              onTap: (){
                CoinsTabView.productId = widget.coinPackageId;
                getIt<PurchaseService>().buyProduct(widget.productDetailsResponse.productDetails.where((element) => element.id.toString() == widget.coinPackageId.toString()).single as ProductDetails);
              },
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(ConfigSize.defaultSize!*2),
                child: Container(
                  height: ConfigSize.defaultSize! * 5,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(ConfigSize.defaultSize!*2),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Pay With google", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),),
                        Image.asset(AssetsPath.googleIcon),
                      ],
                    ),
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