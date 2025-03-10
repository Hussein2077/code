// ignore_for_file: unnecessary_string_interpolations, avoid_print

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tik_chat_v2/core/model/room_user_messages_model.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
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
import 'package:tik_chat_v2/features/room_audio/domine/use_case/cancel_game_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/game_result_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/get_all_room_user_usecase.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/get_top_room.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/invite_to_game_new_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/invite_to_game_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/mute_user_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/other_side_game_action_new.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/send_game_choise_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/send_gift_use_case.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/start_game_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/up_mic_usecase.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/update_room_usecase.dart';
import '../../domine/use_case/kickout_pramiter_uc.dart';



abstract class BaseRemotlyDataSourceRoom {



  Future<EnterRoomModel> updateRoom({required PramiterUpdate pramiterUpdate});

  Future<EnterRoomModel> enterRomm(
      {required String ownerId, String? roomPassword , bool? ignorePassword,  bool? sendToZego});
  Future<Unit> exitRoom({required String ownerId});
  Future<List<RoomVistorModel>> getRoomUser({required GetAlluserPram pram});
  Future<List<BackGroundModel>> getBackGround();
  Future<List<UserTopModel>> getTopInRoom(TopPramiterInRoom topPramiter);
  Future<List<EmojieModel>> getEmojie();
  Future<List<GiftsModel>> getGifts(int type);
  Future<String> sendGifts(GiftPramiter giftPramiter);
  Future<String> removePassRoom(String ownerId);
  Future<String> kickOutUser(KickoutPramiterUc kickOutPramiter);
  Future<String> upMicrophone(UpMicrophonePramiter upMicrophonePramiter);
  Future<String> addAdminRoom(String ownerId,String userId );
  Future<String> removeAdmin(String ownerId,String userId ) ;
  Future<String> startPK(String ownerId, String time);
  Future<String> showPK(String ownerId);
  Future<String> hidePK(String ownerId );
  Future<String> closePK(String ownerId,String pkId);
  Future<List<UserDataModel>> adminsRoom(String ownerId);
  Future<String> leaveMicrophone(UpMicrophonePramiter upMicrophonePramiter);
  Future<String> muteMicrophone(UpMicrophonePramiter upMicrophonePramiter);
  Future<String> unmMuteMicrophone(UpMicrophonePramiter upMicrophonePramiter);
  Future<String> lockMicrophone(UpMicrophonePramiter upMicrophonePramiter);
  Future<String> unLockMicrophone(UpMicrophonePramiter upMicrophonePramiter);
  Future<String> roomMode(String ownerId,String roomMode);
  Future<BoxLuckyModel> getBoxes();
  Future<Unit> sendBoxe(String boxId , String ownerId,String quintity);
  Future<String> pickUpBoxe(String boxId );
  Future<String> banUserFromWriting(String ownerId,String? userId , String type);
  Future<String> sendPopUp(String ownerId,String message);
  Future<String> hideRoom();
  Future<String> disposeHideRoom();
  Future<String> addRoomBackGround(  File roomBackGround);
  Future<List<BackGroundModel>> getMyBackGround();
  Future<Unit> muteUser(String ownerId,String  userId ,bool mute) ;
   Future<GetConfigKeyModel> getConfigKey(GetConfigKeyPram? getConfigKeyPram) ;
  Future<LuckyGiftModel> sendLuckyGift(GiftPramiter giftPramiter);

  Future<String> sendYallowBanner(String ownerId, String message);

  Future<List<RoomUserMesseagesModel>> getUsersInRoon(String? userId);

  Future<String> muteUserMic(MuteUserMicPramiter muteUserMicPramiter);
  Future<String> unMuteUserMic(MuteUserMicPramiter muteUserMicPramiter);
  Future<String> hostTimeOnMic(int time);
  Future<String> inviteToGame(InviteToGamePramiter inviteToGamePramiter);
  Future<String> cancelGame(CancelGamePramiter cancelGamePramiter);
  Future<String> startGame(StartGamePramiter startGamePramiter);
  Future<String> sendGameChoise(SendGameChoisePramiter sendGameChoisePramiter);

  Future<String> inviteToGameNew(InviteToGameNewPramiter inviteToGamePramiter);
  Future<String> otherSideGameActionNew(OtherSideGameActionNewPramiter otherSideGameActionNewPramiter);
  Future<String> gameresult(GameResultPramiter gameResultPramiter);
  Future<ExtraRoomDataModel> getExtraRoomData(String OwnerId);
  Future<SendPrivateCommentModel> sendPrivateComment({required String userId, required String message, required String roomId});

}



