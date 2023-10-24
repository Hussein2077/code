
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/features/profile/data/model/in_app_purchase_mode.dart';

abstract class InAppPurchaseState extends Equatable {
  const InAppPurchaseState();
  
  @override
  List<Object> get props => [];
}

class InAppPurchaseInitial extends InAppPurchaseState {}

class InAppPurchaseLoadingState extends InAppPurchaseState {}

class InAppPurchaseSucssesState extends InAppPurchaseState {
  final InAppPurchaseMode data ;
  const InAppPurchaseSucssesState({required this.data});
}

class InAppPurchaseErrorState extends InAppPurchaseState {
  final String error ; 
  const InAppPurchaseErrorState({required this.error});
}
