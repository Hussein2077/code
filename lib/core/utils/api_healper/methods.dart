// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:svgaplayer_flutter/svgaplayer_flutter.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/auth/presentation/component/otp/widget/otp_continers.dart';
import 'package:tik_chat_v2/features/auth/presentation/widgets/phone_wtih_country.dart';
import 'package:tik_chat_v2/features/home/data/model/svga_data_model_.dart';
import 'package:tik_chat_v2/features/profile/data/model/data_mall_model.dart';
import 'package:tik_chat_v2/features/room/data/model/emojie_model.dart';
import 'package:tik_chat_v2/features/room/data/model/gifts_model.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
import 'package:tik_chat_v2/features/room/domine/use_case/exist_room_uc.dart';
import 'package:tik_chat_v2/features/room/presentation/components/buttons/gifts/widgets/gift_view_biger.dart';
import 'package:tik_chat_v2/features/room/presentation/components/enter_room_pass/enter_password_dialog_room.dart';
import 'package:tik_chat_v2/features/room/presentation/components/view_music/music_list.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/room_handler_manager/room_handler_bloc.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/room_handler_manager/room_handler_events.dart';
import 'package:tik_chat_v2/features/room/presentation/room_screen_controler.dart';
import 'package:tik_chat_v2/main_screen/main_screen.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/src/live_audio_room.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/uikit_service.dart';

class Methods {

