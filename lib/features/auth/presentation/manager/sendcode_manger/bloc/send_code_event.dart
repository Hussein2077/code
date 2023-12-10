part of 'send_code_bloc.dart';

abstract class SendCodeEvent extends Equatable {
  const SendCodeEvent();

  @override
  List<Object> get props => [];
}


class SendPhoneEvent extends SendCodeEvent{
  final String uuid ;
  const SendPhoneEvent({required this.uuid});


}