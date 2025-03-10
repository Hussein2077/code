import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/domine/Repository/Base_Repository_Profile.dart';

class UpdateRoomUsecase {
  final BaseRepositoryRoom roomRepo;

  UpdateRoomUsecase({required this.roomRepo});
  Future<Either<Failure, EnterRoomModel>> updateRoom( PramiterUpdate pramiterUpdate) async {
      final result = await roomRepo.updateRoom(pramiterUpdate:pramiterUpdate);
      return result ;
  }
}

class PramiterUpdate extends Equatable {
  final String ownerId;
  final String? roomName;
  final String? freeMic;
  final File? roomCover;
  final  String? roomBackgroundId;
  final  String? roomIntro;
  final String? roomPass ;
  final String?  roomType;
  final String? roomClass;
  final String? change ; 

const  PramiterUpdate(
      {required this.ownerId,
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