class RemotlyDataSourceRoom extends BaseRemotlyDataSourceRoom {

static String uploadImagePrice = "" ; 

  @override
  Future<EnterRoomModel> enterRomm(
      {required String ownerId, String? roomPassword ,  bool? ignorePassword,
        bool? sendToZego}) async {
    final Map<String,dynamic> body = {
      ConstentApi.roomPass: roomPassword,
      ConstentApi.ownerId: ownerId,
    };
    if((ignorePassword != null && sendToZego != null)){
      body.putIfAbsent('ignorePassword', () => ignorePassword) ;
      body.putIfAbsent('sendToZego', () => 'no') ;
    }
     Map<String, String> headers = await DioHelper().header();
   try {
      final response = await Dio().post(ConstentApi.enterRoom,
          options: Options(
            headers: headers,
          ),
          data: body);

      if(response.data['success']){
        EnterRoomModel roomData = EnterRoomModel.fromJson(response.data['data']);
        return Future.value(roomData);
      }else{
        EnterRoomModel roomData = EnterRoomModel.fromJson(response.data['data']);
        return Future.value(roomData);
      }

    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e,endpointName: 'Enter Room');
    }


  }

  @override
  Future<Unit> exitRoom({required String ownerId}) async {
    final body = {ConstentApi.ownerId: ownerId};
    Map<String, String> headers = await DioHelper().header();


    try{
      await Dio().post(ConstentApi.exitRoom,
          options: Options(
            headers: headers,
          ),
          data: body);
      return Future.value(unit);
    } on DioError catch(e){
      throw DioHelper.handleDioError(dioError: e,endpointName:'Exit Room' );
    }


  }





