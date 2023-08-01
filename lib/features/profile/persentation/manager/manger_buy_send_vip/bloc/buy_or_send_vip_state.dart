
import 'package:equatable/equatable.dart';

abstract class BuyOrSendVipState extends Equatable {
  const BuyOrSendVipState();
  
  @override
  List<Object> get props => [];
}

class BuyOrSendVipInitial extends BuyOrSendVipState {}
class BuyOrSendVipLoadingState extends BuyOrSendVipState{

}
class BuyOrSendVipSucssesState extends BuyOrSendVipState{
  final String massage ; 
  const BuyOrSendVipSucssesState({required this.massage});
}
class BuyOrSendVipErrorState extends BuyOrSendVipState{
  final String error ; 
  const BuyOrSendVipErrorState({required this.error});
}