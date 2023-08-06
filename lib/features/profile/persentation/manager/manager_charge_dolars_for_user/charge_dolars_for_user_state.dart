
import 'package:equatable/equatable.dart';

abstract class ChargeDolarsForUserState extends Equatable {
  const ChargeDolarsForUserState();
  
  @override
  List<Object> get props => [];
}

class ChargeDolarsForUserInitial extends ChargeDolarsForUserState {}


class ChargeDolarsForUserLoadingState extends ChargeDolarsForUserState {}
class ChargeDolarsForUserSucssesState extends ChargeDolarsForUserState {
  final String message ; 
  const ChargeDolarsForUserSucssesState({required this.message});
}
class ChargeDolarsForUserErrorState extends ChargeDolarsForUserState {
  final String error ; 
  const ChargeDolarsForUserErrorState({required this.error});
}