
import 'package:equatable/equatable.dart';

abstract class ChangeUserTypeState extends Equatable {
  const ChangeUserTypeState();

  @override
  List<Object> get props => [];
}

class ChangeUserTypeInitial extends ChangeUserTypeState {}

class ChangeUserTypeLoadingState extends ChangeUserTypeState {}

class ChangeUserTypeSucsessState extends ChangeUserTypeState {
  final String massage;
  const ChangeUserTypeSucsessState({required this.massage});
}

class ChangeUserTypeErorrState extends ChangeUserTypeState {
  final String error;
  const ChangeUserTypeErorrState({required this.error});
}
