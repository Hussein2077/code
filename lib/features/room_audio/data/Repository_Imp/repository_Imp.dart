import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/core/model/room_user_messages_model.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/home/data/model/user_top_model.dart';
import 'package:tik_chat_v2/features/profile/data/model/get_config_key_model.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_config_key.dart';
import 'package:tik_chat_v2/features/room_audio/data/data_sorce/remotly_data_source_room.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/background_model.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/box_lucky_model.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/emojie_model.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/gifts_model.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/lucky_gift_model.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/room_vistor_model.dart';
import 'package:tik_chat_v2/features/room_audio/domine/Repository/Base_Repository_Profile.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/ban_user_from_writing_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/enter_room.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/get_all_room_user_usecase.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/get_top_room.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/kickout_pramiter_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/mute_user_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/send_box_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/send_gift_use_case.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/send_pob_up_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/up_mic_usecase.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/update_room_usecase.dart';




class RepositoryImpRoom extends BaseRepositoryRoom {
  final BaseRemotlyDataSourceRoom baseRemotlyDataSourceRoom;

  RepositoryImpRoom({required this.baseRemotlyDataSourceRoom});





 @override
  Future<Either<List<RoomVistorModel>, Failure>> getAllRoomUser({required GetAlluserPram pram}) async{

      try {
        final result = await baseRemotlyDataSourceRoom.getRoomUser(pram: pram);
        return left(result);
      } on Exception catch (e) {
        return Right(DioHelper.buildFailure(e));
      }
}

