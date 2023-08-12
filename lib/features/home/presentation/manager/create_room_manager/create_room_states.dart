
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/features/room/data/model/all_main_classes_model.dart';

abstract class CreateRoomStates extends Equatable {

}

class InitialRoomStates extends CreateRoomStates{
  @override
  List<Object?> get props =>[];
}

class CreateAudioRoomLoadingState extends CreateRoomStates{
  @override
  List<Object?> get props =>[];
}

class CreateAudioRoomErrorMessageState extends CreateRoomStates{
  final String errorMessage ;

  CreateAudioRoomErrorMessageState({required this.errorMessage});

  @override

  List<Object?> get props => [errorMessage];

}

class GetTypesRoomSuccesMessageState extends CreateRoomStates{
  final List<AllMainClassesModel> typesRoom ;

  GetTypesRoomSuccesMessageState({required this.typesRoom});

  @override
  List<Object?> get props => [typesRoom];
}

class GetTypesRoomLoadingState extends CreateRoomStates{
  @override
  List<Object?> get props =>[];
}

class GetTypesRoomErrorMessageState extends CreateRoomStates{
  final String errorMessage ;

  GetTypesRoomErrorMessageState({required this.errorMessage});

  @override

  List<Object?> get props => [errorMessage];

}

class CreateAudioRoomSuccesMessageState extends CreateRoomStates{
  final String roomData ;

  CreateAudioRoomSuccesMessageState({required this.roomData});

  @override
  List<Object?> get props => [roomData];
}