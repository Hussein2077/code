
import 'package:equatable/equatable.dart';

abstract class  BaseRegisterWithPhoneEvent extends Equatable {
  const BaseRegisterWithPhoneEvent();

  @override
  List<Object> get props => [];
}
 

 class RegisterWithPhoneEvent extends BaseRegisterWithPhoneEvent {

    final String phone ; // include code country 
  final String password ;
  final String code ;
 final String credential ;

  const RegisterWithPhoneEvent({ required this.phone,required this.password,required this.code, required this.credential});

 }