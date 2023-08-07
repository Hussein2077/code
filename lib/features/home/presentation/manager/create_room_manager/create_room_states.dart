
import 'package:equatable/equatable.dart';

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

class CreateAudioRoomSuccesMessageState extends CreateRoomStates{
  final String roomData ;

  CreateAudioRoomSuccesMessageState({required this.roomData});

  @override
  List<Object?> get props => [roomData];
}