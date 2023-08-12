import 'package:equatable/equatable.dart';

abstract class KickoutStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialKickoutState extends KickoutStates {}

class LoadingKickoutState extends KickoutStates {}

class SuccessKickoutState extends KickoutStates {
  final String successMessage;

  SuccessKickoutState({required this.successMessage});
}

class ErrorKickoutState extends KickoutStates {
  final String errorMessage;

  ErrorKickoutState({required this.errorMessage});
}
