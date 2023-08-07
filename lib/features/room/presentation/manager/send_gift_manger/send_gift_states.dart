
import 'package:equatable/equatable.dart';

abstract class SendGiftStates extends Equatable {

}


class IntialSendGiftStates extends SendGiftStates{

  @override
  List<Object?> get props => [];

}

class LoadingSendGiftStates extends SendGiftStates{

  @override
  List<Object?> get props => [];

}

class SuccessSendGiftStates extends SendGiftStates{
  final String successMessage ;

  SuccessSendGiftStates({required this.successMessage});

  @override
  List<Object?> get props => [successMessage];


}


class ErrorSendGiftStates extends SendGiftStates {
  final String errorMessage ;

  ErrorSendGiftStates({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}