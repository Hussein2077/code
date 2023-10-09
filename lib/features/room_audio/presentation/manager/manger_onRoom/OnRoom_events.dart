import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class OnRoomEvents extends Equatable {
  const OnRoomEvents();
}

class InitRoomEvent extends OnRoomEvents{
  @override
  List<Object?> get props => [];

}





class GetBackGroundEvent extends OnRoomEvents {
  @override
  List<Object?> get props => [];
}

class ExitRoomEvent extends OnRoomEvents {
  final String ownerId;

  const ExitRoomEvent({required this.ownerId});

  @override
  List<Object?> get props => [ownerId];
}


class UpdateRoom extends OnRoomEvents{
  final String ownerId;
  final String? roomName;
  final String? freeMic;
  final File? roomCover;
  final  String? roomBackgroundId;
  final  String? roomIntro;
  final String? roomPass ;
  final String?  roomType;
  final String? roomClass;
  final String? change;

  const UpdateRoom(
      {
        required this.ownerId,
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
@override
  List<Object?> get props => [
   ownerId,
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
  final int type ;

  const GiftesEvent({required this.type});

  @override
  List<Object?> get props => [type];
}


class RemovePassRoomEvent extends OnRoomEvents {
 final String ownerId ;

 const RemovePassRoomEvent({required  this.ownerId});

  @override
  List<Object?> get props => [ownerId];
}

class UpMicEvent extends OnRoomEvents {
  final String ownerId;
  final String userId ;
  final String position ;

 const UpMicEvent({required this.ownerId, required this.userId, required this.position});

  @override
  List<Object?> get props =>[ownerId,userId,position];
}

class LeaveMicEvent extends OnRoomEvents {
  final String ownerId;
  final String userId ;


const  LeaveMicEvent({required this.ownerId, required this.userId});

  @override
  List<Object?> get props =>[ownerId,userId];
}

class MuteMicEvent extends OnRoomEvents {
  final String ownerId;
  final String position ;

const  MuteMicEvent({required this.ownerId, required this.position});

  @override
  List<Object?> get props =>[ownerId,position];
}

class UnMuteMicEvent extends OnRoomEvents {
  final String ownerId;
  final String position ;

 const UnMuteMicEvent({required this.ownerId, required this.position});

  @override
  List<Object?> get props =>[ownerId,position];
}
class LockMicEvent extends OnRoomEvents {
  final String ownerId;
  final String position ;

const LockMicEvent({required this.ownerId, required this.position});

  @override
  List<Object?> get props =>[ownerId,position];
}

class UnLockMicEvent extends OnRoomEvents {
  final String ownerId;
  final String position ;

  const UnLockMicEvent({required this.ownerId, required this.position});

  @override
  List<Object?> get props =>[ownerId,position];
}

class ChangeModeRoomEvent extends OnRoomEvents {
  final String ownerId;
  final String roomMode ;

 const ChangeModeRoomEvent({required this.ownerId, required this.roomMode});

  @override
  List<Object?> get props =>[ownerId,roomMode];
}

class RemoveChatRoomEvent extends OnRoomEvents {
  final String ownerId;


 const RemoveChatRoomEvent({required this.ownerId});

  @override
  List<Object?> get props =>[ownerId];
}
class BanUserFromWritingEvent extends OnRoomEvents{
  final String ownerId ;
  final String? userId ;
  final String? time ;
  final String type ; 

 const BanUserFromWritingEvent({required this.type ,  required this.ownerId,  this.userId, this.time});

  @override
  List<Object?> get props => [ownerId,userId,time,type];

}

class  SendPobUpEvent extends OnRoomEvents{

  final String ownerId ;
  final String message ;
 const SendPobUpEvent({required this.ownerId, required this.message});

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

class SendYallowBannerEvent extends OnRoomEvents{
  final String ownerId ;
  final String message ;
  const SendYallowBannerEvent({required this.ownerId, required this.message});

  @override
  List<Object?> get props => [ownerId,message];
}
