
import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/room/domine/Repository/Base_Repository_Profile.dart';


class ChangeRoomModeUC {

  BaseRepositoryRoom roomRepo;
  ChangeRoomModeUC({required this.roomRepo});

  Future<Either<String,Failure>>  changeRoomMode( String ownerId,String roomMode)async{
    return  await roomRepo.changeRoomMode(ownerId, roomMode);
  }
}