
import 'package:equatable/equatable.dart';

abstract class ChargeCoinForUserState extends Equatable {
  const ChargeCoinForUserState();
  
  @override
  List<Object> get props => [];
}

class ChargeCoinForUserInitial extends ChargeCoinForUserState {}

class ChargeCoinForUserLoadingState extends ChargeCoinForUserState {}
class ChargeCoinForUserSucssesState extends ChargeCoinForUserState {
  final String message ; 
  const ChargeCoinForUserSucssesState({required this.message});
}
class ChargeCoinForUserErrorState extends ChargeCoinForUserState {
  final String error ; 
  const ChargeCoinForUserErrorState({required this.error});
}
