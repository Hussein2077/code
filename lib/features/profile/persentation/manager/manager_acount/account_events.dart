

import 'package:equatable/equatable.dart';

abstract class AccountEvents extends Equatable{

}
class DeleteAccountEvent extends AccountEvents {


  @override
  List<Object?> get props => [];

}
class BindFacebookAccountEvent extends AccountEvents {


  @override
  List<Object?> get props => [];

}

class BindGoolgeAccountEvent extends AccountEvents {


  @override
  List<Object?> get props => [];

}
class BindNumberAccountEvent extends AccountEvents {
  final String phoneNumber;

  final String password;

  final String vrCode;

  final String credential;

  BindNumberAccountEvent(
      {required this.phoneNumber,
      required this.password,
      required this.vrCode,
      required this.credential});

  @override
  List<Object?> get props => [phoneNumber, password, vrCode];
}


class ChangeNumberAccountEvent extends AccountEvents {
  final String currentPhoneNumber;
  final String newtPhoneNumber ;
  final String? vrCode;
  final String credential ;


  ChangeNumberAccountEvent({
    required this.currentPhoneNumber,
    required this.newtPhoneNumber,
    required this.credential,

   this.vrCode});

  @override
  List<Object?> get props => [  currentPhoneNumber,vrCode,newtPhoneNumber];



}
class ChangePasswordAccountEvent extends AccountEvents {
  final String? password ;
  final String? phone ;
  final String vrCode ;


  ChangePasswordAccountEvent({
    required this.password,
    required this.phone,
    required this.vrCode,

  });

  @override
  List<Object?> get props => [  password,vrCode,phone];




}