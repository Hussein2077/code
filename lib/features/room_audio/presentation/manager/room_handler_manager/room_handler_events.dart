



import 'package:equatable/equatable.dart';

abstract class RoomHandlerEvents extends Equatable {

}

class EnterRoomEvent extends RoomHandlerEvents {
  final String  ownerId ;
  final  String  roomPassword ;
  final int isVip ;


  EnterRoomEvent({required this.isVip ,  required this.ownerId,required this.roomPassword});

  @override

  List<Object?> get props => [ownerId,roomPassword,isVip];

}