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
///###################################
///check the otp code before reset password
class CheckCodeForgetPasswordSuccessState extends ForgetPasswordState {
  final String message;

  const CheckCodeForgetPasswordSuccessState({required this.message});
}

class CheckCodeForgetPasswordErrorState extends ForgetPasswordState {
  final String errorMessage;

  const CheckCodeForgetPasswordErrorState({required this.errorMessage});
}

class CheckCodeForgetPasswordLoadingState extends ForgetPasswordState {}
///###################################
///reset password
class ResetPasswordSuccessState extends ForgetPasswordState {
  final String message;

  const ResetPasswordSuccessState({required this.message});
}

class ResetPasswordErrorState extends ForgetPasswordState {
  final String errorMessage;

  const ResetPasswordErrorState({required this.errorMessage});
}

class ResetPasswordLoadingState extends ForgetPasswordState {}