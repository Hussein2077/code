
import 'package:equatable/equatable.dart';

abstract class DeleteReelState extends Equatable {
  const DeleteReelState();
  
  @override
  List<Object> get props => [];
}

 class DeleteReelInitial extends DeleteReelState {}

  class DeleteReelLodingState extends DeleteReelState {}

 class DeleteReelSucssesState extends DeleteReelState {
  final String message ; 
  const DeleteReelSucssesState({required this.message});
 }

 class DeleteReelErrorState extends DeleteReelState {
  final String error ; 
  const DeleteReelErrorState ({required this.error});
 }

