
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/core/model/room_user_messages_model.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/features/home/data/model/svga_data_model_.dart';
import 'package:tik_chat_v2/features/home/data/model/user_top_model.dart';
import 'package:tik_chat_v2/features/profile/data/model/get_config_key_model.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_config_key.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ExtraRoomDataModel.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/SendPrivateCommentModel.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/background_model.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/box_lucky_model.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/emojie_model.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/gifts_model.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/lucky_gift_model.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/room_vistor_model.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/ban_user_from_writing_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/cancel_game_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/enter_room.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/game_result_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/get_all_room_user_usecase.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/get_top_room.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/invite_to_game_new_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/invite_to_game_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/kickout_pramiter_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/mute_user_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/other_side_game_action_new.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/send_box_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/send_game_choise_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/send_gift_use_case.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/send_pob_up_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/start_game_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/up_mic_usecase.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/update_room_usecase.dart';


abstract class BaseRepositoryRoom {

  Future<Either<Failure, EnterRoomModel>> updateRoom(
      {required PramiterUpdate pramiterUpdate});
  Future<Either<EnterRoomModel, Failure>> enterRoom(
      EnterRoomPramiter pramiter);
  Future<Either<Unit, Failure>> exsitRoom(String ownerId);
 Future<Either<List<RoomVistorModel>, Failure>> getAllRoomUser(
      {required GetAlluserPram pram});
  Future<Either<List<BackGroundModel>, Failure>> getAllbackGround();
  Future<Either<List<EmojieModel>, Failure>> getEmojie();
  Future<Either<List<GiftsModel>,Failure>> getGifts(int type);
  Future<Either<String,Failure>> sendGifts(GiftPramiter giftPramiter);
  Future<Either<String, Failure>> removePassRoom (String ownerId);
  Future<Either<List<UserTopModel>,Failure>> getTopRankInRoom(TopPramiterInRoom topPramiter);
  Future<Either<String,Failure>> kickoutUser(KickoutPramiterUc kickoutPramiterUc) ;
  Future<Either<String,Failure>> upMic(UpMicrophonePramiter upMicrophonePramiter) ;
  Future<Either<String,Failure>> showPK(String ownerId);
  Future<Either<String,Failure>> startPK(String ownerId,String time);
  Future<Either<String,Failure>> closePK(String ownerId,String pkId);
  Future<Either<String,Failure>> addAdmin(String ownerId,String userId);
  Future<Either<String,Failure>> removeAdmin(String ownerId,String userId);
  Future<Either<String,Failure>> hidePK(String ownerId);
  Future<Either<List<UserDataModel>,Failure>> roomAdmins(String ownerId);
  Future<Either<String,Failure>> leaveMic(UpMicrophonePramiter upMicrophonePramiter) ;
  Future<Either<String,Failure>> muteMic(UpMicrophonePramiter upMicrophonePramiter) ;
  Future<Either<String,Failure>> unMuteMic(UpMicrophonePramiter upMicrophonePramiter) ;
  Future<Either<String,Failure>> lockMic(UpMicrophonePramiter upMicrophonePramiter) ;
  Future<Either<String,Failure>> unLockMic(UpMicrophonePramiter upMicrophonePramiter);
  Future<Either<String,Failure>> changeRoomMode(String ownerId,String roomMode);
  Future<Either<BoxLuckyModel,Failure>> getBoxes();
  Future<Either<Unit,Failure>> sendBox(LuckyBoxPramiter luckyBoxPramiter );
  Future<Either<String,Failure>> pickUpBox(String boxId);
  Future<Either<String,Failure>> banUserFromWriting(BanUserFromWritingPram banUserFromWritingPram );
  Future<Either<String,Failure>> sendPobUp(SendPobUpPram sendPobUpPram );
  Future<Either<String,Failure>> hideRoom();
  Future<Either<String,Failure>> disposehideRoom();
  Future<Either<String, Failure>> addRoomBackGround(  File roomBackGround);
  Future<Either<List<BackGroundModel>, Failure>> getMyAllbackGround();
  Future<Either<Unit,Failure>> muteUser(String ownerId, String userId,bool mute);
  Future<Either<GetConfigKeyModel, Failure>> getConfigKey(GetConfigKeyPram getConfigKeyPram  );
  Future<Either<String,Failure>> sendYallowBanner(SendPobUpPram sendPobUpPram );
  Future<Either<LuckyGiftModel , Failure>> sendLuckyGift(GiftPramiter giftPramiter);
  Future<Either<List<RoomUserMesseagesModel>,Failure>> getUsersInRoon(String userId);

  Future<Either<String,Failure>> muteUserMic(MuteUserMicPramiter muteUserMicPramiter) ;
  Future<Either<String,Failure>> unMuteUserMic(MuteUserMicPramiter muteUserMicPramiter) ;
  Future<Either<SvgaDataModel, Failure>> cacheGames(int type);

  Future<Either<String,Failure>> hostTimeOnMic(int time);

  Future<Either<String,Failure>> inviteToGame(InviteToGamePramiter inviteToGamePramiter) ;

  Future<Either<String,Failure>> cancelGame(CancelGamePramiter cancelGamePramiter) ;

  Future<Either<String,Failure>> startGame(StartGamePramiter startGamePramiter) ;

  Future<Either<String,Failure>> sendGameChoise(SendGameChoisePramiter sendGameChoisePramiter) ;

  Future<Either<String,Failure>> inviteToGameNew(InviteToGameNewPramiter inviteToGamePramiter) ;
  Future<Either<String,Failure>> otherSideGameActionNew(OtherSideGameActionNewPramiter otherSideGameActionNewPramiter) ;
  Future<Either<String,Failure>> gameresult(GameResultPramiter gameResultPramiter) ;
  Future<Either<ExtraRoomDataModel, Failure>> extraRoomData(String ownerId);
  Future<Either<SendPrivateCommentModel, Failure>> sendPrivateComment({required String userId, required String message, required String roomId});

}
