import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/features/room/data/model/ente_room_model.dart';

abstract class RoomHandlerStates extends Equatable {

}


class InitialHandlerRoomStates extends RoomHandlerStates{
  @override
  List<Object?> get props =>[];
}


class EnterRoomErrorMessageState extends RoomHandlerStates {
  final String errorMessage;

  EnterRoomErrorMessageState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];

}

class EnterRoomLaoding extends RoomHandlerStates {


  EnterRoomLaoding();

  @override
  List<Object?> get props => [];
}

class EnterRoomSuccesMessageState extends RoomHandlerStates {
  final EnterRoomModel room;

  EnterRoomSuccesMessageState({
    required this.room,
  });

  @override
  List<Object?> get props => [room];
}