

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
  final String phoneNumber ;
  final String password ;
  final String vrCode ;
   final String credential ;


  BindNumberAccountEvent({required this.credential ,  required this.phoneNumber,required this.password,required this.vrCode});

  @override
  List<Object?> get props => [  phoneNumber,password,vrCode];



}