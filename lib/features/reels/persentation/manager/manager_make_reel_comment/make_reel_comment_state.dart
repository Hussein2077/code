
import 'package:equatable/equatable.dart';

abstract class MakeReelCommentState extends Equatable {
  const MakeReelCommentState();
  
  @override
  List<Object> get props => [];
}

 class MakeReelCommentInitial extends MakeReelCommentState {}
 class MakeReelCommentLoadingState extends MakeReelCommentState {}
 class MakeReelCommentSucssesState extends MakeReelCommentState {
  final String message ; 
  const MakeReelCommentSucssesState ({required this.message});
 }
 class MakeReelCommentErrorState extends MakeReelCommentState {
  final String error ; 
  const MakeReelCommentErrorState ({required this.error});
 }
