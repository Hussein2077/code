
import 'package:equatable/equatable.dart';

abstract class FollowState extends Equatable {
  const FollowState();
  
  @override
  List<Object> get props => [];
}

class FollowInitial extends FollowState {}
class FollowSucssesState extends FollowState {
  final String massage; 
  const FollowSucssesState({required this.massage});
}

class FollowErrorState extends FollowState {
   final String error; 
  const FollowErrorState({required this.error});
}

class FollowLoadingState extends FollowState {}


class UnFollowSucssesState extends FollowState {
  final String massage; 
  const UnFollowSucssesState({required this.massage});
}

class UnFollowErrorState extends FollowState {
   final String error; 
  const UnFollowErrorState({required this.error});
}


