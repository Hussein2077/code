
import 'package:equatable/equatable.dart';

abstract class FeedBackState extends Equatable {
  const FeedBackState();
  
  @override
  List<Object> get props => [];
}

class FeedBackInitial extends FeedBackState {}

class FeedBackLoadingState extends FeedBackState{}
class FeedBackSucssesState extends FeedBackState{
  final String massage; 
  const FeedBackSucssesState({required this.massage});
}
class FeedBackErrorState extends FeedBackState{
  final String error ; 
  const FeedBackErrorState({required this.error});
}
