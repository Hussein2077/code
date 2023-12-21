// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_huawei_availability/google_huawei_availability.dart';
import 'package:huawei_iap/huawei_iap.dart';
import 'package:pay/pay.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/buy_coins_uc.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/coins/components/huawei_in_app_purchases.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/coins/widgets/payment_buttons.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/buy_coins_manger/buy_coins_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/buy_coins_manger/buy_coins_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/pay_manager/pay_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/pay_manager/pay_event.dart';
import '../../../../../../core/utils/config_size.dart';

class PaymentMethodDialog extends StatefulWidget {

  var coinPackageId;
  String coin;
  String price;
  PaymentMethodDialog({super.key, required this.coinPackageId, required this.coin, required this.price});

  @override
  State<PaymentMethodDialog> createState() => _PaymentMethodDialogState();
}

class _PaymentMethodDialogState extends State<PaymentMethodDialog> {

  bool isHuawei = false;

  void GoogleHuawei()async{
    isHuawei = (await GoogleHuaweiAvailability.isHuaweiServiceAvailable)!;
    setState(() {

    });
  }

  @override
  void initState() {
    GoogleHuawei();
    super.initState();
  }

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
            const Text("Payment Method", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
            SizedBox(height: ConfigSize.defaultSize! * 3.5,),

            if (Platform.isAndroid || isHuawei) InkWell(
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

            if (Platform.isAndroid || isHuawei) SizedBox(height: ConfigSize.defaultSize!,),

            if(isHuawei) InkWell(
              onTap: (){
                IapClient.isEnvReady().then((res) {
                  purchaseConsumableProduct(widget.coin).then((res) {
                   BlocProvider.of<PayBloc>(context).add(HuaweiPayNow(product_id: widget.coin, token: res!.inAppPurchaseData!.purchaseToken.toString()));
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

            if(!isHuawei) SizedBox(
              width: double.infinity,
              child: PaymentButtons(
                paymentItems: [
                  PaymentItem(
                    amount: widget.price,
                    label: widget.coin,
                    status: PaymentItemStatus.final_price,
                    type: PaymentItemType.item,
                  ),
                ],
                productId: widget.coinPackageId,
              ),
            ),
          ],
        ),
      ),
    );
  }
}