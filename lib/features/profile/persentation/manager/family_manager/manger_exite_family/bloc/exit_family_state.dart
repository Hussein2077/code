
import 'package:equatable/equatable.dart';

abstract class ExitFamilyState extends Equatable {
  const ExitFamilyState();

  @override
  List<Object> get props => [];
}

class ExitFamilyInitial extends ExitFamilyState {}

class ExitFamilyLoadingState extends ExitFamilyState {}

class ExitFamilySucssesState extends ExitFamilyState {
  final String massage;
  const ExitFamilySucssesState({required this.massage});
}

class ExitFamilyErrorState extends ExitFamilyState {
  final String error;
  const ExitFamilyErrorState({required this.error});
}
