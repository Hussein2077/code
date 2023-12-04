// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/coins/widgets/coins_tab_view.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/in_app_purchase_manager/in_app_purchase_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/in_app_purchase_manager/in_app_purchase_event.dart';


final InAppPurchase _connection = InAppPurchase.instance;

//TODO replace this to get data from backend
final Set<String> _productIds = {"140", "1400", "4200", "14000", "28000", "70000"};

late StreamSubscription<List<PurchaseDetails>> purchaseUpdatedSubscription;

Map<String, dynamic> productsMap = {
    "140": '',
    "1400": '',
    "4200": '',
    "14000": '',
    "28000": '',
    "70000": '',
};


  Future<void> initialize(BuildContext context) async {
    final bool available = await _connection.isAvailable();
    if (available) {
      await _queryProducts();
      _connection.purchaseStream.listen((detailsList) {
        _handlePurchaseUpdates(detailsList, context);
      });
    }
  }

  Future<void> _queryProducts() async {
    final ProductDetailsResponse response = await _connection.queryProductDetails(_productIds);
    if (response.error == null) {
      print(response.productDetails.length);
      for(int i = 0; i < response.productDetails.length; i++){
          productsMap[response.productDetails[i].id] = response.productDetails[i];
      }
    }else{
      print(response.error!.message);
    }
  }

  Future<void> _handlePurchaseUpdates(List<PurchaseDetails> detailsList, BuildContext context) async{
    for (PurchaseDetails purchaseDetails in detailsList) {
      if(purchaseDetails.status == PurchaseStatus.pending){
        loadingToast(context: context);
      }else if (purchaseDetails.status == PurchaseStatus.purchased) {
        await acknowledgePurchase(purchaseDetails).then((value){
          BlocProvider.of<InAppPurchaseBloc>(context).add(PostInAppPurchaseEvent(user_id: MyDataModel.getInstance().id.toString(), product_id: CoinsTabView.productId.toString()));
        });
        print(purchaseDetails.transactionDate!);
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
      print("acknowledgePurchase error $e");
    }
  }

  Future<void> buyProduct(ProductDetails product) async {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);
    try {
      await _connection.buyConsumable(purchaseParam: purchaseParam);
    } catch (e) {
      log("error in buy function: $e");
    }
  }