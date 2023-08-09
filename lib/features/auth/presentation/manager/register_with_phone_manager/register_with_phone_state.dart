
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';

abstract class RegisterWithPhoneState extends Equatable {
  const RegisterWithPhoneState();
  
  @override
  List<Object> get props => [];
}

class RegisterWithPhoneInitial extends RegisterWithPhoneState {}
class RegisterPhoneErrorMessageState extends RegisterWithPhoneState{
  final String errorMessage ;

  const RegisterPhoneErrorMessageState({required this.errorMessage});

 
}
class RegisterPhoneLoadingMessageState extends RegisterWithPhoneState{
 


 
}
class RegisterPhoneSuccesMessageState extends RegisterWithPhoneState{
  final String succesMessage ;
  final MyDataModel myDataModel ;

  const RegisterPhoneSuccesMessageState({ required this.myDataModel, required this.succesMessage});

}