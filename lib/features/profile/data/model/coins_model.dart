import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:tik_chat_v2/features/profile/data/model/gold_coin_model.dart';

class CoinsModel {
  final ProductDetailsResponse productDetailsResponse ;
  final List<GoldCoinsModel> data ;

  CoinsModel({required this.productDetailsResponse , required this.data});
}