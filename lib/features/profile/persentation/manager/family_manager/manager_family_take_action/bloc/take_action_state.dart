
import 'package:equatable/equatable.dart';

abstract class TakeActionState extends Equatable {
  const TakeActionState();

  @override
  List<Object> get props => [];
}

class TakeActionInitial extends TakeActionState {}

class FamilyTakeActionLoadingState extends TakeActionState {}

class FamilyTakeActionSucssesState extends TakeActionState {
  final String massage;
  const FamilyTakeActionSucssesState({required this.massage});
}

class FamilyTakeActionErrorState extends TakeActionState {
  final String error;
  const FamilyTakeActionErrorState({required this.error});
}
