// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:in_app_purchase/in_app_purchase.dart';


final InAppPurchase _connection = InAppPurchase.instance;

//TODO replace this to get data from backend
// final Set<String> _productIds = {"140", "1400", "4200", "14000", "28000", "70000"};
final Set<String> _productIds = {"140", "1400"};

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
  log(response.productDetails.length.toString() + "######");
  if (response.error == null) {
    for(int i = 0; i < response.productDetails.length; i++){
      productsMap[response.productDetails[i].id] = response.productDetails[i];
    }
  }
}

Future<void> _handlePurchaseUpdates(List<PurchaseDetails> detailsList, BuildContext context) async{
  for (PurchaseDetails purchaseDetails in detailsList) {
    print("status: ${purchaseDetails.status.name}");
    if (purchaseDetails.status == PurchaseStatus.purchased) {
      await acknowledgePurchase(purchaseDetails).then((value){
        //BlocProvider.of<InAppPurchaseBloc>(context).add(PostInAppPurchaseEvent(user_id: MyDataModel.getInstance().id.toString(), product_id: CoinsTabView.productId.toString()));
      });
      print(purchaseDetails.purchaseID! + "######");
      print(purchaseDetails.verificationData.serverVerificationData + "######");
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