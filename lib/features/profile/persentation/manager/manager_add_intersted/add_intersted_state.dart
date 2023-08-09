

import 'package:equatable/equatable.dart';

abstract class AddInterstedState extends Equatable {
  const AddInterstedState();
  
  @override
  List<Object> get props => [];
}

 class AddInterstedInitial extends AddInterstedState {}
 class AddInterstedLoadingState extends AddInterstedState {}
 class AddInterstedSucssesState extends AddInterstedState {
  final String message ; 
  const AddInterstedSucssesState({required this.message});
 }
 class AddInterstedErrorState extends AddInterstedState {
  final String error ; 
  const AddInterstedErrorState({required this.error});
 }
