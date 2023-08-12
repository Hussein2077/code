import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class OnRoomEvents extends Equatable {
  const OnRoomEvents();
}

class InitEvent extends OnRoomEvents{
  @override
  List<Object?> get props => [];

}

class emitShowEmojieSuccessEvent extends OnRoomEvents{
  @override
  List<Object?> get props => [];

}
class GetAllRoomUserEvents extends OnRoomEvents {
  final String ownerId;
  GetAllRoomUserEvents({required this.ownerId});

  @override
  List<Object?> get props => [ownerId];
}


class GetBackGroundEvent extends OnRoomEvents {
  @override
  List<Object?> get props => [];
}

class ExitRoomEvent extends OnRoomEvents {
  final String ownerId;

  ExitRoomEvent({required this.ownerId});

  @override
  List<Object?> get props => [ownerId];
}
class UpdateRoom extends OnRoomEvents{
  final int roomId;
  final String? roomName;
  final String? freeMic;
  final File? roomCover;
  final  String? roomBackgroundId;
  final  String? roomIntro;
  final String? roomPass ;
  final String?  roomType;
  final String? roomClass;
  final String? change;

  UpdateRoom(
      {required this.roomId,
        this.roomName,
        this.freeMic,
        this.roomCover,
        this.roomBackgroundId,
        this.roomIntro,
        this.roomPass,
        this.roomType,
        this.roomClass,
        this.change , 
      });

  List<Object?> get props => [
    roomId,
    roomName,
    freeMic,
    roomCover,
    roomBackgroundId,
    roomIntro,
    roomPass ,
    roomType,
    roomClass,
    change,
  ];
}

class EmojieEvent extends OnRoomEvents {
  @override
  List<Object?> get props => [];
}
class GiftesEvent extends OnRoomEvents {
  int type ;

  GiftesEvent({required this.type});

  @override
  List<Object?> get props => [type];
}

class ShowEmojieEvent extends OnRoomEvents {
  String id;
  String roomId ;
  String userId ;
  String toZego ;
  ShowEmojieEvent({required this.toZego , required this.id,required this.userId,required this.roomId});

  @override
  List<Object?> get props => [id,roomId,userId];

}
class RemovePassRoomEvent extends OnRoomEvents {
  String ownerId ;

  RemovePassRoomEvent({required  this.ownerId});

  @override
  List<Object?> get props => [ownerId];
}

class UpMicEvent extends OnRoomEvents {
  final String ownerId;
  final String userId ;
  final String position ;

  UpMicEvent({required this.ownerId, required this.userId, required this.position});

  @override
  List<Object?> get props =>[ownerId,userId,position];
}

class LeaveMicEvent extends OnRoomEvents {
  final String ownerId;
  final String userId ;


  LeaveMicEvent({required this.ownerId, required this.userId});

  @override
  List<Object?> get props =>[ownerId,userId];
}

class MuteMicEvent extends OnRoomEvents {
  final String ownerId;
  final String position ;

  MuteMicEvent({required this.ownerId, required this.position});

  @override
  List<Object?> get props =>[ownerId,position];
}

class UnMuteMicEvent extends OnRoomEvents {
  final String ownerId;
  final String position ;

  UnMuteMicEvent({required this.ownerId, required this.position});

  @override
  List<Object?> get props =>[ownerId,position];
}
class LockMicEvent extends OnRoomEvents {
  final String ownerId;
  final String position ;

  LockMicEvent({required this.ownerId, required this.position});

  @override
  List<Object?> get props =>[ownerId,position];
}

class UnLockMicEvent extends OnRoomEvents {
  final String ownerId;
  final String position ;

  UnLockMicEvent({required this.ownerId, required this.position});

  @override
  List<Object?> get props =>[ownerId,position];
}

class ChangeModeRoomEvent extends OnRoomEvents {
  final String ownerId;
  final String roomMode ;

  ChangeModeRoomEvent({required this.ownerId, required this.roomMode});

  @override
  List<Object?> get props =>[ownerId,roomMode];
}

class RemoveChatRoomEvent extends OnRoomEvents {
  final String ownerId;


  RemoveChatRoomEvent({required this.ownerId});

  @override
  List<Object?> get props =>[ownerId];
}
class BanUserFromWritingEvent extends OnRoomEvents{
  final String ownerId ;
  final String? userId ;
  final String? time ;
  final String type ; 

  BanUserFromWritingEvent({required this.type ,  required this.ownerId,  this.userId, this.time});

  @override
  List<Object?> get props => [ownerId,userId,time,type];

}

class  SendPobUpEvent extends OnRoomEvents{

  final String ownerId ;
  final String message ;
  SendPobUpEvent({required this.ownerId, required this.message});

  @override
  List<Object?> get props => [ownerId,message];
}

class  HideRoomEvent extends OnRoomEvents{

  const HideRoomEvent();

  @override
  List<Object?> get props => [];
}

class  DisposeHideRoomEvent extends OnRoomEvents{

  const DisposeHideRoomEvent();

  @override
  List<Object?> get props => [];
}
