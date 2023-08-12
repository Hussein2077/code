import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/home/data/model/user_top_model.dart';
import 'package:tik_chat_v2/features/home/domin/use_case/get_top_usecase.dart';
import 'package:tik_chat_v2/features/profile/data/model/get_config_key_model.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_config_key.dart';
import 'package:tik_chat_v2/features/room/data/model/background_model.dart';
import 'package:tik_chat_v2/features/room/data/model/box_lucky_model.dart';
import 'package:tik_chat_v2/features/room/data/model/emojie_model.dart';
import 'package:tik_chat_v2/features/room/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room/data/model/get_room_users_model.dart';
import 'package:tik_chat_v2/features/room/data/model/gifts_model.dart';
import 'package:tik_chat_v2/features/room/domine/use_case/send_gift_use_case.dart';
import 'package:tik_chat_v2/features/room/domine/use_case/up_mic_usecase.dart';
import 'package:tik_chat_v2/features/room/domine/use_case/update_room_usecase.dart';

import '../../domine/use_case/kickout_pramiter_uc.dart';



abstract class BaseRemotlyDataSourceRoom {



  Future<EnterRoomModel> updateRoom({required PramiterUpdate pramiterUpdate});

  Future<EnterRoomModel> enterRomm(
      {required String ownerId, String? roomPassword , bool? ignorePassword,  bool? sendToZego});
  Future<Unit> exitRoom({required String ownerId});
  Future<GetRoomUsersModel> getRoomUser({required String ownerid});
  Future<List<BackGroundModel>> getBackGround();
  Future<List<UserTopModel>> getTopInRoom(TopPramiter topPramiter);
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
  Future<String> closePK(String ownerId);
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
  Future<Unit> inviteUser(String ownerId,String  userId ,int indexSeat) ;
   Future<GetConfigKeyModel> getConfigKey(GetConfigKeyPram? getConfigKeyPram) ;



}




class RemotlyDataSourceRoom extends BaseRemotlyDataSourceRoom {


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
      throw DioHelper.handleDioError(e);
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
      throw DioHelper.handleDioError(e);
    }


  }






  @override
  Future<GetRoomUsersModel> getRoomUser({required String ownerid}) async {
    Map<String, String> headers = await DioHelper().header();

    try{
      final response = await Dio().post(
        ConstentApi.getRoomUsers,
        data: {"owner_id": ownerid},
        options: Options(
          headers:headers ,
        ),
      );
      return GetRoomUsersModel.fromjson(response.data["data"]);
    }on DioError catch (e){
      throw DioHelper.handleDioError(e);
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
      return List<BackGroundModel>.from((response.data["data"] as List)
          .map((e) => BackGroundModel.fromjson(e)));
    }on DioError catch(e){
      throw  DioHelper.handleDioError(e);
    }

  }




  @override
  Future<EnterRoomModel> updateRoom(
      {required PramiterUpdate pramiterUpdate}) async {
    Map<String, String> headers = await DioHelper().header();

    FormData formData;
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
      final response = await Dio()
          .post(ConstentApi().getRoomUpdate(roomId: pramiterUpdate.roomId),
          options: Options(
            headers: headers,
          ),
          data: formData);
      final result = response.data;
      EnterRoomModel roomData = EnterRoomModel.fromJson(result['data']);
      return roomData;
    } on DioError catch(e){
      throw DioHelper.handleDioError(e);
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
      throw DioHelper.handleDioError(e);
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
      throw DioHelper.handleDioError(e);
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
      'to_zego': giftPramiter.toZego
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
      throw DioHelper.handleDioError(e);
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
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<List<UserTopModel>> getTopInRoom(TopPramiter topPramiter) async {
        Map<String, String> headers = await DioHelper().header();
  

    final body = {
      'class': topPramiter.sendOrReceiver,
      'type': topPramiter.date,
      'room_uid': topPramiter.roomId,
      'is_home': '0'
    };
    try {
      final response = await Dio().post(ConstentApi.getTopUrl,
          options: Options(
            headers: headers,
          ),
          data: body);

      Map<String, dynamic> jsonData = response.data;
      List<UserTopModel> listTopUserModel = [];
      listTopUserModel = List<UserTopModel>.from(
          jsonData["data"].map((x) => UserTopModel.fromJson(x)));
      return listTopUserModel;

    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
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
      throw DioHelper.handleDioError(e);
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
      throw DioHelper.handleDioError(e);
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
      throw DioHelper.handleDioError(e);
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
      throw DioHelper.handleDioError(e);
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
      throw DioHelper.handleDioError(e);
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
      throw DioHelper.handleDioError(e);
    }

  }

  @override
  Future<String> closePK(String ownerId) async {
        Map<String, String> headers = await DioHelper().header();
 

    final body ={
      'owner_id': ownerId,
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
      throw DioHelper.handleDioError(e);
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
      throw DioHelper.handleDioError(e);
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
      throw DioHelper.handleDioError(e);
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

      throw DioHelper.handleDioError(e);
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
      throw DioHelper.handleDioError(e);
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
      throw DioHelper.handleDioError(e);
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
      throw DioHelper.handleDioError(e);
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
      throw DioHelper.handleDioError(e);
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
      throw DioHelper.handleDioError(e);
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
      throw DioHelper.handleDioError(e);
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
      throw DioHelper.handleDioError(e);
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
      throw DioHelper.handleDioError(e);
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
      throw DioHelper.handleDioError(e);
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


      return  response.data['data']['message'] ;

    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
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
      throw DioHelper.handleDioError(e);
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
      throw DioHelper.handleDioError(e);
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
      throw DioHelper.handleDioError(e);
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
      throw  DioHelper.handleDioError(e);
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
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<Unit> inviteUser(String ownerId,String userId,int indexSeat)async {
    Map<String, String> headers = await DioHelper().header();

    Map<String,dynamic> mapToZego =
    {
      'id_user':userId ,
      'index' : indexSeat
    };

    final body ={
      'owner_id': ownerId,
      'message' :'inviteToSeat',
      'ext':jsonEncode(mapToZego) ,
      'action':'SendCustomCommand'
    };

    try {
      await Dio().post(ConstentApi.sentToZego,
          options: Options(
            headers:headers ,
          ),
          data: body
      );



      return Future.value(unit);

    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
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
      throw DioHelper.handleDioError(e);
    }

    

  }

}
