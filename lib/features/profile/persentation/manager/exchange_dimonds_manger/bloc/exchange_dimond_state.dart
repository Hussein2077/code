

import 'package:equatable/equatable.dart';

abstract class ExchangeDimondState extends Equatable {
  const ExchangeDimondState();
  
  @override
  List<Object> get props => [];
}

class ExchangeDimondInitial extends ExchangeDimondState {}
class ExchangeDimondLoadingState extends ExchangeDimondState {}

class ExchangeDimondSucssesState extends ExchangeDimondState {
  final String massage ; 
  const ExchangeDimondSucssesState({required this.massage});
}

class ExchangeDimondErrorState extends ExchangeDimondState {
  final String error ; 
  const ExchangeDimondErrorState({required this.error});
}