@override
  Future<List<RoomVistorModel>> getRoomUser({required GetAlluserPram pram}) async {
    

    Map<String, String> headers = await DioHelper().header();
    String? users;
    final body;

    if (pram.usersId != null) {
      users = pram.usersId!.join(',');
    }
    if (pram.usersId != null) {
      body = {
        'page': pram.page, 'owner_id': pram.ownerId,
        "users": users
      };
    } else {
      body = {
        'page': pram.page,
        'owner_id': pram.ownerId,

      };
    }

    try {
      final response = await Dio().post(
        ConstentApi.getRoomUsers,
        data: body,
        options: Options(
          headers: headers,
        ),
      );
      Map<String, dynamic> resultData = response.data;
      log( response.data.toString());
      
      return List<RoomVistorModel>.from(
          resultData['data'].map((x) => RoomVistorModel.fromJson(x)));
    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e, endpointName: 'getRoomVistors');
    }
  }

  @override
  Future<List<BackGroundModel>> getBackGround() async {
    Map<String, String> headers = await DioHelper().header();

    try{
      final response = await Dio().get(ConstentApi.getBcakground,
          options: Options(
            headers: headers
          ));


          RemotlyDataSourceRoom.uploadImagePrice = response.data['message'];
      return List<BackGroundModel>.from((response.data["data"] as List)
          .map((e) => BackGroundModel.fromjson(e)));
    }on DioError catch(e){
      throw  DioHelper.handleDioError(dioError: e,endpointName:'Get BackGround');
    }

  }




  @override
  Future<EnterRoomModel> updateRoom(
      {required PramiterUpdate pramiterUpdate}) async {
    Map<String, String> headers = await DioHelper().header();
    FormData formData;
    log(pramiterUpdate.roomType.toString());
    if (pramiterUpdate.roomCover == null) {
      formData = FormData.fromMap({
        'room_name': pramiterUpdate.roomName,
        'free_mic': pramiterUpdate.freeMic,
        'room_background': pramiterUpdate.roomBackgroundId,
        'room_intro': pramiterUpdate.roomIntro,
        'room_pass': pramiterUpdate.roomPass,
        'room_type': pramiterUpdate.roomType,
        'room_class': pramiterUpdate.roomClass,
        'change': pramiterUpdate.change,
      });
    } else {
      File file = pramiterUpdate.roomCover!;
      String fileName = file.path.split('/').last;
      formData = FormData.fromMap({
        "room_cover":
        await MultipartFile.fromFile(file.path, filename: fileName),
        'room_name': pramiterUpdate.roomName,
        'free_mic': pramiterUpdate.freeMic,
        'room_background': pramiterUpdate.roomBackgroundId,
        'room_intro': pramiterUpdate.roomIntro,
        'room_pass': pramiterUpdate.roomPass,
        'room_type': pramiterUpdate.roomType,
        'room_class': pramiterUpdate.roomClass
      });
    }
    try{
      if(kDebugMode){
        log("""
        'owner_id' :${pramiterUpdate.ownerId}
        'room_name': ${pramiterUpdate.roomName},
        'free_mic': ${pramiterUpdate.freeMic},
        'room_background': ${pramiterUpdate.roomBackgroundId},
        'room_intro': ${pramiterUpdate.roomIntro},
        'room_pass': ${pramiterUpdate.roomPass},
        'room_type': ${pramiterUpdate.roomType},
        'room_class': ${pramiterUpdate.roomClass}""");
      }
      final response = await Dio()
          .post(ConstentApi().getRoomUpdate(roomId: pramiterUpdate.ownerId),
          options: Options(
            headers: headers,
          ),
          data: formData);
      final result = response.data;
      EnterRoomModel roomData = EnterRoomModel.fromJson(result['data']);
      return roomData;
    } on DioError catch(e){
      throw DioHelper.handleDioError(dioError: e,endpointName:'Update Room' );
    }
    

  }

  @override
  Future<List<EmojieModel>> getEmojie() async {
        Map<String, String> headers = await DioHelper().header();

    try{
      final response = await Dio().get(ConstentApi.getEmojie,
          options: Options(
            headers: headers,
          ));
      return List<EmojieModel>.from(
          (response.data["data"] as List).map((e) => EmojieModel.fromjson(e)));

    } on DioError catch(e){
      throw DioHelper.handleDioError(dioError: e,endpointName:'Get Emoji' );
    }
  }



  @override
  Future<List<GiftsModel>> getGifts(int type) async {
        Map<String, String> headers = await DioHelper().header();
  
    try{
      final response = await Dio().get(ConstentApi().getGifts(type),
          options: Options(
            headers: headers,
          ));
      Map<String, dynamic> jsonData = response.data;
      List<GiftsModel> giftsModelList = [];
      for (int i = 0; i < jsonData['data'].length; i++) {
        giftsModelList.add(GiftsModel.fromJson(jsonData['data'][i]));
      }
      return giftsModelList;
    } on DioError catch(e){
      throw DioHelper.handleDioError(dioError: e,endpointName: 'Get Gifts');
    }

  }






  @override
  Future<String> sendGifts(GiftPramiter giftPramiter) async {
        Map<String, String> headers = await DioHelper().header();

    final body = {
      'owner_id': giftPramiter.ownerId,
      'id': giftPramiter.id,
      'toUid': giftPramiter.toUid,
      'num': giftPramiter.num,
      //'to_zego': giftPramiter.toZego,
    };
    try {

      final response = await Dio().post(ConstentApi.sendGift,
          options: Options(
            headers: headers,
          ),
          data: body);
       log(response.data.toString());


        return response.data['message'] ;


    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e,endpointName:"Send Gifts" );
    }
  }

  @override
  Future<String> removePassRoom(String ownerId) async {
        Map<String, String> headers = await DioHelper().header();
   
    final body = {
      'owner_id': ownerId,
    };
    try{
      final response = await Dio().post(ConstentApi.removePassRoom,
          options: Options(
            headers: headers,
          ),
          data: body);
      Map<String, dynamic> jsonData = response.data;
      return jsonData['message'];
    }on DioError catch (e){
      throw DioHelper.handleDioError(dioError: e,endpointName: "Remove Pass Room");
    }
  }

  @override
  Future<List<UserTopModel>> getTopInRoom(TopPramiterInRoom topPramiter) async {
        Map<String, String> headers = await DioHelper().header();
    final body = {

      'type': topPramiter.date,
      'room_uid': topPramiter.roomId,
    };
    try {
      final response = await Dio().post(ConstentApi.getTopUrlInRoom,
          options: Options(
            headers: headers,
          ),
          data: body);
      log('${response.data}topPramiter.date');
      Map<String, dynamic> jsonData = response.data;
      List<UserTopModel> listTopUserModel = [];
      listTopUserModel = List<UserTopModel>.from(
          jsonData["data"].map((x) => UserTopModel.fromJson(x)));
      return listTopUserModel;

    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e,endpointName: "Get TopIn Room");
    }


  }

  @override
  Future<String> kickOutUser(kickOutPramiter) async {
        Map<String, String> headers = await DioHelper().header();
   

    final body = {
      'owner_id': kickOutPramiter.ownerId,
      'user_id': kickOutPramiter.userId,
      'minutes': kickOutPramiter.minutes,
    };
    try {
      final response = await Dio().post(ConstentApi.kickoutUser,
          options: Options(
            headers: headers,
          ),
          data: body);

      Map<String, dynamic> jsonData = response.data;

      return jsonData['message'];

    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e,endpointName:"kick Out User");
    }
  }

  @override
  Future<String> upMicrophone(UpMicrophonePramiter upMicrophonePramiter) async{
        Map<String, String> headers = await DioHelper().header();

    try {
      final response = await Dio()
          .post(ConstentApi().upMic(upMic:upMicrophonePramiter),
          options: Options(
            headers: headers,
          ));

      Map<String, dynamic> jsonData = response.data;

      return jsonData['message'];

    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e,endpointName: "up Microphone");
    }

  }

  @override
  Future<String> addAdminRoom(String ownerId, String userId) async{
        Map<String, String> headers = await DioHelper().header();
   

    final body ={
      'owner_id': ownerId,
      'user_id' :userId
    };

    try {
      final response = await Dio().post(ConstentApi.addAdmin,options: Options(
        headers: headers,

      ),data: body
      );

      Map<String, dynamic> jsonData = response.data;

      return jsonData['message'];

    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e,endpointName:"add Admin Room");
    }

  }

  @override
  Future<String> removeAdmin(String ownerId, String userId) async {
        Map<String, String> headers = await DioHelper().header();
   
    final body ={
      'owner_id': ownerId,
      'user_id' :userId
    };

    try {
      final response = await Dio().post(ConstentApi.removeAdmin,
          options: Options(
            headers: headers,

          ),data: body
      );

      Map<String, dynamic> jsonData = response.data;

      return jsonData['message'];

    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e,endpointName: "Remove Admin");
    }
  }

  @override
  Future<String> showPK(String ownerId) async{
        Map<String, String> headers = await DioHelper().header();
 

    final body ={
      'owner_id': ownerId,
    };

    try {
      final response = await Dio().post(ConstentApi.showPk,
          options: Options(
            headers: headers,

          ),data: body
      );

      Map<String, dynamic> jsonData = response.data;
      return jsonData['message'];

    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e,endpointName: "show PK");
    }
  }

  @override
  Future<String> startPK(String ownerId, String time) async {
        Map<String, String> headers = await DioHelper().header();
  

    final body ={
      'owner_id': ownerId,
      'minutes':time
    };
    try {
      final response = await Dio().post(ConstentApi.startPk,
          options: Options(
            headers: headers,
          ),
          data: body
      );

      Map<String, dynamic> jsonData = response.data;
      return jsonData['message'];

    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e,endpointName:"start PK" );
    }

  }

  @override
  Future<String> closePK(String ownerId ,String pkId) async {
        Map<String, String> headers = await DioHelper().header();
 

    final body ={
      'owner_id': ownerId,
      'pk_id':pkId
    };

    try {
      final response = await Dio().post(ConstentApi.closePk,
          options: Options(
            headers: headers,
          ),
          data: body
      );

      Map<String, dynamic> jsonData = response.data;
      return jsonData['message'];

    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e,endpointName: "close PK");
    }

  }

  @override
  Future<String> hidePK(String ownerId)async {
        Map<String, String> headers = await DioHelper().header();
 

    final body ={
      'owner_id': ownerId,
    };

    try {
      final response = await Dio().post(ConstentApi.hidePK,
          options: Options(
            headers: headers,
          ),
          data: body
      );

      Map<String, dynamic> jsonData = response.data;

      return jsonData['message'];

    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e,endpointName: "hide PK");
    }
  }

  @override
  Future<List<UserDataModel>> adminsRoom(String ownerId)  async{
        Map<String, String> headers = await DioHelper().header();
   

    final body ={
      'owner_id': ownerId,
    };

    try {
      final response = await Dio().post(ConstentApi.roomAdmins,
          options: Options(
            headers: headers,
          ),
          data: body
      );

      Map<String, dynamic> jsonData = response.data;


      return List<UserDataModel>.from(jsonData["data"].map((x) => UserDataModel.fromMap(x))) ;

    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e,endpointName:"Admins Room");
    }
  }

  @override
  Future<String> leaveMicrophone(UpMicrophonePramiter upMicrophonePramiter)async {
        Map<String, String> headers = await DioHelper().header();
        final body ={
      'owner_id': upMicrophonePramiter.ownerId,
      'user_id':upMicrophonePramiter.userId
    };

    try {
      final response = await Dio().post(ConstentApi.leaveMic,
          options: Options(
            headers: headers,
          ),
          data: body
      );

      Map<String, dynamic> jsonData = response.data;
      return jsonData['message'];

    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e,endpointName: "Leave Microphone");
    }
  }

  @override
  Future<String> muteMicrophone(UpMicrophonePramiter upMicrophonePramiter )async {
        Map<String, String> headers = await DioHelper().header();
   

    final body ={
      'owner_id': upMicrophonePramiter.ownerId,
      'position':upMicrophonePramiter.position
    };

    try {
      final response = await Dio().post(ConstentApi.muteMic,
          options: Options(
            headers: headers,
          ),
          data: body
      );

      Map<String, dynamic> jsonData = response.data;

      return jsonData['message'];

    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e,endpointName: "Mute Microphone");
    }
  }

  @override
  Future<String> unmMuteMicrophone(UpMicrophonePramiter upMicrophonePramiter) async{
        Map<String, String> headers = await DioHelper().header();
 

    final body ={
      'owner_id': upMicrophonePramiter.ownerId,
      'position':upMicrophonePramiter.position
    };

    try {
      final response = await Dio().post(ConstentApi.unMuteMic,
          options: Options(
            headers: headers,
          ),
          data: body
      );

      Map<String, dynamic> jsonData = response.data;

      return jsonData['message'];

    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e,endpointName:"unMute Microphone");
    }
  }

  @override
  Future<String> lockMicrophone(UpMicrophonePramiter upMicrophonePramiter) async{
        Map<String, String> headers = await DioHelper().header();

    final body ={
      'owner_id': upMicrophonePramiter.ownerId,
      'position': upMicrophonePramiter.position
    };

    try {
      final response = await Dio().post(ConstentApi.lockMic,
          options: Options(
            headers: headers,
          ),
          data: body
      );

      Map<String, dynamic> jsonData = response.data;

      return jsonData['message'];

    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e,endpointName:"Lock Microphone");
    }
  }

  @override
  Future<String> unLockMicrophone(UpMicrophonePramiter upMicrophonePramiter)async {
        Map<String, String> headers = await DioHelper().header();
 
    final body ={
      'owner_id': upMicrophonePramiter.ownerId,
      'position':upMicrophonePramiter.position
    };

    try {
      final response = await Dio().post(ConstentApi.unlockMic,
          options: Options(
            headers: headers,
          ),
          data: body
      );

      Map<String, dynamic> jsonData = response.data;

      return jsonData['message'];

    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e,endpointName:"unLock Microphone" );
    }
  }

  @override
  Future<String> roomMode(String ownerId, String roomMode) async {
        Map<String, String> headers = await DioHelper().header();
   

    final body ={
      'owner_id': ownerId,
      'mode':roomMode
    };

    try {
      final response = await Dio().post(ConstentApi.changeRoomMode,
          options: Options(
            headers: headers,
          ),
          data: body
      );

      Map<String, dynamic> jsonData = response.data;

      return jsonData['message'];

    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e,endpointName:"Room Mode");
    }

  }



  @override
  Future<BoxLuckyModel> getBoxes() async  {
        Map<String, String> headers = await DioHelper().header();
  

    try {
      final response = await Dio().get(ConstentApi.getBoxes,
        options: Options(
          headers: headers,
        ),
      );

      Map<String, dynamic> jsonData = response.data;

      BoxLuckyModel boxLuckyModel = BoxLuckyModel.fromJson(jsonData['data']);

      return boxLuckyModel ;

    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e,endpointName:"Get Box Lucky");
    }
  }

  @override
  Future<Unit> sendBoxe(String boxId, String ownerId,String quintity ) async{
        Map<String, String> headers = await DioHelper().header();
   

    final body ={
      'box_id': boxId,
      'room_uid' :ownerId,
      'users_num' : quintity
    };

    try {
    await Dio().post(ConstentApi.sendBox,
          options: Options(
            headers: headers,
          ),
          data:body
      );


      return Future.value(unit);

    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e,endpointName:"send Box" );
    }
  }

  @override
  Future<String> pickUpBoxe(String boxId) async {
        Map<String, String> headers = await DioHelper().header();


    final body ={
      'bid': boxId,
    };

    try {
      await Dio().post(ConstentApi.pickUpBoxes,
          options: Options(
            headers: headers,
          ),
          data:body
      );


   // todo chage that
      return 'succec';

    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e,endpointName:'pick Up Box' );
    }
  }

  @override
  Future<String> banUserFromWriting(String ownerId, String? userId , String type) async {
        Map<String, String> headers = await DioHelper().header();
  


    final body ={
      'owner_id': ownerId,
      'user_id' :userId
    };

    try {
      final response =  type=="ban"? await Dio().post(ConstentApi.banUserFromWriting,
          options: Options(
            headers: headers,
          ),
          data:body
      ):await Dio().post(ConstentApi.unBanUserFromWriting,
          options: Options(
            headers: headers,
          ),
          data:body
      );



      return  response.data['message'] ;

    }on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e,endpointName: 'banUserFromWriting');
    }
  }

  @override
  Future<String> sendPopUp(String ownerId,String message)async {
        Map<String, String> headers = await DioHelper().header();
  


    final body ={
      'owner_id': ownerId,
      'message':message
    };

    try {
      final response = await Dio().post(ConstentApi.pobUp,
          options: Options(
            headers: headers,
          ),
          data:body
      );


      return  response.data['message'] ;

    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e,endpointName: 'sendPopUp');
    }
  }

   @override
  Future<String> hideRoom() async {
        Map<String, String> headers = await DioHelper().header();
  

    try {
      //todo change url
      final response = await Dio().post(ConstentApi.prevsUse('room'),
          options: Options(
            headers: headers,
          ),
      );
      log(response.data.toString());


      return  response.data['message'] ;

    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e,endpointName:'hideRoom' );
    }
  }

  @override
  Future<String> disposeHideRoom()async {
        Map<String, String> headers = await DioHelper().header();
  

    try {

      final response = await Dio().post(ConstentApi.prevsUnUse('room'),
        options: Options(
          headers: headers,
        ),
      );
      log(response.data.toString());


      return  response.data['message'] ;

    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e,endpointName: 'disposeHideRoom');
    }
  }
  
  @override
  Future<String> addRoomBackGround(File roomBackGround)async {
         Map<String, String> headers = await DioHelper().header();
     FormData formData;
      File file =roomBackGround;
      String fileName = file.path.split('/').last;
       formData = FormData.fromMap({
        "image":
        await MultipartFile.fromFile(file.path, filename: fileName),
       

      });

    try{
      final response = await Dio().post(ConstentApi.uploadBackGround,
          options: Options(
            headers: headers,
          ),
          data: formData);
      final result = response.data;
      log(result.toString());
      return result['message'];
    } on DioError catch(e){
      throw DioHelper.handleDioError(dioError: e,endpointName:'addRoomBackGround' );
    }
  }

    @override
  Future<List<BackGroundModel>> getMyBackGround() async {
    Map<String, String> headers = await DioHelper().header();

    try{
      final response = await Dio().get(ConstentApi.getMyBackGround,
          options: Options(
            headers: headers
          ));
      return List<BackGroundModel>.from((response.data["data"] as List)
          .map((e) => BackGroundModel.fromjson(e)));
    }on DioError catch(e){
      throw  DioHelper.handleDioError(dioError: e,endpointName:'getMyBackGround' );
    }

  }

  @override
  Future<Unit> muteUser(String ownerId,String userId,bool mute)async {
    Map<String, String> headers = await DioHelper().header();

  Map<String,dynamic> mapToZego =
  {
    'id_user':userId ,
   'mute' : mute
  };

    final body ={
      'owner_id': ownerId,
      'message' :'muteUser',
      'ext':jsonEncode(mapToZego) ,
      'action':'SendCustomCommand'
    };

    try {
      await Dio().post(ConstentApi.sentToZego,
          options: Options(
            headers: headers,
          ),
          data: body
      );



      return Future.value(unit);

    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e,endpointName:'muteUser' );
    }
  }

    @override
  Future<GetConfigKeyModel> getConfigKey(GetConfigKeyPram? getConfigKeyPram) async{

     Map<String, String> headers = await DioHelper().header();
     final Map<String,dynamic> body  ;
 if (getConfigKeyPram==null){
    body = {
      'keys': [],
      "enable-special" : 1
     
      
      };
 }else {
  body = {
      'keys': [getConfigKeyPram.specialBar],
      "enable-special" : 1
     
      
      };
 }
   


    try {
      final response = await Dio().post(ConstentApi.getConfigKey,
          options: Options(
            headers: headers,
          ),
          data: body);
          final result =GetConfigKeyModel.fromJson(response.data['data']);
        log(result.toString());
      return  result ;
    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e,endpointName: 'getConfigKey');
    }

    

  }
  
  @override
  Future<String> sendYallowBanner(String ownerId, String message)async {
    Map<String, String> headers = await DioHelper().header();

    final body = {
      'room_id': ownerId,
      'message': message};


   try {
      final response = await Dio().post(ConstentApi.yallowBanner,
          options: Options(
            headers: headers,
          ),
          data: body);
      return response.data['message'];
    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e,endpointName: 'yellowBanner');
    }
  }


   @override
  Future<List<RoomUserMesseagesModel>> getUsersInRoon(String? userId) async {
    Map<String, String> headers = await DioHelper().header();

    final body = {'users_ids': userId};
    try {
      final response = await Dio().post(ConstentApi.getUsersCommenstInRoom,
          options: Options(
            headers: headers,
          ),
          data: body);
      Map<String, dynamic> resultData = response.data;
      log(resultData.toString());
      return List<RoomUserMesseagesModel>.from(resultData['data'].map((x) => RoomUserMesseagesModel.fromJson(x)));
    } on DioError catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: 'getUsersInRoon');
    }
      
  }

