import 'package:equatable/equatable.dart';

abstract class PayEvent extends Equatable {}

class PayNow extends PayEvent {
  final String product_id;
  final String order_id;
  PayNow ({required this.product_id, required this.order_id});

  @override
  List<Object?> get props => [product_id, order_id];


}

class HuaweiPayNow extends PayEvent {
  final String product_id;
  final String token;
  HuaweiPayNow ({required this.product_id, required this.token});

  @override
  List<Object?> get props => [product_id, token];


}