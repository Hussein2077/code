
import 'package:equatable/equatable.dart';

abstract class RegisterVerificationState extends Equatable {
  const RegisterVerificationState();

  @override
  List<Object> get props => [];
}

class RegisterVerificationInitial extends RegisterVerificationState {}

class RegisterVerificationLoadingState extends RegisterVerificationState{

}
class RegisterVerificationErrorMessageState extends RegisterVerificationState{
  final String errorMessage ;

  const RegisterVerificationErrorMessageState({required this.errorMessage});


}

class RegisterVerificationSuccessMessageState extends RegisterVerificationState{



}