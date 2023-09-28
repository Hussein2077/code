
import 'package:equatable/equatable.dart';

abstract class AddMomentState extends Equatable {
  const AddMomentState();
  
  @override
  List<Object> get props => [];
}

 class AddMomentInitial extends AddMomentState {}
 class AddMomentLoadingState extends AddMomentState {}
 class AddMomentErrorState extends AddMomentState {
  final String error ; 
  const AddMomentErrorState({required this.error});
 }
 class AddMomentSucssesState extends AddMomentState {
  final String message ; 
  const AddMomentSucssesState({required this.message});
 }
