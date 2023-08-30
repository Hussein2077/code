import 'package:equatable/equatable.dart';

abstract class MakeReelLikeState extends Equatable {
  const MakeReelLikeState();
  
  @override
  List<Object> get props => [];
}

 class MakeReelLikeInitial extends MakeReelLikeState {}
 class MakeReelLikeLoadingState extends MakeReelLikeState {}
 class MakeReelLikeSucssesState extends MakeReelLikeState {
  final String message ; 
  const MakeReelLikeSucssesState ({required this.message});
 }
 class MakeReelLikeErrorState extends MakeReelLikeState {
  final String error ; 
  const MakeReelLikeErrorState ({required this.error});
 }