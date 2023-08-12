



import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/features/room/data/model/box_lucky_model.dart';


abstract class LuckyBoxesStates extends Equatable{

}


class InitialLuckyBoxesState extends LuckyBoxesStates{
  @override
  List<Object?> get props => [];

}
class LoadingLuckyBoxesState extends LuckyBoxesStates{
  @override
  List<Object?> get props => [];

}
class SuccessLuckyBoxesState extends LuckyBoxesStates{
  final BoxLuckyModel boxLuckyModel ;


  SuccessLuckyBoxesState({required this.boxLuckyModel});

  @override
  List<Object?> get props => [boxLuckyModel];

}

class ErrorLuckyBoxesState extends LuckyBoxesStates{
 final String errorMessage ;

   ErrorLuckyBoxesState({required this.errorMessage});

  @override
  List<Object?> get props => [];

}

class LoadingSendBoxesState extends LuckyBoxesStates{
  @override
  List<Object?> get props => [];

}
class SuccessSendBoxesState extends LuckyBoxesStates{
  final String succeccMessage ;


  SuccessSendBoxesState({required this.succeccMessage});

  @override
  List<Object?> get props => [succeccMessage];

}

class ErrorSendBoxesState extends LuckyBoxesStates{
 final String errorMessage ;

  ErrorSendBoxesState({required this.errorMessage});

  @override
  List<Object?> get props => [];

}

class LoadingPickUpBoxesState extends LuckyBoxesStates{
  @override
  List<Object?> get props => [];

}
class SuccessPickUpBoxesState extends LuckyBoxesStates{
  final String succeccMessage ;


  SuccessPickUpBoxesState({required this.succeccMessage});

  @override
  List<Object?> get props => [succeccMessage];

}
class ErrorPickUpBoxesState extends LuckyBoxesStates{
 final String errorMessage ;

  ErrorPickUpBoxesState({required this.errorMessage});

  @override
  List<Object?> get props => [];

}