  @override
  Future<Either<List<BackGroundModel>, Failure>> getAllbackGround() async {
    try {
      final result = await baseRemotlyDataSourceRoom.getBackGround();
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }


  @override
  Future<Either<List<EmojieModel>, Failure>> getEmojie() async {
    try {
      final result = await baseRemotlyDataSourceRoom.getEmojie();
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }
  @override
  Future<Either<List<GiftsModel>, Failure>> getGifts(int type) async {
    try {
      final result = await baseRemotlyDataSourceRoom.getGifts(type);
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }



  @override
  Future<Either<String, Failure>> sendGifts(
      GiftPramiter giftPramiter) async {
    try {
      final result = await baseRemotlyDataSourceRoom.sendGifts(giftPramiter);
      return Left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<String, Failure>> removePassRoom(String ownerId) async {
    try {
      final result = await baseRemotlyDataSourceRoom.removePassRoom(ownerId);
      return left(result);
    } on Exception {
      return right(ServerFailure());
    }
  }

  @override
  Future<Either<List<UserTopModel>, Failure>> getTopRankInRoom(
      TopPramiterInRoom topPramiter) async {
    try {
      final result = await baseRemotlyDataSourceRoom.getTopInRoom(topPramiter);
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<String, Failure>> kickoutUser(
      KickoutPramiterUc kickoutPramiterUc) async {
    try {
      final result = await baseRemotlyDataSourceRoom.kickOutUser(kickoutPramiterUc);
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<String, Failure>> upMic(
      UpMicrophonePramiter upMicrophonePramiter) async {
    try {
      final result =
      await baseRemotlyDataSourceRoom.upMicrophone(upMicrophonePramiter);
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<String, Failure>> showPK(String ownerId) async {
    try {
      final result = await baseRemotlyDataSourceRoom.showPK(ownerId);
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<String, Failure>> startPK(String ownerId, String time) async {
    try {
      final result = await baseRemotlyDataSourceRoom.startPK(ownerId, time);
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<String, Failure>> closePK(String ownerId,String pkId) async {
    try {
      final result = await baseRemotlyDataSourceRoom.closePK(ownerId,pkId);
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<String, Failure>> addAdmin(String ownerId, String userId) async{
    try {
      final result = await baseRemotlyDataSourceRoom.addAdminRoom(ownerId, userId);
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<String, Failure>> hidePK(String ownerId) async{
    try {
      final result = await baseRemotlyDataSourceRoom.hidePK(ownerId);
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<String, Failure>> removeAdmin(String ownerId, String userId) async{
    try {
      final result = await baseRemotlyDataSourceRoom.removeAdmin(ownerId, userId);
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<List<UserDataModel>, Failure>> roomAdmins(String ownerId) async {
    try {
      final result = await baseRemotlyDataSourceRoom.adminsRoom(ownerId);
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<String, Failure>> leaveMic(UpMicrophonePramiter upMicrophonePramiter) async {
    try {
      final result = await baseRemotlyDataSourceRoom.leaveMicrophone(upMicrophonePramiter);
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<String, Failure>> muteMic(UpMicrophonePramiter upMicrophonePramiter) async{
    try {
      final result = await baseRemotlyDataSourceRoom.muteMicrophone(upMicrophonePramiter);
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<String, Failure>> unMuteMic(UpMicrophonePramiter upMicrophonePramiter) async{
    try {
      final result = await baseRemotlyDataSourceRoom.unmMuteMicrophone(upMicrophonePramiter);
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<String, Failure>> lockMic(UpMicrophonePramiter upMicrophonePramiter) async{
    try {
      final result = await baseRemotlyDataSourceRoom.lockMicrophone(upMicrophonePramiter);
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<String, Failure>> unLockMic(UpMicrophonePramiter upMicrophonePramiter) async{
    try {
      final result = await baseRemotlyDataSourceRoom.unLockMicrophone(upMicrophonePramiter);
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<String, Failure>> changeRoomMode(String ownerId, String roomMode)async {
    try {
      final result = await baseRemotlyDataSourceRoom.roomMode(ownerId, roomMode);
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }


  @override
  Future<Either<BoxLuckyModel, Failure>> getBoxes() async {
    try {
      final result = await baseRemotlyDataSourceRoom.getBoxes() ;
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<Unit, Failure>> sendBox(LuckyBoxPramiter luckyBoxPramiter) async  {
    try {
      final result = await baseRemotlyDataSourceRoom.sendBoxe(luckyBoxPramiter.boxId,luckyBoxPramiter.ownerId,luckyBoxPramiter.quintity) ;
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<String, Failure>> pickUpBox(String boxId) async {
    try {
      final result = await baseRemotlyDataSourceRoom.pickUpBoxe(boxId);
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<Failure, EnterRoomModel>> updateRoom(
      {required PramiterUpdate pramiterUpdate}) async {
   try {
      final failureOrDone = await baseRemotlyDataSourceRoom.updateRoom(
          pramiterUpdate: pramiterUpdate);
      return Right(failureOrDone);
   } on Exception catch (e) {
      return Left(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<EnterRoomModel, Failure>> enterRoom(
      EnterRoomPramiter pramiter) async {
    try {
      final failurOrDone = await baseRemotlyDataSourceRoom.enterRomm(
          ownerId: pramiter.ownerId, roomPassword: pramiter.roomPassword,
          ignorePassword: pramiter.ignoreRoomPassword, sendToZego: pramiter.sendToZego);
      return Left(failurOrDone);
    }  on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }

  }


  @override
  Future<Either<Unit, Failure>> exsitRoom(String ownerId) async {
    try {
      final failurOrDone =
      await baseRemotlyDataSourceRoom.exitRoom(ownerId: ownerId);
      return Left(failurOrDone);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }
  @override
  Future<Either<String, Failure>> banUserFromWriting(BanUserFromWritingPram banUserFromWritingPram) async{
    try {
      final result = await baseRemotlyDataSourceRoom.banUserFromWriting(banUserFromWritingPram.ownerId,
          banUserFromWritingPram.userId , banUserFromWritingPram.type) ;
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<String, Failure>> sendPobUp(sendPobUpPram)async {
    try {
      final result = await baseRemotlyDataSourceRoom.sendPopUp(sendPobUpPram.ownerId,sendPobUpPram.message) ;
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }
    @override
  Future<Either<String, Failure>> hideRoom() async {
    try {
      final result = await baseRemotlyDataSourceRoom.hideRoom();
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<String, Failure>> disposehideRoom()async {
    try {
      final result = await baseRemotlyDataSourceRoom.disposeHideRoom();
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<String, Failure>> addRoomBackGround(File roomBackGround)async {
   try {
      final result = await baseRemotlyDataSourceRoom.addRoomBackGround(roomBackGround);
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }
  
  @override
  Future<Either<List<BackGroundModel>, Failure>> getMyAllbackGround()async {
 try {
      final result = await baseRemotlyDataSourceRoom.getMyBackGround();
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<Unit, Failure>> muteUser(String ownerId,String userId,bool mute) async{
    try {
      final result = await baseRemotlyDataSourceRoom.muteUser(ownerId, userId,mute) ;
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<Unit, Failure>> inviteUser(String ownerId,String userId,int indexSeat) async{
    try {
      final result = await baseRemotlyDataSourceRoom.inviteUser(ownerId, userId, indexSeat) ;
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }

   @override
  Future<Either<GetConfigKeyModel, Failure>> getConfigKey(GetConfigKeyPram getConfigKeyPram) async{
      try {
      final result = await baseRemotlyDataSourceRoom.getConfigKey(getConfigKeyPram);
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }

  }

  @override
  Future<Either<String, Failure>> sendYallowBanner(SendPobUpPram sendPobUpPram)async {
    try {
      final result = await baseRemotlyDataSourceRoom.sendYallowBanner(sendPobUpPram.ownerId,sendPobUpPram.message);
      return left(result);
    } catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
    
  }


  @override
  Future<Either<LuckyGiftModel, Failure>> sendLuckyGift(GiftPramiter giftPramiter) async{
    try {
      final result = await baseRemotlyDataSourceRoom.sendLuckyGift(giftPramiter);
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<List<RoomUserMesseagesModel>, Failure>> getUsersInRoon(String userId) async{
    try {
      final result = await baseRemotlyDataSourceRoom.getUsersInRoon(userId);
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<String, Failure>> muteUserMic(MuteUserMicPramiter muteUserMicPramiter) async {
    try {
      final result =
      await baseRemotlyDataSourceRoom.muteUserMic(muteUserMicPramiter);
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<String, Failure>> unMuteUserMic(MuteUserMicPramiter muteUserMicPramiter) async {
    try {
      final result =
      await baseRemotlyDataSourceRoom.unMuteUserMic(muteUserMicPramiter);
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<String, Failure>> hostTimeOnMic(int time)async {
    try {
      final result =
          await baseRemotlyDataSourceRoom.hostTimeOnMic(time);
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }

}
