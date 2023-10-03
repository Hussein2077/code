
import 'package:equatable/equatable.dart';

abstract class AddMomentCommentState extends Equatable {
  const AddMomentCommentState();
  
  @override
  List<Object> get props => [];
}

 class AddMomentCommentInitial extends AddMomentCommentState {}
 class AddMomentCommentLoadingState extends AddMomentCommentState {}
 class AddMomentCommentErrorState extends AddMomentCommentState {
  
  final String error ; 
  const AddMomentCommentErrorState({required this.error }) ; 

 }
 class AddMomentCommentSucssesState extends AddMomentCommentState {
  final String message; 
  const AddMomentCommentSucssesState ({required this.message});

 }
