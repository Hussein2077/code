
import 'package:equatable/equatable.dart';

abstract class DeleteMomentState extends Equatable {
  const DeleteMomentState();
  
  @override
  List<Object> get props => [];
}

 class DeleteMomentInitial extends DeleteMomentState {}
 class DeleteMomentLoadingState extends DeleteMomentState {}
 class DeleteMomentSucssesState extends DeleteMomentState {
  final String message ; 
  const DeleteMomentSucssesState({required this.message});
 }
 class DeleteMomentErrorState extends DeleteMomentState {
  final String error ; 
  const DeleteMomentErrorState({required this.error});
 }
