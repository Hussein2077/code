
import 'package:equatable/equatable.dart';

abstract class MallBuyState extends Equatable {
  const MallBuyState();
  
  @override
  List<Object> get props => [];
}

class BuyInitial extends MallBuyState {}

class BuyLoadingState extends MallBuyState {}

class BuyScussesState extends MallBuyState {
  final String massage;
  const BuyScussesState({required this.massage});
}

class BuyErorrState extends MallBuyState {
  final String massage;
  const BuyErorrState({required this.massage});
}


