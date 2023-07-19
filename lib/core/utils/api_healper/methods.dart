import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Methods {

    Future<void> saveLocalazitaon({required String language}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("languagne", language);
  }
    Future<String> getlocalization() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String language = preferences.getString("languagne") ?? "en";
    return language;
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


 


  


  // void KeepUserLogin({required bool KeepInLogin}) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.setBool(StringManager.keepLogin, KeepInLogin);
  // }


  // void saveUserData({required Map<String, dynamic> jsonString}) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   // String user = jsonEncode(UserModel.fromJson(jsonString));
  //   preferences.setString(StringManager.userDataKey, jsonEncode(jsonString));
  // }

  // Future<OwnerDataModel> returnUserData() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   String userPref = preferences.getString(StringManager.userDataKey)!;

  //   Map<String, dynamic> userMap = jsonDecode(userPref) as Map<String, dynamic>;
  //   OwnerDataModel userModel = OwnerDataModel.fromMap(userMap['data']);
  //   return userModel;
  // }

  // Future<void> saveUserToken({String? authToken}) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   if(authToken!=null){
  //     preferences.setString(StringManager.userTokenKey, authToken);
  //   }else{
  //     OwnerDataModel userModel = await returnUserData();
  //     preferences.setString(StringManager.userTokenKey, authToken!);
  //   }


  // }

  // Future<String> returnUserToken() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();

  //   String tokenPref =
  //       preferences.getString(StringManager.userTokenKey) ?? "noToken";
  //   return tokenPref;
  // }





  // // Future<void> saveLocalazitaon({required String language}) async {
  // //   SharedPreferences preferences = await SharedPreferences.getInstance();
  // //   preferences.setString("languagne", language);
  // // }

  // // Future<String> getlocalization() async {
  // //   SharedPreferences preferences = await SharedPreferences.getInstance();
  // //   String language = preferences.getString("languagne") ?? "en";
  // //   return language;
  // // }

  // Future<void> setPlatform({required String platForm}) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.setString(StringManager.platform, platForm);
  // }




  // Future<void>  setCachingMusic({required Map<String,dynamic> cachingMusic}) async{
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   String encodedMap = jsonEncode(cachingMusic);
  //   preferences.setString("cachMusic", encodedMap);
  // }

  // Future<Map<String,dynamic>> getCachingMusic() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   Map<String,MusicObject> defultMap = {} ;
  //   String encodedMap1 = json.encode(defultMap);
  //   String encodedMap = preferences.getString('cachMusic')?? encodedMap1;
  //   Map<String,dynamic> decodedMap = json.decode(encodedMap);

  //   return decodedMap;
  // }

  // Future<String> getPlatform() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   String data = preferences.getString(StringManager.platform) ?? "en";
  //   return data;
  // }

  // Future<void> exitFromRoom(String ownerId) async{

  //   ZegoUIKitPrebuiltLiveAudioRoomState.connectManager?.uninit();
  //   await ZegoUIKitPrebuiltLiveAudioRoomState.seatManager?.uninit();
  //   await ZegoUIKitPrebuiltLiveAudioRoomState.plugins?.uninit();

  //   await ZegoUIKit().resetSoundEffect();
  //   await ZegoUIKit().resetBeautyEffect();
  //   await ZegoUIKit().leaveRoom();
  //   await ZegoUIKit().uninit();
  //   await ZegoUIKit().uninit();
  //   clearAll();
  //    ZegoUIKit().logout() ;
  //   ExistroomUC e = ExistroomUC(getIt());
  //   await e.call(ownerId);
  //   PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  //   pusher.unsubscribe(channelName: 'presence-room-${ownerId}');
  // }

  // Future<void> cheakIfInRoom({required String ownerId}) async{
  //   //  clearAll();
  //   if(MainScreen.iskeepInRoom.value){
  //   MainScreen.iskeepInRoom.value =false ;
  //     await  Methods().exitFromRoom( MainScreen.roomData!.ownerId.toString()) ;
  //   }

  // }

  // checkIfRoomHasPassword(
  //     {required BuildContext context,
  //     required bool hasPassword,
  //     required String ownerId ,required OwnerDataModel myData}) async {
  //   if (hasPassword) {
  //     showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //               title: Text(StringManager.enterPassword.tr()),
  //               content: EnterPasswordRoomScreen(
  //                 ownerId: ownerId,
  //                 myData: myData,
  //               ));
  //         });
  //   } else {
  //     await Methods().cheakIfInRoom(ownerId: ownerId);

  //     // ignore: use_build_context_synchronously
  //     BlocProvider.of<RoomBloc>(context)
  //         .add(EnterRoomEvent(ownerId: ownerId, roomPassword: '' , isVip: myData.vip1?.level??0));

  //     // ignore: use_build_context_synchronously
  //     Navigator.pushNamed(context, Routes.roomHandler, arguments: myData);
  //   }
  // }

  // Future<void> cacheSvgaImage({required String svgaUrl,required  String imageId}) async {
  //   final cacheManager = DefaultCacheManager();
  //   final file = await cacheManager.getFileFromCache(imageId) ;
  //   // check if image is cached or not
  //   if (file == null ) {
  //     log("downloading${imageId}");
  //     await cacheManager.downloadFile(svgaUrl,key:imageId,);
  //     log("loaded${imageId}");
  //   }


  // }

  // //cache extra
  //   Future<SvgaDataModel> getExtraData() async {
  //     String token = await Methods().returnUserToken();
  //     Map<String, String> headers = {
  //       "Authorization": "Bearer $token",
  //     };
  //     try {
  //       final response = await Dio().get(
  //         ConstentApi.getExtraData,
  //         options: Options(
  //           headers: headers,
  //         ),
  //       );
  //       Map<String, dynamic> jsonData = response.data;

  //       SvgaDataModel svgaDataModel = SvgaDataModel.fromJason(jsonData['data']) ;
  //       log(svgaDataModel.toString());
  //       return svgaDataModel;
  //     } on DioError catch (e) {
  //       throw DioHelper.handleDioError(e);
  //     }
  //   }
  //   Future<void> getAndLoadExtraData() async {
  //     SvgaDataModel svgaDataModel = await getExtraData();
  //     await  cacheSvgaExtraData(svgaDataModel: svgaDataModel);
  //   }
  //   Future<void> cacheSvgaExtraData({required  SvgaDataModel svgaDataModel}) async {
  //     for(int i=0;i< svgaDataModel.vipImage .length;i++){
  //       await cacheSvgaImage(svgaUrl:ConstentApi().getImage(svgaDataModel.vipImage[i].img),
  //           imageId:'${svgaDataModel.vipImage[i].id}${cachExtraLevelKey}');
  //       if(svgaDataModel.vipImage[i].entro != null){
  //         await cacheSvgaImage(svgaUrl:ConstentApi().getImage(svgaDataModel.vipImage[i].entro),
  //             imageId:'${svgaDataModel.vipImage[i].entroId}${cacheEntroKey}');
  //       }
  //       if(svgaDataModel.vipImage[i].frame!= null) {
  //         await cacheSvgaImage(
  //             svgaUrl: ConstentApi().getImage(svgaDataModel.vipImage[i].frame),
  //             imageId: '${svgaDataModel.vipImage[i].frameId}${cacheFrameKey}');
  //       }
  //     }

  //     for(int i=0;i< svgaDataModel.pkIamges.length;i++){
  //       await cacheSvgaImage(svgaUrl:ConstentApi().getImage(svgaDataModel.pkIamges[i].url),
  //           imageId:'${svgaDataModel.pkIamges[i].id}${cachExtraKey}');

  //     }


  //   }


  // //cache Frame
  // Future<List<DataMallModel>> getUsersEntro() async {
  //   String token = await Methods().returnUserToken();
  //   Map<String, String> headers = {
  //     "Authorization": "Bearer $token",
  //   };
  //   try {
  //     final response = await Dio().get(
  //       ConstentApi().getDataMallUrl(6),
  //       options: Options(
  //         headers: headers,
  //       ),
  //     );
  //     Map<String, dynamic> jsonData = response.data;
  //     bool succes = jsonData[ConstentApi.succes];
  //     List<DataMallModel> listDataMall = [];
  //     if (succes) {
  //       for (int i = 0; i < jsonData[ConstentApi.data].length; i++) {
  //         DataMallModel dataModel =
  //         DataMallModel.fromJson(jsonData[ConstentApi.data][i]);
  //         listDataMall.add(dataModel);
  //       }
  //     }
  //     return listDataMall;
  //   } on DioError catch (e) {
  //     throw DioHelper.handleDioError(e);
  //   }
  // }
  // Future<void> getAndLoadEntro() async {
  //   List<DataMallModel> entroModel = await getUsersEntro();
  //   await  cacheSvgaEntro(dataMallModel: entroModel);
  // }
  // Future<void> cacheSvgaEntro({required  List<DataMallModel> dataMallModel}) async {
  //   for(int i=0;i< dataMallModel.length;i++){

  //     await cacheSvgaImage(svgaUrl:ConstentApi().getImage(dataMallModel[i].svg),
  //         imageId:'${dataMallModel[i].id.toString()}${cacheEntroKey}');

  //   }


  // }



  // //cache Frame
  // Future<List<DataMallModel>> getFrames() async {
  //   String token = await Methods().returnUserToken();
  //   Map<String, String> headers = {
  //     "Authorization": "Bearer $token",
  //   };
  //   try {
  //     final response = await Dio().get(
  //       ConstentApi().getDataMallUrl(4),
  //       options: Options(
  //         headers: headers,
  //       ),
  //     );
  //     Map<String, dynamic> jsonData = response.data;
  //     bool succes = jsonData[ConstentApi.succes];
  //     List<DataMallModel> listDataMall = [];
  //     if (succes) {
  //       for (int i = 0; i < jsonData[ConstentApi.data].length; i++) {
  //         DataMallModel dataModel =
  //         DataMallModel.fromJson(jsonData[ConstentApi.data][i]);
  //         listDataMall.add(dataModel);
  //       }
  //     }
  //     return listDataMall;
  //   } on DioError catch (e) {
  //     throw DioHelper.handleDioError(e);
  //   }
  // }
  // Future<void> getAndLoadFrames() async {
  //   List<DataMallModel> emojieModel = await getFrames();
  //   await  cacheSvgaFrame(dataMallModel: emojieModel);
  // }
  // Future<void> cacheSvgaFrame({required  List<DataMallModel> dataMallModel}) async {
  //   for(int i=0;i< dataMallModel.length;i++){

  //     await cacheSvgaImage(svgaUrl:ConstentApi().getImage(dataMallModel[i].svg),
  //         imageId:'${dataMallModel[i].id.toString()}${cacheFrameKey}');

  //   }


  // }


  // // cache Emojie
  // Future<void> getAndLoadEmojie() async {
  //   List<EmojieModel> emojieModel = await getEmojie();
  //   await  cacheSvgaEmojie(emojieModel: emojieModel);


  // }
  // Future<List<EmojieModel>> getEmojie() async {
  //   String token = await Methods().returnUserToken();
  //   try{
  //     final response = await Dio().get(ConstentApi.getEmojie,
  //         options: Options(
  //           headers: {"authorization": "Bearer $token"},
  //         ));
  //     return List<EmojieModel>.from(
  //         (response.data["data"] as List).map((e) => EmojieModel.fromjson(e)));

  //   } on DioError catch(e){
  //     throw DioHelper.handleDioError(e);
  //   }
  // }

  // Future<void> cacheSvgaEmojie({required  List<EmojieModel> emojieModel}) async {
  //   for(int i=0;i< emojieModel.length;i++){

  //     await cacheSvgaImage(svgaUrl:ConstentApi().getImage(emojieModel[i].emoji),imageId:'${emojieModel[i].id.toString()}${cacheEmojieKey}');

  //   }


  // }



  // //cache gifts
  // Future<void> chachGiftInRoom( ) async {
  //   List<GiftsModel>  normalGift =  await getGifts(1) ;
  //   List<GiftsModel>  hotGift =  await getGifts(2) ;
  //   List<GiftsModel>  ciuntryGift =  await getGifts(3) ;


  //   await  initDownloadPath(normalGift);
  //   await   initDownloadPath(hotGift);
  //   await  initDownloadPath(ciuntryGift);
  // }

  // Future<List<GiftsModel>> getGifts(int  type) async{
  //   String token = await Methods().returnUserToken();
  //   final headers = {
  //     "Authorization": "Bearer $token",
  //   };
  //   final response = await Dio().get(ConstentApi().getGifts(type),
  //       options: Options(
  //         headers: headers,
  //       ));
  //   Map<String, dynamic> jsonData = response.data;
  //   List<GiftsModel> GiftsModelList = [];
  //   for (int i = 0; i < jsonData['data'].length; i++) {
  //     GiftsModelList.add(GiftsModel.fromJson(jsonData['data'][i]));
  //   }
  //   return GiftsModelList;
  // }

  // Future<void> initDownloadPath(List<GiftsModel> data) async {
  //   Directory appDocDir = await getApplicationDocumentsDirectory();
  //   String rootPath = appDocDir.path ;

  //   for(int i=0;i<data.length;i++){
  //     if(!data[i].showImg.contains('mp4')){
  //       //cache svga image
  //       cacheSvgaImage(svgaUrl: ConstentApi().getImage(data[i].showImg),imageId:data[i].id.toString());
  //       continue ;
  //     }

  //     String path = "$rootPath/${data[i].id}.mp4";
  //     _download(path: path, img: data[i].showImg, giftId: data[i].id);



  //   }

  // }

  // _download({required String img, required  int giftId  ,required String path}) async {
  //   Map<String,dynamic> chachedMp4Gifts = await Methods().getCachingGifts() ;


  //   PageViewGeftWidget.chachedGiftMp4 =chachedMp4Gifts;



  //   if(!chachedMp4Gifts.containsKey(giftId.toString())){
  //     log('downloading$giftId');
  //     await  Dio().download(ConstentApi().getImage(img), path);
  //     log('loaded$giftId');

  //     PageViewGeftWidget.chachedGiftMp4.putIfAbsent(giftId.toString(), () => path) ;
  //     chachedMp4Gifts.putIfAbsent(giftId.toString(), () => path) ;
  //     log(PageViewGeftWidget.chachedGiftMp4.toString());

  //   }


  //   await Methods().setCachingGifts(cachingGifts:PageViewGeftWidget.chachedGiftMp4) ;
  // }

  // Future<MovieEntity> getCachedSvgaImage( String giftId, String url) async {
  //   final cacheManager = DefaultCacheManager();
  //   final file = await cacheManager.getFileFromCache(giftId);
  //   final bytes = await file?.file.readAsBytes() ;
  //    if(bytes != null){
  //      final videoItem = await SVGAParser.shared.decodeFromBuffer(bytes.toList()) ;
  //      return videoItem ;
  //    }else{
  //   return   await SVGAParser.shared
  //          .decodeFromURL(ConstentApi().getImage(giftId)).whenComplete(()async {
  //     await Methods().cacheSvgaImage(
  //       svgaUrl: url,
  //       imageId: giftId,
  //     );
  //   });
  //    }

  // }
}