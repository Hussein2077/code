import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class CreateRoomEvents extends Equatable {

}


class CreateAudioRoomEvent extends CreateRoomEvents {
 final String roomIntero ;
  final String roomType ;
  final File roomCover ;
  final String  roomName ;
  final String  password ;

  CreateAudioRoomEvent({required this.roomName,required this.roomCover,required this.password,required this.roomIntero,required this.roomType});

  @override

  List<Object?> get props => [roomIntero,roomType,roomCover , roomName];

}

class GetTypesRoomEvent extends CreateRoomEvents {


  @override
  List<Object?> get props => [];

}