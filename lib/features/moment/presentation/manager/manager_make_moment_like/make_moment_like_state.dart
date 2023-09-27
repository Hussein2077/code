import 'package:equatable/equatable.dart';

abstract class MakeMomentLikeStates extends Equatable {
  const MakeMomentLikeStates();

  @override
  List<Object> get props => [];
}

class MakeMomentLikeInitial extends MakeMomentLikeStates {}

class MakeMomentLikeLoadingState extends MakeMomentLikeStates {}

class MakeMomentLikeSucssesState extends MakeMomentLikeStates {
  String sucssesMessage;

  MakeMomentLikeSucssesState({required this.sucssesMessage});
}

class MakeMomentLikeErroeState extends MakeMomentLikeStates {
  String errorMessage;

  MakeMomentLikeErroeState({required this.errorMessage});
}
