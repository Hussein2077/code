
import 'package:equatable/equatable.dart';

abstract class RoomVistorEvent extends Equatable {
  const RoomVistorEvent();

  @override
  List<Object> get props => [];
}


class GetAllRoomUserEvents extends RoomVistorEvent {
  final List<String> usersIds;
  final String ownerId ; 
  const GetAllRoomUserEvents({required this.usersIds , required this.ownerId });


}


class GetMoreRoomUserEvents extends RoomVistorEvent {

  final String ownerId ; 
  const GetMoreRoomUserEvents({ required this.ownerId });


}



