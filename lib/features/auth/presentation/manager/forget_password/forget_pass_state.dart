import 'package:equatable/equatable.dart';

abstract class ForgetPasswordState extends Equatable {
  @override
  List<Object> get props => [];

  const ForgetPasswordState();
}

class ForgetPasswordInitialState extends ForgetPasswordState {}

class ForgetPasswordSuccessState extends ForgetPasswordState {
  final String message;

  const ForgetPasswordSuccessState({required this.message});
}

class ForgetPasswordErrorState extends ForgetPasswordState {
  final String errorMessage;

  const ForgetPasswordErrorState({required this.errorMessage});
}

class ForgetPasswordLoadingState extends ForgetPasswordState {}


class ForgetPasswordCodeVerificationSuccessState extends ForgetPasswordState {
  final String message;

  const ForgetPasswordCodeVerificationSuccessState({required this.message});
}

class ForgetPasswordCodeVerificationErrorState extends ForgetPasswordState {
  final String errorMessage;

  const ForgetPasswordCodeVerificationErrorState({required this.errorMessage});
}

class ForgetPasswordCodeVerificationLoadingState extends ForgetPasswordState {}
