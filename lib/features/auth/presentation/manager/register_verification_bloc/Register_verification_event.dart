
import 'package:equatable/equatable.dart';

abstract class RegisterVerificationEventBase extends Equatable {
  const RegisterVerificationEventBase();

  @override
  List<Object> get props => [];
}


class RegisterVerificationEvent extends RegisterVerificationEventBase{
  final String uuid ;
  final String code ;
  final String deviceID ;
  const RegisterVerificationEvent( {required this.uuid,required this.code,required this.deviceID,});


}