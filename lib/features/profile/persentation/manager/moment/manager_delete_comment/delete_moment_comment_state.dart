
import 'package:equatable/equatable.dart';

abstract class DeleteMomentCommentState extends Equatable {
  const DeleteMomentCommentState();
  
  @override
  List<Object> get props => [];
}

 class DeleteMomentCommentInitial extends DeleteMomentCommentState {}
 class DeleteMomentCommentSucssesState extends DeleteMomentCommentState {
  final String message ; 
  const DeleteMomentCommentSucssesState ({required this.message });
 }
 class DeleteMomentCommentErrorState extends DeleteMomentCommentState {
  final String error ; 
  const DeleteMomentCommentErrorState({required this.error});
 }
 class DeleteMomentCommentLoadingState extends DeleteMomentCommentState {}