@override
Future<LuckyGiftModel> sendLuckyGift(GiftPramiter giftPramiter) async{
  Map<String, String> headers = await DioHelper().header();

  final body = {
    'owner_id': giftPramiter.ownerId,
    'id': giftPramiter.id,
    'toUid': giftPramiter.toUid,
    'num': giftPramiter.num,
    'to_zego': giftPramiter.toZego
  };
  try {
    final response = await Dio().post(ConstentApi.sendLuckyGift,
        options: Options(
          headers: headers,
        ),
        data: body);
    log(response.data.toString());

    return LuckyGiftModel.fromJosn(response.data);
  } on DioError catch (e) {
    throw DioHelper.handleDioError(dioError: e, endpointName: 'sendLuckyGift');
  }
}

@override
Future<String> muteUserMic(MuteUserMicPramiter muteUserMicPramiter)async {
  Map<String, String> headers = await DioHelper().header();


  final body ={
    'user_id': muteUserMicPramiter.userId,
    'owner_id': muteUserMicPramiter.ownerId,
  };

  try {
    final response = await Dio().post(ConstentApi.muteUserMic,
        options: Options(
          headers: headers,
        ),
        data: body
    );

    Map<String, dynamic> jsonData = response.data;

    return jsonData['message'];

  } on DioError catch (e) {
    throw DioHelper.handleDioError(dioError: e,endpointName: "Mute User Microphone");
  }
}

