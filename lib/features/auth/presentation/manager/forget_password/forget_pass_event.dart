abstract class ForgetPasswordEventBase {}

class InitEvent extends ForgetPasswordEventBase {}

class ForgetPasswordEvent extends ForgetPasswordEventBase {
  final String phone;
  final String code;
  final String password;

  ForgetPasswordEvent({ required this.phone,required this.code,required this.password});
}

class forgetPasswordCodeVerificationEvent extends ForgetPasswordEventBase {
  final String phone;
  final String code;

  forgetPasswordCodeVerificationEvent({ required this.phone,required this.code});
}