import 'package:equatable/equatable.dart';

abstract class payState extends Equatable {
  @override
  List<Object> get props => [];
}

class payInitial extends payState {}

class inAppPurchaseLoadingState extends payState {}

class inAppPurchaseSucssesState extends payState {
  final String massege;
  inAppPurchaseSucssesState({required this.massege});
}

class inAppPurchaseErrorState extends payState {
  final String massege;
  inAppPurchaseErrorState({required this.massege});
}

class huaweiPayLoadingState extends payState {}

class huaweiPaySucssesState extends payState {
  final String massege;
  huaweiPaySucssesState({required this.massege});
}

class huaweiPayErrorState extends payState {
  final String massege;
  huaweiPayErrorState({required this.massege});
}

class applePayLoadingState extends payState {}

class applePaySucssesState extends payState {
  final String massege;
  applePaySucssesState({required this.massege});
}

class applePayErrorState extends payState {
  final String massege;
  applePayErrorState({required this.massege});
}