@override
Future<String> unMuteUserMic(MuteUserMicPramiter muteUserMicPramiter)async {
  Map<String, String> headers = await DioHelper().header();


  final body ={
    'user_id': muteUserMicPramiter.userId,
    'owner_id': muteUserMicPramiter.ownerId,
  };

  try {
    final response = await Dio().post(ConstentApi.unMuteUserMic,
        options: Options(
          headers: headers,
        ),
        data: body
    );

    Map<String, dynamic> jsonData = response.data;

    return jsonData['message'];

  } on DioError catch (e) {
    throw DioHelper.handleDioError(dioError: e,endpointName: "Mute User Microphone");
  }
}

  @override
  Future<String> hostTimeOnMic(int time)async {
    Map<String, String> headers = await DioHelper().header();
    final body ={
      'sec': time

    };

    try {
      final response = await Dio().post(ConstentApi.hostOnMicTime,
          options: Options(
            headers: headers,
          ),
          data: body
      );

      Map<String, dynamic> jsonData = response.data;

      return jsonData['message'];

    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e,endpointName: "HostTimeOnMic");
    }
  }

@override
Future<String> inviteToGame(InviteToGamePramiter inviteToGamePramiter)async {
  Map<String, String> headers = await DioHelper().header();

  final body ={
    'player_two_id': inviteToGamePramiter.userId,
    'owner_id': inviteToGamePramiter.ownerId,
    'coins': inviteToGamePramiter.coins,
    "game_id": inviteToGamePramiter.game_id,
  };

  try {
    final response = await Dio().post(
        ConstentApi.inviteToGame,
        options: Options(
          headers: headers,
        ),
        data: body
    );
    Map<String, dynamic> jsonData = response.data;
    return jsonData['message'];
  } on DioError catch (e) {
    throw DioHelper.handleDioError(dioError: e,endpointName: "invite user to game");
  }
}

