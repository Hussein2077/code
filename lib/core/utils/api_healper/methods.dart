// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:svgaplayer_flutter/svgaplayer_flutter.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/core/model/video_cache_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/service/cach_manager.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/auth/presentation/component/otp/widget/otp_continers.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/fire_base_login_manager/firebase_login_bloc.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/fire_base_login_manager/firebase_login_event.dart';
import 'package:tik_chat_v2/features/auth/presentation/widgets/phone_wtih_country.dart';
import 'package:tik_chat_v2/features/following/persentation/manager/followers_room_manager/get_follwers_room_bloc.dart';
import 'package:tik_chat_v2/features/following/persentation/manager/followers_room_manager/get_follwers_room_event.dart';
import 'package:tik_chat_v2/features/home/data/model/svga_data_model_.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/get_room_manager/get_room_bloc.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/get_room_manager/get_room_events.dart';
import 'package:tik_chat_v2/features/home/presentation/widget/body/aduio/audio_body.dart';
import 'package:tik_chat_v2/features/home/presentation/widget/country_dilog.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_following_moment/get_following_user_moment_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_following_moment/get_following_user_moment_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_user_moment/get_moment_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_user_moment/get_moment_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_moment_i_like_it/get_moment_i_like_it_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_moment_i_like_it/get_moment_i_like_it_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_moment_trending/get_moment_all_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_moment_trending/get_moment_all_event.dart';
import 'package:tik_chat_v2/features/profile/data/model/data_mall_model.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manager_join_family/bloc/join_family_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manager_join_family/bloc/join_family_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_event.dart';
import 'package:tik_chat_v2/features/reels/data/models/reel_model.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_get_following_reels/get_following_reels_bloc.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_get_following_reels/get_following_reels_event.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_get_reels/get_reels_bloc.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_get_reels/get_reels_event.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/emojie_model.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/gifts_model.dart';

// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/exist_room_uc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/buttons/gifts/widgets/gift_view_biger.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/enter_room_pass/enter_password_dialog_room.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/view_music/music_list.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/room_screen_controler.dart';
import 'package:tik_chat_v2/main_screen/main_screen.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/src/live_audio_room.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/uikit_service.dart';

class Methods {

  Methods._intarnel();

    static final   instance =   Methods._intarnel() ;

  factory  Methods() => instance ;


  Future<void> clearAuth() async {
    SharedPreferences preference = getIt();
    preference.remove(StringManager.userDataKey);
    preference.remove(StringManager.userTokenKey);
    preference.remove(StringManager.deviceToken);
  }

  Future<void> saveLocalazitaon({required String language}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("languagne", language);
  }

  Future<String> getLocalization() async {
    final String defaultLocale = Platform.localeName;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String language = preferences.getString("languagne") ??defaultLocale.substring(0,2);
    return language;
  }


  Future<void> setCachingMusic(
      {required Map<String, dynamic> cachingMusic}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String encodedMap = jsonEncode(cachingMusic);
    preferences.setString("cachMusic", encodedMap);
  }

  Future<Map<String, dynamic>> getCachingMusic() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, MusicObject> defultMap = {};
    String encodedMap1 = json.encode(defultMap);
    String encodedMap = preferences.getString('cachMusic') ?? encodedMap1;
    Map<String, dynamic> decodedMap = json.decode(encodedMap);

