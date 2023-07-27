
import 'package:equatable/equatable.dart';

abstract class FamilyRemoveUserState extends Equatable {
  const FamilyRemoveUserState();

  @override
  List<Object> get props => [];
}

class FamilyRemoveUserInitial extends FamilyRemoveUserState {}

class FamilyRemoveUserLoadingState extends FamilyRemoveUserState {}

class FamilyRemoveUserSucssesState extends FamilyRemoveUserState {
  final String massage;
  const FamilyRemoveUserSucssesState({required this.massage});
}

class FamilyRemoveUserErrorState extends FamilyRemoveUserState {
  final String error;
  const FamilyRemoveUserErrorState({required this.error});
}