@override
Future<String> cancelGame(CancelGamePramiter cancelGamePramiter)async {
  Map<String, String> headers = await DioHelper().header();

  final body ={
    'game_record_id': cancelGamePramiter.gameId,
    'status': "reject"
  };

  try {
    final response = await Dio().post(
        ConstentApi.acceptOrCancelGame,
        options: Options(
          headers: headers,
        ),
        data: body
    );
    Map<String, dynamic> jsonData = response.data;
    return jsonData['message'];
  } on DioError catch (e) {
    throw DioHelper.handleDioError(dioError: e,endpointName: "cancel game");
  }
}

@override
Future<String> startGame(StartGamePramiter startGamePramiter)async {
  Map<String, String> headers = await DioHelper().header();

  final body ={
    'game_record_id': startGamePramiter.gameId,
    'status': "accept"
  };

  try {
    final response = await Dio().post(
        ConstentApi.acceptOrCancelGame,
        options: Options(
          headers: headers,
        ),
        data: body
    );
    Map<String, dynamic> jsonData = response.data;
    return jsonData['message'];
  } on DioError catch (e) {
    throw DioHelper.handleDioError(dioError: e,endpointName: "start game");
  }
}

@override
Future<String> sendGameChoise(SendGameChoisePramiter sendGameChoisePramiter)async {
  Map<String, String> headers = await DioHelper().header();

  final body ={
    'game_record_id': sendGameChoisePramiter.gameId,
    'answer': sendGameChoisePramiter.answer
  };

  try {
    final response = await Dio().post(
        ConstentApi.sendGameChoise,
        options: Options(
          headers: headers,
        ),
        data: body
    );
    Map<String, dynamic> jsonData = response.data;
    return jsonData['message'];
  } on DioError catch (e) {
    throw DioHelper.handleDioError(dioError: e,endpointName: "send game choise");
  }
}

