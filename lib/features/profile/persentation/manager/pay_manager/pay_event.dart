import 'package:equatable/equatable.dart';

abstract class PayEvent extends Equatable {}

class PayNow extends PayEvent {
  final String message;
  final String type;
  final String token;
  PayNow ({required this.message, required this.type, required this.token});

  @override
  List<Object?> get props => [message, type, token];


}

class HuaweiPayNow extends PayEvent {
  final String product_id;
  final String token;
  HuaweiPayNow ({required this.product_id, required this.token});

  @override
  List<Object?> get props => [product_id, token];


}