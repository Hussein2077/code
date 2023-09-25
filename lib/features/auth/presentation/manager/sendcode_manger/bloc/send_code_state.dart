part of 'send_code_bloc.dart';

abstract class SendCodeState extends Equatable {
  const SendCodeState();
  
  @override
  List<Object> get props => [];
}

class SendCodeInitial extends SendCodeState {}

class SendCodeLoadingState extends SendCodeState{
  
}
class SendCodeErrorMessageState extends SendCodeState{
  final String errorMessage ;

  const SendCodeErrorMessageState({required this.errorMessage});

  
}

class SendCodeSuccesMessageState extends SendCodeState{
  final String succesMessage ;

  const SendCodeSuccesMessageState({required this.succesMessage});
  
}