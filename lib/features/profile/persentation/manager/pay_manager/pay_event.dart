import 'package:equatable/equatable.dart';

abstract class PayEvent extends Equatable {}

class GooglePay extends PayEvent {
  final String data;
  GooglePay({required this.data});

  @override
  List<Object?> get props => [data];
}

class HuaweiPayNow extends PayEvent {
  final String product_id;
  final String token;
  HuaweiPayNow({required this.product_id, required this.token});

  @override
  List<Object?> get props => [product_id, token];
}

class ApplePayNow extends PayEvent {
  final String data;
  ApplePayNow({required this.data});

  @override
  List<Object?> get props => [data];
}
