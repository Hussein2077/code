

import 'package:equatable/equatable.dart';

abstract class AccountStates extends Equatable{

}

class InitialAccountState extends AccountStates{


  @override
  List<Object?> get props => [];
}

class DeleteAccountSuccessState extends AccountStates{
  final String successMessage ;

  DeleteAccountSuccessState({ required this.successMessage});

  @override
  List<Object?> get props => [successMessage];

}
class DeleteAccountErrorState extends AccountStates{
  final String errorMessage ;

  DeleteAccountErrorState({ required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];

}
class DeleteAccountLoading extends AccountStates {
  @override
  List<Object?> get props => [];

}
class FacebookAccountSuccessState extends AccountStates{
  final String successMessage ;

  FacebookAccountSuccessState({ required this.successMessage});

  @override
  List<Object?> get props => [successMessage];

}
class FacebookAccountErrorState extends AccountStates{
  final String errorMessage ;

  FacebookAccountErrorState({ required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];

}
class FacebookAccountLoading extends AccountStates {
  @override
  List<Object?> get props => [];

}


class NumberAccountSuccessState extends AccountStates{
  final String successMessage ;

  NumberAccountSuccessState({ required this.successMessage});

  @override
  List<Object?> get props => [successMessage];

}
class NumberAccountErrorState extends AccountStates{
  final String errorMessage ;

  NumberAccountErrorState({ required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];

}
class NumberAccountLoading extends AccountStates {
  @override
  List<Object?> get props => [];

}





class GoogleAccountSuccessState extends AccountStates{
  final String successMessage ;

  GoogleAccountSuccessState({ required this.successMessage});

  @override
  List<Object?> get props => [successMessage];

}
class GoogleAccountErrorState extends AccountStates{
  final String errorMessage ;

  GoogleAccountErrorState({ required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];

}
class GoogleAccountLoading extends AccountStates {
  @override
  List<Object?> get props => [];

}