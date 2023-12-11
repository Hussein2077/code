abstract class ForgetPasswordEventBase {}

class InitEvent extends ForgetPasswordEventBase {}

class ForgetPasswordEvent extends ForgetPasswordEventBase {
  final String phone;

  ForgetPasswordEvent(this.phone);
}
class CheckCodeForgetPasswordEvent extends ForgetPasswordEventBase {
  final String phone;
  final String code;

  CheckCodeForgetPasswordEvent({ required this.phone,required this.code});
}
class ResetPasswordEvent extends ForgetPasswordEventBase {
  final String phone;
  final String code;
  final String password;

  ResetPasswordEvent({ required this.phone,required this.code,required this.password});
}
