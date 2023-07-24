
import 'package:equatable/equatable.dart';

abstract class BaseLoginWithPhoneEvent extends Equatable {
  const BaseLoginWithPhoneEvent();

  @override
  List<Object> get props => [];
}
class LoginWithPhoneEvent extends BaseLoginWithPhoneEvent{

  final String phone ;
  final String password ;


  const LoginWithPhoneEvent({ required this.phone, required this.password});

 
}