    Future<void> clearAuth()async{
                          SharedPreferences preference = getIt();
                              preference.remove(StringManager.userDataKey);
                              preference.remove(StringManager.userTokenKey);
                              preference.remove(StringManager.deviceToken);
   }
    Future<void> saveLocalazitaon({required String language}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("languagne", language);
  }
    Future<String> getlocalization() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String language = preferences.getString("languagne") ?? "en";
    return language;
  }
    Future<void>  setCachingMusic({required Map<String,dynamic> cachingMusic}) async{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String encodedMap = jsonEncode(cachingMusic);
      preferences.setString("cachMusic", encodedMap);
    }

    Future<Map<String,dynamic>> getCachingMusic() async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      Map<String,MusicObject> defultMap = {} ;
      String encodedMap1 = json.encode(defultMap);
      String encodedMap = preferences.getString('cachMusic')?? encodedMap1;
      Map<String,dynamic> decodedMap = json.decode(encodedMap);

      return decodedMap;
    }
  Future<void> setCachingGifts({required Map<String,dynamic> cachingGifts}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String encodedMap = json.encode(cachingGifts);
    preferences.setString("chachGifts", encodedMap);
  }

  Future<Map<String,dynamic>> getCachingGifts() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String,dynamic> defultMap = {} ;
    String encodedMap1 = json.encode(defultMap);
    String encodedMap = preferences.getString('chachGifts')?? encodedMap1;
    Map<String,dynamic> decodedMap = json.decode(encodedMap);

    return decodedMap;
  }



    Future<void> exitFromRoom(String ownerId) async{
      ZegoUIKitPrebuiltLiveAudioRoomState.connectManager?.uninit();
      await ZegoUIKitPrebuiltLiveAudioRoomState.seatManager?.uninit();
      await ZegoUIKitPrebuiltLiveAudioRoomState.plugins?.uninit();
      // await ZegoUIKit().resetSoundEffect();
      // await ZegoUIKit().resetBeautyEffect();
      await ZegoUIKit().leaveRoom();
      await ZegoUIKit().uninit();
      await ZegoUIKit().uninit();
      ZegoUIKit().logout() ;
      await  clearAll();
      ExistroomUC e = ExistroomUC(getIt());
      await e.call(ownerId);
      PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
      pusher.unsubscribe(channelName: 'presence-room-$ownerId');
    }

    Future<void> checkIfInRoom({required String ownerId }) async{
      if(MainScreen.iskeepInRoom.value){
        MainScreen.iskeepInRoom.value =false ;
        await  Methods().exitFromRoom(MainScreen.roomData?.ownerId ==null ?ownerId:
        MainScreen.roomData!.ownerId.toString());
      }

    }

    checkIfRoomHasPassword(
        {required BuildContext context,
          required bool hasPassword,
          required String ownerId ,required MyDataModel myData}) async {
      if (hasPassword) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  title: Text(StringManager.enterPassword.tr()),
                  content: EnterPasswordRoomDialog(
                    ownerId: ownerId,
                    myData: myData,
                  ));
            });
      } else {
        await Methods().checkIfInRoom(ownerId: ownerId);

        // ignore: use_build_context_synchronously
        BlocProvider.of<RoomHandlerBloc>(context)
            .add(EnterRoomEvent(ownerId: ownerId, roomPassword: '' , isVip: myData.vip1?.level??0));

        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, Routes.roomHandler, arguments: myData);
      }
    }


 Future<void> clearAuthData ()async{

          PhoneWithCountry.number=PhoneNumber();
          OtpContiners.code="";

        }

  void KeepUserLogin({required bool KeepInLogin}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(StringManager.keepLogin, KeepInLogin);
  }
  Future<void> saveMyData() async {
    Map<String, String> headers = await DioHelper().header();
    await DefaultCacheManager().getSingleFile(ConstentApi.getmyDataUrl,
        headers: headers,key: StringManager.cachUserData);
  }
  Future<MyDataModel> returnMyData() async {
    var file = await DefaultCacheManager().getFileFromCache(StringManager.cachUserData);

    if (file != null && await file.file.exists()){
      var res = await file.file.readAsString();
      MyDataModel myDataModel = MyDataModel.fromMap(jsonDecode(res)['data']);
      return myDataModel;
    }else{
      return MyDataModel();
    }
  }




  Future<void> saveUserToken({String? authToken}) async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    if(authToken!=null){
      preferences.setString(StringManager.userTokenKey, authToken);
    }else{
      preferences.setString(StringManager.userTokenKey, authToken?? "noToken");
    }


  }

  Future<String> returnUserToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String tokenPref =
        preferences.getString(StringManager.userTokenKey) ?? "noToken";
    return tokenPref;
  }


  Future<void> setPlatform({required String platForm}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(StringManager.platform, platForm);
  }

  Future<void> setDeviceToken({required String deviceToken}) async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setString(StringManager.deviceToken, deviceToken);
        }

  Future<String> getDeviceToken() async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          String? data = preferences.getString(StringManager.deviceToken);
          if(data == null){
            data =  await DioHelper().initPlatformState();
            setDeviceToken(deviceToken:data??'noToken') ;
            return data ??'noToken' ;
          } else{
            return data ;
          }
        }




  Future<String> getPlatform() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String data = preferences.getString(StringManager.platform) ?? "en";
    return data;
  }



   Future<void> cacheSvgaImage({required String svgaUrl,required  String imageId}) async {
          final cacheManager = DefaultCacheManager();

          if(kDebugMode){
            log("downloading$imageId");
          }

          await cacheManager.downloadFile(svgaUrl,key:imageId,);
          if(kDebugMode){
            log("loaded$imageId");
          }



        }

        //cache extraf
    Future<SvgaDataModel> getExtraData() async {
          String token = await Methods().returnUserToken();
          Map<String, String> headers = {
            "Authorization": "Bearer $token",
          };
          try {
            final response = await Dio().get(
              ConstentApi.getExtraData,
              options: Options(
                headers: headers,
              ),
            );
            Map<String, dynamic> jsonData = response.data;

            SvgaDataModel svgaDataModel = SvgaDataModel.fromJason(jsonData['data']) ;
            log(svgaDataModel.toString());

            return svgaDataModel;
          } on DioError catch (e) {
            throw DioHelper.handleDioError(e);
          }

        }
        Future<void> getAndLoadExtraData() async {
          SvgaDataModel svgaDataModel = await getExtraData();
          // removeCacheSvgaExtra(svgaDataModel: svgaDataModel) ;
          await  cacheSvgaExtraData(svgaDataModel: svgaDataModel);
        }
        Future<void> cacheSvgaExtraData({required  SvgaDataModel svgaDataModel}) async {
          for(int i=0;i< svgaDataModel.vipImage .length;i++){
            await cacheSvgaImage(svgaUrl:ConstentApi().getImage(svgaDataModel.vipImage[i].img),
                imageId:'${svgaDataModel.vipImage[i].id}${StringManager.cachExtraLevelKey}');
            if(svgaDataModel.vipImage[i].entro != null){
              await cacheSvgaImage(svgaUrl:ConstentApi().getImage(svgaDataModel.vipImage[i].entro),
                  imageId:'${svgaDataModel.vipImage[i].entroId}${StringManager.cacheEntroKey}');
            }
            if(svgaDataModel.vipImage[i].frame!= null) {
              await cacheSvgaImage(
                  svgaUrl: ConstentApi().getImage(svgaDataModel.vipImage[i].frame),
                  imageId: '${svgaDataModel.vipImage[i].frameId}${StringManager.cacheFrameKey}');
            }
          }

          for(int i=0;i< svgaDataModel.pkIamges.length;i++){
            await cacheSvgaImage(svgaUrl:ConstentApi().getImage(svgaDataModel.pkIamges[i].url),
                imageId:'${svgaDataModel.pkIamges[i].id}${StringManager.cachExtraKey}');

          }

          setLastTimeCache(TypesCache.extra);


        }


        //cache entro
        Future<List<DataMallModel>> getUsersEntro() async {
          log("getUsersEntro");
          String token = await Methods().returnUserToken();
          Map<String, String> headers = {
            "Authorization": "Bearer $token",
          };
          try {
            final response = await Dio().get(
              ConstentApi().getDataMallUrl(6),
              options: Options(
                headers: headers,
              ),
            );
            Map<String, dynamic> jsonData = response.data;
            bool succes = jsonData[ConstentApi.succes];
            List<DataMallModel> listDataMall = [];
            if (succes) {
              for (int i = 0; i < jsonData[ConstentApi.data].length; i++) {
                DataMallModel dataModel =
                DataMallModel.fromJson(jsonData[ConstentApi.data][i]);
                listDataMall.add(dataModel);
              }
            }

            return listDataMall;
          } on DioError catch (e) {
            throw DioHelper.handleDioError(e);
          }
        }
        Future<void> getAndLoadEntro() async {

          List<DataMallModel> entroModel = await getUsersEntro();
          // removeCacheSvgaEntro(dataMallModel:entroModel );
          await  cacheSvgaEntro(dataMallModel: entroModel);
        }
        Future<void> cacheSvgaEntro({required  List<DataMallModel> dataMallModel})
        async {
          log('cacheSvgaEntro') ;
          for(int i=0;i< dataMallModel.length;i++){

            await cacheSvgaImage(svgaUrl:ConstentApi().getImage(dataMallModel[i].svg),
                imageId:'${dataMallModel[i].id.toString()}${StringManager.cacheEntroKey}');

          }
          setLastTimeCache(TypesCache.intro);

        }


        //cache Frame
        Future<List<DataMallModel>> getFrames() async {
          String token = await Methods().returnUserToken();
          Map<String, String> headers = {
            "Authorization": "Bearer $token",
          };
          try {
            final response = await Dio().get(
              ConstentApi().getDataMallUrl(4),
              options: Options(
                headers: headers,
              ),
            );
            Map<String, dynamic> jsonData = response.data;
            bool succes = jsonData[ConstentApi.succes];
            List<DataMallModel> listDataMall = [];
            if (succes) {
              for (int i = 0; i < jsonData[ConstentApi.data].length; i++) {
                DataMallModel dataModel =
                DataMallModel.fromJson(jsonData[ConstentApi.data][i]);
                listDataMall.add(dataModel);
              }
            }

            return listDataMall;
          } on DioError catch (e) {
            throw DioHelper.handleDioError(e);
          }
        }
        Future<void> getAndLoadFrames() async {
          log("getAndLoadFrames") ;
          List<DataMallModel> emojieModel = await getFrames();
          //  removeCacheSvgaFrames(dataMallModel: emojieModel);
          await  cacheSvgaFrame(dataMallModel: emojieModel);
        }
        Future<void> cacheSvgaFrame(
            {required  List<DataMallModel> dataMallModel}) async {
          for(int i=0;i< dataMallModel.length;i++){

            await cacheSvgaImage(svgaUrl:ConstentApi().getImage(dataMallModel[i].svg),
                imageId:'${dataMallModel[i].id.toString()}${StringManager.cacheFrameKey}');

          }
          setLastTimeCache(TypesCache.frame);

        }


        // cache Emojie
        Future<void> getAndLoadEmojie() async {
          List<EmojieModel> emojieModel = await getEmojie();
          // removeCacheSvgaEmojie(emojieModel: emojieModel);
          await  cacheSvgaEmojie(emojieModel: emojieModel);
        }
        Future<List<EmojieModel>> getEmojie() async {

          String token = await Methods().returnUserToken();

          try{
            final response = await Dio().get(ConstentApi.getEmojie,
                options: Options(
                  headers: {"authorization": "Bearer $token"},
                ));
            return List<EmojieModel>.from(
                (response.data["data"] as List).map((e) => EmojieModel.fromjson(e)));
          } on DioError catch(e){
            throw DioHelper.handleDioError(e);
          }
        }
        Future<void> cacheSvgaEmojie({required  List<EmojieModel> emojieModel}) async {
          log("cacheSvgaEmojie") ;
          for(int i=0;i< emojieModel.length;i++){

            await cacheSvgaImage(svgaUrl:ConstentApi().getImage(emojieModel[i].emoji),
                imageId:'${emojieModel[i].id.toString()}${StringManager.cacheEmojieKey}');

          }
          setLastTimeCache(TypesCache.emojie);

        }



        //cache gifts
        Future<void> chachGiftInRoom() async {
          List<GiftsModel>  normalGift =  await getGifts(1) ;
          List<GiftsModel>  hotGift =  await getGifts(2) ;
          List<GiftsModel>  ciuntryGift =  await getGifts(3) ;


          await  initDownloadPath(normalGift);
          await   initDownloadPath(hotGift);
          await  initDownloadPath(ciuntryGift);
        }

        Future<List<GiftsModel>> getGifts(int  type) async{
          log('getGifts');
          final headers = await DioHelper().header() ;
          final response = await Dio().get(ConstentApi().getGifts(type),
              options: Options(
                headers: headers,
              ));
          Map<String, dynamic> jsonData = response.data;
          List<GiftsModel> GiftsModelList = [];
          for (int i = 0; i < jsonData['data'].length; i++) {
            GiftsModelList.add(GiftsModel.fromJson(jsonData['data'][i]));
          }
          return GiftsModelList;
        }

        Future<void> initDownloadPath(List<GiftsModel> data) async {
          log('initDownloadPath');
          Directory appDocDir = await getApplicationDocumentsDirectory();
          String rootPath = appDocDir.path ;

          for(int i=0;i<data.length;i++){
            if(!data[i].showImg.contains('mp4')){
              //cache svga image
              cacheSvgaImage(svgaUrl: ConstentApi().getImage(data[i].showImg),imageId:data[i].id.toString());
              continue ;
            }

            String path = "$rootPath/${data[i].id}.mp4";
            _download(path: path, img: data[i].showImg, giftId: data[i].id);



          }

        }

        _download({required String img, required  int giftId  ,required String path}) async {
          Map<String,dynamic> chachedMp4Gifts = await Methods().getCachingGifts() ;


          PageViewGeftWidget.chachedGiftMp4 =chachedMp4Gifts;



          if(!chachedMp4Gifts.containsKey(giftId.toString())){
            if(kDebugMode){
            log('downloading$giftId');
            }
            await  Dio().download(ConstentApi().getImage(img), path);
            if(kDebugMode){
            log('loaded$giftId');
            }
            PageViewGeftWidget.chachedGiftMp4.putIfAbsent(giftId.toString(), () => path) ;
            chachedMp4Gifts.putIfAbsent(giftId.toString(), () => path) ;
            if(kDebugMode) {
              log(PageViewGeftWidget.chachedGiftMp4.toString());
            }
          }


          await setCachingGifts(cachingGifts:PageViewGeftWidget.chachedGiftMp4) ;
          setLastTimeCache(TypesCache.gift);
        }

        Future<MovieEntity> getCachedSvgaImage( String giftId, String url) async {

          final cacheManager = DefaultCacheManager();
          final file = await cacheManager.getFileFromCache(giftId);
          final bytes = await file?.file.readAsBytes() ;
          if(bytes != null){
            if(kDebugMode){
              log("isAlreadyloaded");
            }
            final videoItem = await SVGAParser.shared.decodeFromBuffer(bytes.toList()) ;
            return videoItem ;
          }else{
            return await SVGAParser.shared
                .decodeFromURL(ConstentApi().getImage(url)).whenComplete(()async {
              await Methods().cacheSvgaImage(
                svgaUrl: ConstentApi().getImage(url),
                imageId: giftId,
              );
            });
          }

        }

        //set && get time of cach
        Future<void> setLastTimeCache(TypesCache typesCache )async{
          if(kDebugMode){
            log("typesCache$typesCache");
          }
          final timestamp =
              DateTime.now().toUtc().millisecondsSinceEpoch;
          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          switch(typesCache) {
            case TypesCache.gift:
              sharedPreferences.setInt(StringManager.lastTimeCacheGift, timestamp);
              break;
            case TypesCache.frame:
              sharedPreferences.setInt(StringManager.lastTimeCacheFrame, timestamp);
              break;
            case TypesCache.intro:
              sharedPreferences.setInt(StringManager.lastTimeCacheEntro, timestamp);
              break;
            case TypesCache.extra:
              sharedPreferences.setInt(StringManager.lastTimeCacheExtra, timestamp);
              break;
            case TypesCache.emojie:
              sharedPreferences.setInt(StringManager.lastTimeCacheEmojie, timestamp);
              break;
          }

        }
        Future<int?> getsLastTimeCache(TypesCache typesCache)async{
          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          switch(typesCache) {
            case TypesCache.gift:
              return   sharedPreferences.getInt(StringManager.lastTimeCacheGift);
            case TypesCache.frame:
              return   sharedPreferences.getInt(StringManager.lastTimeCacheFrame);
            case TypesCache.intro:
              return   sharedPreferences.getInt(StringManager.lastTimeCacheEntro);
            case TypesCache.extra:
              return   sharedPreferences.getInt(StringManager.lastTimeCacheExtra);
            case TypesCache.emojie:
              return   sharedPreferences.getInt(StringManager.lastTimeCacheEmojie);
          }

        }


        // remove chach
        Future<void> removeCacheSvgaEntro({required List<DataMallModel> dataMallModel })async{
          for(int i=0;i< dataMallModel.length;i++){

            await  removeFileFromChach(key:'${dataMallModel[i].id.toString()}${StringManager.cacheEntroKey}');


          }
        }
        Future<void> removeCacheSvgaEmojie({required List<EmojieModel> emojieModel })async{
          for(int i=0;i< emojieModel.length;i++){
            await  removeFileFromChach(key:'${emojieModel[i].id.toString()}${StringManager.cacheEmojieKey}');
          }
        }
        Future<void> removeCacheSvgaExtra({required  SvgaDataModel svgaDataModel })async{
          for(int i=0;i< svgaDataModel.vipImage .length;i++){
            await  removeFileFromChach(key:'${svgaDataModel.vipImage[i].id}${StringManager.cachExtraLevelKey}');
            if(svgaDataModel.vipImage[i].entro != null){
              await  removeFileFromChach(key:'${svgaDataModel.vipImage[i].entroId}${StringManager.cacheEntroKey}');
            }
            if(svgaDataModel.vipImage[i].frame!= null) {
              await  removeFileFromChach(key:'${svgaDataModel.vipImage[i].frameId}${StringManager.cacheFrameKey}');
            }
          }

          for(int i=0;i< svgaDataModel.pkIamges.length;i++){
            await  removeFileFromChach(key:'${svgaDataModel.pkIamges[i].id}${StringManager.cachExtraKey}');
          }


        }
        Future<void> removeCacheSvgaFrames({required List<DataMallModel> dataMallModel })async{
          for(int i=0;i< dataMallModel.length;i++){
            await  removeFileFromChach(key:'${dataMallModel[i].id.toString()}${StringManager.cacheFrameKey}');
          }
        }
        Future<void> clearCachData(BuildContext context )async {

          SharedPreferences sharedPreferences = await SharedPreferences.getInstance() ;
          await sharedPreferences.remove(StringManager.chachGifts);
          await sharedPreferences.remove(StringManager.lastTimeCacheGift);
          await sharedPreferences.remove(StringManager.lastTimeCacheEntro);
          await sharedPreferences.remove(StringManager.lastTimeCacheExtra);
          await sharedPreferences.remove(StringManager.lastTimeCacheFrame);
          await sharedPreferences.remove(StringManager.lastTimeCacheEmojie);


          final cacheManager = DefaultCacheManager();
          cacheManager.emptyCache() ;
          // ignore: use_build_context_synchronously
          sucssesToast(context: context, title: StringManager.clearDataDone.tr());
        }

        Future<void> removeFileFromChach({required String key})async{
          final cacheManager = DefaultCacheManager();
          if(await cacheManager.getFileFromCache(key) != null){
            cacheManager.removeFile(key);
          }
        }
}