    return decodedMap;
  }

  Future<void> setCachingVideo(
      {required Map<String, dynamic> cachingVideos,
      required String key}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String encodedMap = json.encode(cachingVideos);
    preferences.setString(key, encodedMap);
  }

  Future<Map<String, dynamic>> getCachingVideo({required String key}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, dynamic> defultMap = {};
    String encodedMap1 = json.encode(defultMap);
    String encodedMap = preferences.getString(key) ?? encodedMap1;
    Map<String, dynamic> decodedMap = json.decode(encodedMap);

    return decodedMap;
  }


  Future<void> cachingReels(List<ReelModel> reels , Map<String,dynamic> mapReels ) async{
    await getIt<VideoCacheManager>().init() ;
      for(int i =0;i<reels.length;i++){
        if(kDebugMode){
        }
        VideoCacheModel video = VideoCacheModel(
            img: reels[i].img == null? "" : reels[i].img!,
            url: reels[i].url!
        );

      getIt<VideoCacheManager>().cacheVideo(video, StringManager.cachReelsKey);
    }
  }

  Future<Map<String, dynamic>> getCachingReels() async {
    await getIt<VideoCacheManager>().init();

    Map<String, dynamic> mapReels = getIt<VideoCacheManager>().cacheMap;

    return mapReels;
  }

  Future<void> removeCachReels() async {
    await getIt<VideoCacheManager>().init();
    getIt<VideoCacheManager>()
        .removeVideosByCacheKey(StringManager.cachReelsKey);
  }

  Future<void> exitFromRoom(String ownerId) async {
    ZegoUIKitPrebuiltLiveAudioRoomState.connectManager?.uninit();
    await ZegoUIKitPrebuiltLiveAudioRoomState.seatManager?.uninit();
    await ZegoUIKitPrebuiltLiveAudioRoomState.plugins?.uninit();
    // await ZegoUIKit().resetSoundEffect();
    // await ZegoUIKit().resetBeautyEffect();
    await ZegoUIKit.instance.leaveRoom();
    await ZegoUIKit.instance.uninit();
    await ZegoUIKit.instance.uninit();
    ZegoUIKit.instance.logout();
    await clearAll();
    ExistroomUC e = ExistroomUC(roomRepo: getIt());
    await e.call(ownerId);
    PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
    pusher.unsubscribe(channelName: 'presence-room-$ownerId');
  }

  Future<void> checkIfInRoom({required String ownerId}) async {
    if (MainScreen.iskeepInRoom.value) {
      MainScreen.iskeepInRoom.value = false;
      await Methods.instance.exitFromRoom(MainScreen.roomData?.ownerId == null
          ? ownerId
          : MainScreen.roomData!.ownerId.toString());
    }
  }

  checkIfRoomHasPassword(
      {required BuildContext context,
      required bool hasPassword,
      bool? isInRoom,
      required String ownerId,
      required MyDataModel myData}) async {
    if (hasPassword) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                backgroundColor: Colors.transparent,
                insetPadding: EdgeInsets.symmetric(
                    horizontal: ConfigSize.defaultSize! * 0.8),
                title: Text(StringManager.enterPassword.tr()),
                content: EnterPasswordRoomDialog(
                  ownerId: ownerId,
                  myData: myData,
                  isInRoom: isInRoom,
                ));
          });
    } else {
      // ignore: use_build_context_synchronously

      Navigator.pop(context);
      // MainScreen.iskeepInRoom.value=true ;
      Navigator.pushNamed(context, Routes.roomHandler,
          arguments: RoomHandlerPramiter(
              ownerRoomId: ownerId, myDataModel: MyDataModel.getInstance()));
    }
  }

  Future<void> clearAuthData() async {
    PhoneWithCountry.number = PhoneNumber();
    OtpContiners.code = "";
  }

  void KeepUserLogin({required bool KeepInLogin}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(StringManager.keepLogin, KeepInLogin);
  }

  Future<void> saveMyData() async {
    Map<String, String> headers = await DioHelper().header();
    await getIt<DefaultCacheManager>().getSingleFile(ConstentApi.getmyDataUrl,
        headers: headers, key: StringManager.cachUserData);
  }

  Future<MyDataModel> returnMyData() async {
    var file = await getIt<DefaultCacheManager>()
        .getFileFromCache(StringManager.cachUserData);

    if (file != null && await file.file.exists()) {
      var res = await file.file.readAsString();
      MyDataModel myDataModel = MyDataModel.fromMap(jsonDecode(res)['data']);
      return myDataModel;
    } else {
      return MyDataModel();
    }
  }

  Future<void> saveUserToken({String? authToken}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (authToken != null) {
      preferences.setString(StringManager.userTokenKey, authToken);
    } else {
      preferences.setString(StringManager.userTokenKey, authToken ?? "noToken");
    }
  }

  void removeUserData (){
    DefaultCacheManager().removeFile(StringManager.cachUserData);

  }

  Future<void> saveThemeStatus({required String theme}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setString(StringManager.theme, theme);
  }

  Future<String> returnThemeStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String theme = preferences.getString(StringManager.theme) ?? "noTheme";
    return theme;
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
    if (data == null) {
      data = await DioHelper().initPlatformState();
      setDeviceToken(deviceToken: data ?? 'noToken');
      return data ?? 'noToken';
    } else {
      return data;
    }
  }

  Future<String> getPlatform() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String data = preferences.getString(StringManager.platform) ?? "en";
    return data;
  }

  Future<void> cacheSvgaImage(
      {required String svgaUrl, required String imageId}) async {
    final cacheManager = getIt<DefaultCacheManager>();

    if (kDebugMode) {
      log("downloading$imageId");
    }

    try {
      await cacheManager.downloadFile(
        svgaUrl,
        key: imageId,
      );
    } on HttpException catch (e) {
      if (kDebugMode) {
        log("there is error in cache this url $svgaUrl ");
      }
    }
    if (kDebugMode) {
      log("loaded$imageId");
    }
  }

  //cache extraf
  Future<SvgaDataModel> getExtraData() async {
    String token = await Methods.instance.returnUserToken();
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

      SvgaDataModel svgaDataModel = SvgaDataModel.fromJason(jsonData['data']);
      log(svgaDataModel.toString());

      return svgaDataModel;
    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e, endpointName: "getExtraData");
    }
  }

  Future<void> getAndLoadExtraData() async {
    SvgaDataModel svgaDataModel = await getExtraData();
    // removeCacheSvgaExtra(svgaDataModel: svgaDataModel) ;
    await cacheSvgaExtraData(svgaDataModel: svgaDataModel);
  }

  Future<void> cacheSvgaExtraData(
      {required SvgaDataModel svgaDataModel}) async {
    for (int i = 0; i < svgaDataModel.vipImage.length; i++) {
      await cacheSvgaImage(
          svgaUrl: ConstentApi().getImage(svgaDataModel.vipImage[i].img),
          imageId:
              '${svgaDataModel.vipImage[i].id}${StringManager.cachExtraLevelKey}');
      if (svgaDataModel.vipImage[i].entro != null) {
        await cacheSvgaImage(
            svgaUrl: ConstentApi().getImage(svgaDataModel.vipImage[i].entro),
            imageId:
                '${svgaDataModel.vipImage[i].entroId}${StringManager.cacheEntroKey}');
      }
      if (svgaDataModel.vipImage[i].frame != null) {
        await cacheSvgaImage(
            svgaUrl: ConstentApi().getImage(svgaDataModel.vipImage[i].frame),
            imageId:
                '${svgaDataModel.vipImage[i].frameId}${StringManager.cacheFrameKey}');
      }
    }

    for (int i = 0; i < svgaDataModel.pkIamges.length; i++) {
      await cacheSvgaImage(
          svgaUrl: ConstentApi().getImage(svgaDataModel.pkIamges[i].url),
          imageId:
              '${svgaDataModel.pkIamges[i].id}${StringManager.cachExtraKey}');
    }

    setLastTimeCache(TypesCache.extra);
  }

  //cache entro
  Future<List<DataMallModel>> getUsersEntro() async {
    log("getUsersEntro");
    String token = await Methods.instance.returnUserToken();
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
      throw DioHelper.handleDioError(
          dioError: e, endpointName: "getUsersEntro");
    }
  }

  Future<void> getAndLoadEntro() async {
    List<DataMallModel> entroModel = await getUsersEntro();
    // removeCacheSvgaEntro(dataMallModel:entroModel );
    await cacheSvgaEntro(dataMallModel: entroModel);
  }

  Future<void> cacheSvgaEntro(
      {required List<DataMallModel> dataMallModel}) async {
    log('cacheSvgaEntro');
    for (int i = 0; i < dataMallModel.length; i++) {
      await cacheSvgaImage(
          svgaUrl: ConstentApi().getImage(dataMallModel[i].svg),
          imageId:
              '${dataMallModel[i].id.toString()}${StringManager.cacheEntroKey}');
    }
    setLastTimeCache(TypesCache.intro);
  }

  //cache Frame
  Future<List<DataMallModel>> getFrames() async {
    String token = await Methods.instance.returnUserToken();
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
      throw DioHelper.handleDioError(dioError: e, endpointName: "getFrames");
    }
  }

  Future<void> getAndLoadFrames() async {
    List<DataMallModel> emojieModel = await getFrames();
    //  removeCacheSvgaFrames(dataMallModel: emojieModel);
    await cacheSvgaFrame(dataMallModel: emojieModel);
  }

  Future<void> cacheSvgaFrame(
      {required List<DataMallModel> dataMallModel}) async {
    for (int i = 0; i < dataMallModel.length; i++) {
      await cacheSvgaImage(
          svgaUrl: ConstentApi().getImage(dataMallModel[i].svg),
          imageId:
              '${dataMallModel[i].id.toString()}${StringManager.cacheFrameKey}');
    }
    setLastTimeCache(TypesCache.frame);
  }

  // cache Emojie
  Future<void> getAndLoadEmojie() async {
    List<EmojieModel> emojieModel = await getEmojie();
    // removeCacheSvgaEmojie(emojieModel: emojieModel);
    await cacheSvgaEmojie(emojieModel: emojieModel);
  }

  Future<List<EmojieModel>> getEmojie() async {
    String token = await Methods.instance.returnUserToken();

    try {
      final response = await Dio().get(ConstentApi.getEmojie,
          options: Options(
            headers: {"authorization": "Bearer $token"},
          ));
      return List<EmojieModel>.from(
          (response.data["data"] as List).map((e) => EmojieModel.fromjson(e)));
    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e, endpointName: "getEmojie");
    }
  }

  Future<void> cacheSvgaEmojie({required List<EmojieModel> emojieModel}) async {
    for (int i = 0; i < emojieModel.length; i++) {
      await cacheSvgaImage(
          svgaUrl: ConstentApi().getImage(emojieModel[i].emoji),
          imageId:
              '${emojieModel[i].id.toString()}${StringManager.cacheEmojieKey}');
    }
    setLastTimeCache(TypesCache.emojie);
  }

  //cache gifts
  Future<void> chachGiftInRoom() async {
    List<GiftsModel> normalGift = await getGifts(1);
    List<GiftsModel> hotGift = await getGifts(2);
    List<GiftsModel> ciuntryGift = await getGifts(3);
    List<GiftsModel> luckyGift = await getGifts(6);

    await initDownloadPath(normalGift);
    await initDownloadPath(hotGift);
    await initDownloadPath(ciuntryGift);
    await initDownloadPath(luckyGift);
    setLastTimeCache(TypesCache.gift);
  }

  Future<List<GiftsModel>> getGifts(int type) async {
    log('getGifts');
    final headers = await DioHelper().header();
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
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String rootPath = appDocDir.path;

    for (int i = 0; i < data.length; i++) {
      if (!data[i].showImg.contains('mp4')) {
        //cache svga image
        cacheSvgaImage(
            svgaUrl: ConstentApi().getImage(data[i].showImg),
            imageId: data[i].id.toString());
        continue;
      }

      String path = "$rootPath/${data[i].id}.mp4";
      await _download(path: path, img: data[i].showImg, giftId: data[i].id);
    }
  }

  _download(
      {required String img, required int giftId, required String path}) async {
    Map<String, dynamic> chachedMp4Gifts =
        await Methods.instance.getCachingVideo(key: StringManager.cachGiftKey);

    PageViewGeftWidget.chachedGiftMp4 = chachedMp4Gifts;

    if (!chachedMp4Gifts.containsKey(giftId.toString())) {
      if (kDebugMode) {
        log('downloading$giftId');
      }
      try {
        await Dio().download(ConstentApi().getImage(img), path);
      } on HttpException catch (e) {
        if (kDebugMode) {
          log("there is error in cache this url ${ConstentApi().getImage(img)} ");
        }
      }

      if (kDebugMode) {
        log('loaded$giftId');
      }
      PageViewGeftWidget.chachedGiftMp4
          .putIfAbsent(giftId.toString(), () => path);
      chachedMp4Gifts.putIfAbsent(giftId.toString(), () => path);
      if (kDebugMode) {
        log(PageViewGeftWidget.chachedGiftMp4.toString());
      }
    }

    await setCachingVideo(
        cachingVideos: PageViewGeftWidget.chachedGiftMp4,
        key: StringManager.cachGiftKey);
  }

  Future<void> cacheMp4(
      {required int vedioId, required String vedioUrl}) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String rootPath = appDocDir.path;
    String path = "$rootPath/$vedioId.mp4";

    await _download(img: vedioUrl, giftId: vedioId, path: path);
  }

  Future<MovieEntity> getCachedSvgaImage(String giftId, String url) async {
    final cacheManager = getIt<DefaultCacheManager>();
    final file = await cacheManager.getFileFromCache(giftId);
    final bytes = await file?.file.readAsBytes();
    if (bytes != null) {
      if (kDebugMode) {
        log("isAlreadyloaded");
      }
      final videoItem =
          await SVGAParser.shared.decodeFromBuffer(bytes.toList());
      return videoItem;
    } else {
      return await SVGAParser.shared
          .decodeFromURL(ConstentApi().getImage(url))
          .whenComplete(() async {
        await Methods.instance.cacheSvgaImage(
          svgaUrl: ConstentApi().getImage(url),
          imageId: giftId,
        );
      });
    }
  }

  //set && get time of cach
  Future<void> setLastTimeCache(TypesCache typesCache) async {
    if (kDebugMode) {
      log("typesCache$typesCache");
    }
    final timestamp = DateTime.now().toUtc().millisecondsSinceEpoch;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    switch (typesCache) {
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

  Future<int?> getsLastTimeCache(TypesCache typesCache) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    switch (typesCache) {
      case TypesCache.gift:
        return sharedPreferences.getInt(StringManager.lastTimeCacheGift);
      case TypesCache.frame:
        return sharedPreferences.getInt(StringManager.lastTimeCacheFrame);
      case TypesCache.intro:
        return sharedPreferences.getInt(StringManager.lastTimeCacheEntro);
      case TypesCache.extra:
        return sharedPreferences.getInt(StringManager.lastTimeCacheExtra);
      case TypesCache.emojie:
        return sharedPreferences.getInt(StringManager.lastTimeCacheEmojie);
    }
  }

  // remove chach
  Future<void> removeCacheSvgaEntro(
      {required List<DataMallModel> dataMallModel}) async {
    for (int i = 0; i < dataMallModel.length; i++) {
      await removeFileFromChach(
          key:
              '${dataMallModel[i].id.toString()}${StringManager.cacheEntroKey}');
    }
  }

  Future<void> removeCacheSvgaEmojie(
      {required List<EmojieModel> emojieModel}) async {
    for (int i = 0; i < emojieModel.length; i++) {
      await removeFileFromChach(
          key:
              '${emojieModel[i].id.toString()}${StringManager.cacheEmojieKey}');
    }
  }

  Future<void> removeCacheSvgaExtra(
      {required SvgaDataModel svgaDataModel}) async {
    for (int i = 0; i < svgaDataModel.vipImage.length; i++) {
      await removeFileFromChach(
          key:
              '${svgaDataModel.vipImage[i].id}${StringManager.cachExtraLevelKey}');
      if (svgaDataModel.vipImage[i].entro != null) {
        await removeFileFromChach(
            key:
                '${svgaDataModel.vipImage[i].entroId}${StringManager.cacheEntroKey}');
      }
      if (svgaDataModel.vipImage[i].frame != null) {
        await removeFileFromChach(
            key:
                '${svgaDataModel.vipImage[i].frameId}${StringManager.cacheFrameKey}');
      }
    }

    for (int i = 0; i < svgaDataModel.pkIamges.length; i++) {
      await removeFileFromChach(
          key: '${svgaDataModel.pkIamges[i].id}${StringManager.cachExtraKey}');
    }
  }

  Future<void> removeCacheSvgaFrames(
      {required List<DataMallModel> dataMallModel}) async {
    for (int i = 0; i < dataMallModel.length; i++) {
      await removeFileFromChach(
          key:
              '${dataMallModel[i].id.toString()}${StringManager.cacheFrameKey}');
    }
  }

  Future<void> clearCachData(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(StringManager.chachGifts);
    await sharedPreferences.remove(StringManager.lastTimeCacheGift);
    await sharedPreferences.remove(StringManager.lastTimeCacheEntro);
    await sharedPreferences.remove(StringManager.lastTimeCacheExtra);
    await sharedPreferences.remove(StringManager.lastTimeCacheFrame);
    await sharedPreferences.remove(StringManager.lastTimeCacheEmojie);

    final cacheManager = getIt<DefaultCacheManager>();
    cacheManager.emptyCache();
    // ignore: use_build_context_synchronously
    sucssesToast(context: context, title: StringManager.clearDataDone.tr());
  }

  Future<void> removeFileFromChach({required String key}) async {
    final cacheManager = getIt<DefaultCacheManager>();
    if (await cacheManager.getFileFromCache(key) != null) {
      cacheManager.removeFile(key);
    }
  }

  void userProfileNvgator({
    required BuildContext context,
    String? userId,
    UserDataModel? userData,
  }) {
    if (userId == null && userData == null) {
      Navigator.pushNamed(context, Routes.userProfile);
    } else if (userId != null) {
      if (userId != MyDataModel.getInstance().id.toString()) {
        Navigator.pushNamed(context, Routes.userProfile,
            arguments: UserProfilePreamiter(null, userId));
      } else {
        Navigator.pushNamed(
          context,
          Routes.userProfile,
        );
      }
    } else if (userData != null) {
      if (userData.id.toString() != MyDataModel.getInstance().id.toString()) {
        Navigator.pushNamed(context, Routes.userProfile,
            arguments: UserProfilePreamiter(null, userData.id.toString()));
      } else {
        Navigator.pushNamed(
          context,
          Routes.userProfile,
        );
      }
    }
  }

  Future addFireBaseNotifcationId() async {
    String token = await Methods.instance.returnUserToken();
    String? tokenn = FirebaseAuth.instance.currentUser?.uid.toString();

    await Dio().post(
      ConstentApi.editeUrl,
      data: {
        "chat_id": tokenn,
        "notification_id": await FirebaseMessaging.instance.getToken()
      },
      options: Options(
        headers: {
          // 'X-localization': lang,
          // 'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      ),
    );
  }
  Future<String> getCurrentTimeZone() async {
    DateTime dateTimeNow = DateTime.now();
    print('GMT${  dateTimeNow.timeZoneName}');
    return dateTimeNow.timeZoneName;
  }
  String formatDateTime({
    required String dateTime,
    String format = 'E, d MMM yyyy hh:mm a',
    String locale = 'ar',
  }) {
    if(dateTime==''){
      return '';
    }
    DateTime dateTimeNow = DateTime.now();
    DateFormat formatter = DateFormat(format, locale);
    if (formatter.format(dateTimeNow).substring(5, 12) ==
        formatter.format(DateTime.parse(dateTime)).substring(5, 12)) {
      formatter = DateFormat('hh:mm a', locale);
      return '${StringManager.today.tr()} ${formatter.format(DateTime.parse(dateTime))}';
    } else {
      return formatter.format(DateTime.parse(dateTime));
    }
  }

    Future<bool> getNotificationState() async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      bool notificationState = preferences.getBool("notificationState") ?? true;
      return notificationState;
    }
    Future<void> setNotificationState({required bool notificationState}) async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setBool("notificationState", notificationState);
    }

    getDependencies(BuildContext context){
        log('getTheNewData${MyDataModel.getInstance().id.toString()}');
        BlocProvider.of<GetMyDataBloc>(context).add(GetMyDataEvent());
        BlocProvider.of<GetFollowingUserMomentBloc>(context).add(const GetFollowingMomentEvent());
        BlocProvider.of<GetMomentILikeItBloc>(context).add(const GetMomentIliKEitEvent());
        BlocProvider.of<GetMomentBloc>(context).add(GetUserMomentEvent(userId: MyDataModel.getInstance().id.toString(),));
        BlocProvider.of<GetReelsBloc>(context).add(GetReelsEvent());
        BlocProvider.of<GetFollowingReelsBloc>(context).add(GetFollowingReelsEvent());
        BlocProvider.of<GetFollwersRoomBloc>(context).add(const GetFollwersRoomEvent(type: "5"));
        BlocProvider.of<GetRoomsBloc>(context).add(GetRoomsEvent(typeGetRooms: TypeGetRooms.popular));
        BlocProvider.of<GetMomentallBloc>(context).add(const GetMomentAllEvent());
        BlocProvider.of<JoinFamilyBloc>(context)
            .add(InitJoinFamilyEvent() );
        BlocProvider.of<FirebaseLoginBloc>(context).add(const FireBaseLoginEvent());
        AduioBody.type = StringManager.popular;
        AduioBody.countryId = null;
        CountryDialog.flag = AssetsPath.fireIcon;
        CountryDialog.name = StringManager.popular.tr();
        CountryDialog.selectedCountry.value =
        !CountryDialog.selectedCountry.value;
      }


}