@override
Future<String> inviteToGameNew(InviteToGameNewPramiter inviteToGameNewPramiter)async {
  Map<String, String> headers = await DioHelper().header();

  final body = {
    "owner_id": inviteToGameNewPramiter.ownerId,
    "game_id": inviteToGameNewPramiter.game_id,
    "players": inviteToGameNewPramiter.players,
    "coins": inviteToGameNewPramiter.coins,
    "round_num": inviteToGameNewPramiter.round_num
  };

  try {
    final response = await Dio().post(
        ConstentApi.inviteToGameNew,
        options: Options(
          headers: headers,
        ),
        data: body
    );
    Map<String, dynamic> jsonData = response.data;
    return jsonData['message'];
  } on DioError catch (e) {
    throw DioHelper.handleDioError(dioError: e,endpointName: "invite user to game new");
  }
}

@override
Future<String> otherSideGameActionNew(OtherSideGameActionNewPramiter otherSideGameActionNewPramiter)async {
  Map<String, String> headers = await DioHelper().header();

  final body ={
    'game_record_id': otherSideGameActionNewPramiter.gameId,
    'status': otherSideGameActionNewPramiter.status
  };

  try {
    final response = await Dio().post(
        ConstentApi.otherSideGameActionNew,
        options: Options(
          headers: headers,
        ),
        data: body
    );
    Map<String, dynamic> jsonData = response.data;
    return jsonData['message'];
  } on DioError catch (e) {
    throw DioHelper.handleDioError(dioError: e,endpointName: "otherSideGameActionNew");
  }
}

