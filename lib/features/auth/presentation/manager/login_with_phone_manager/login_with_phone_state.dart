
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';

abstract class LoginWithPhoneState extends Equatable {
  const LoginWithPhoneState();
  
  @override
  List<Object> get props => [];
}

class LoginWithPhoneInitial extends LoginWithPhoneState {}
class LoginWithPhoneLoadingState extends LoginWithPhoneState{
  const LoginWithPhoneLoadingState();
}
class LoginWithPhoneErrorMessageState extends LoginWithPhoneState{
  final String errorMessage ;

  const LoginWithPhoneErrorMessageState({required this.errorMessage});


}

class LoginWithPhoneSuccesMessageState extends LoginWithPhoneState{
  final String succesMessage ;
  final OwnerDataModel userModel ;

  const LoginWithPhoneSuccesMessageState({ required this.userModel, required this.succesMessage});
 
}