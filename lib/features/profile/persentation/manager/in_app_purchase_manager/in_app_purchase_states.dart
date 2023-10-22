
import 'package:equatable/equatable.dart';

abstract class InAppPurchaseState extends Equatable {
  const InAppPurchaseState();
  
  @override
  List<Object> get props => [];
}

class InAppPurchaseInitial extends InAppPurchaseState {}
class InAppPurchaseLoadingState extends InAppPurchaseState {}
class InAppPurchaseSucssesState extends InAppPurchaseState {
  final String message ; 
  const InAppPurchaseSucssesState({required this.message});
}
class InAppPurchaseErrorState extends InAppPurchaseState {
  final String error ; 
  const InAppPurchaseErrorState({required this.error});
}
