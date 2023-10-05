

import 'package:equatable/equatable.dart';

abstract class UsersInRoomEvents extends Equatable {
  const UsersInRoomEvents();
}

class InitEvent extends UsersInRoomEvents{
  @override
  List<Object?> get props => [];

}

class MuteUserInRoom extends UsersInRoomEvents{
  final String ownerId;
  final String userId ;


  MuteUserInRoom({required this.ownerId,required this.userId});

  @override
  List<Object?> get props => [ownerId,userId];

}

class UnMuteUserInRoom extends UsersInRoomEvents{
  final String ownerId;
  final String userId ;

  UnMuteUserInRoom({required this.ownerId,required this.userId});

  @override
  List<Object?> get props => [ownerId,userId];
}

class InviteUserInRoom extends UsersInRoomEvents{
  final String ownerId;
  final String userId ;
  final int indexSeate ;

  InviteUserInRoom({required this.ownerId,required this.userId,required this.indexSeate});

  @override
  List<Object?> get props => [ownerId,userId,indexSeate];
}
class kickoutUser extends UsersInRoomEvents{
  final String ownerId ;
  final String userId ;
  final String minutes ;

  kickoutUser({required this.ownerId,required this.userId, required this.minutes});

  @override
  List<Object?> get props => [ownerId,userId,minutes];

}