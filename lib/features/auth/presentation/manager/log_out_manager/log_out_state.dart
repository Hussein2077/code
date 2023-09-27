
import 'package:equatable/equatable.dart';

abstract class LogOutState extends Equatable {
  const LogOutState();
  
  @override
  List<Object> get props => [];
}

class LogOutInitial extends LogOutState {}
class LogOutLoadingState extends LogOutState {}

class LogOutSucssesState extends LogOutState {}

class LogOutErrorState extends LogOutState {
  final String error ; 
  const LogOutErrorState ({required this.error}); 
}

class DeleteAccountLoadingState extends LogOutState {}

class DeleteAccountSucssesState extends LogOutState {}

class DeleteAccountErrorState extends LogOutState {
  final String error ;
  const DeleteAccountErrorState ({required this.error});
}


