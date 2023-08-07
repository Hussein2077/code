import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class CreateRoomEvents extends Equatable {

}


class CreateAudioRoomEvent extends CreateRoomEvents {
  String roomIntero ;
  String roomType ;
  File roomCover ;
  String  roomName ;

  CreateAudioRoomEvent({required this.roomName,required this.roomCover,required this.roomIntero,required this.roomType});

  @override

  List<Object?> get props => [roomIntero,roomType,roomCover];

}