@override
Future<String> gameresult(GameResultPramiter gameResultPramiter)async {
  Map<String, String> headers = await DioHelper().header();


  final body ={
    'game_record_id': gameResultPramiter.gameId,
    'answer': gameResultPramiter.answer,
    'round': gameResultPramiter.round,
  };

  try {
    final response = await Dio().post(
        ConstentApi.gameResult,
        options: Options(
          headers: headers,
        ),
        data: body
    );
    Map<String, dynamic> jsonData = response.data;
    return jsonData['message'];
  } on DioError catch (e) {
    throw DioHelper.handleDioError(dioError: e,endpointName: "gameresult");
  }
}

@override
Future<ExtraRoomDataModel> getExtraRoomData(String OwnerId) async {
  Map<String, String> headers = await DioHelper().header();

  try {
    final response = await Dio().get(ConstentApi().getExtraRoomData(OwnerId),
        options: Options(
          headers: headers,
        ));
    Map<String, dynamic> jsonData = response.data;
    return ExtraRoomDataModel.fromJson(jsonData);
  } on DioError catch (e) {
    throw DioHelper.handleDioError(dioError: e, endpointName: 'getGifts');
  }
}

@override
Future<SendPrivateCommentModel> sendPrivateComment({required String userId, required String message, required String roomId})async {
  Map<String, String> headers = await DioHelper().header();

  final body ={
    'message': message,
    'to_user_id': userId,
  };

  try {
    final response = await Dio().post(
        ConstentApi.sendPrivateComment(roomId),
        options: Options(
          headers: headers,
        ),
        data: body
    );
    Map<String, dynamic> jsonData = response.data;
    return SendPrivateCommentModel.fromJson(jsonData);
  } on DioError catch (e) {
    throw DioHelper.handleDioError(dioError: e,endpointName: "sendPrivateComment");
  }
}

}
