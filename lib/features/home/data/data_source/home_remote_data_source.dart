import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:tik_chat_v2/core/model/all_rooms_model.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/features/home/data/model/carousels_model.dart';
import 'package:tik_chat_v2/features/home/data/model/config_model.dart';
import 'package:tik_chat_v2/features/home/data/model/country_model.dart';
import 'package:tik_chat_v2/features/home/data/model/user_rank_model.dart';
import 'package:tik_chat_v2/features/home/domin/use_case/creat_room_usecase.dart';
import 'package:tik_chat_v2/features/home/domin/use_case/get_top_usecase.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/all_main_classes_model.dart';



abstract class HomeRemoteDataSours {

  Future<RankingModel> getTop(TopPramiter topPramiter);
  Future<AllRoomsDataModel> getAllRooms({int? countryId, int? classId, int? typeId,String? search, int? page, TypeGetRooms? typeGetRooms });
  Future<List<CountryModel>> getAllCountry();
  Future<List<CarouselsModel>> getCarousel();
  Future<ConfigModel> getConfigApp(ConfigModelBody configModelBody);
  Future<String> createRoom({required CreateRoomPramiter creatRoomPramiter});
  Future<List<AllMainClassesModel>> getAllRoomTypes();
  Future<AllRoomsDataModel> getAllRoomsVideo({int? countryId, int? classId, int? typeId,String? search, int? page, TypeGetRooms? typeGetRooms});



}



class HomeRemoteDataSoursImp implements HomeRemoteDataSours {



  @override
  Future<AllRoomsDataModel> getAllRooms(
      {int? countryId, int? classId, int? typeId, String? search,int? page,
        TypeGetRooms? typeGetRooms  }) async {
    Map<String, String> headers = await DioHelper().header();
    String? filterType;
    switch(typeGetRooms??''){
      case TypeGetRooms.festival:
        filterType = 'boss';
        break;
      case TypeGetRooms.popular:
        filterType = 'popular';
        break;
      case TypeGetRooms.trend:
        filterType = 'trend';
        break;
    }

    try {
      final response = await Dio().get(
          ConstentApi().getDataRooms(
              page: page,
              classId: classId,
              countryId: countryId,
              typeId: typeId,
              filter: filterType,
              search: search),
          options: Options(
            headers: headers,
          ));
      final rooms = AllRoomsDataModel.fromMap(response.data);
  
      return Future.value(rooms);
    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e,endpointName:'getAllRooms' );
    }
  }


  @override
  Future<List<CountryModel>> getAllCountry() async {
    Map<String, String> headers = await DioHelper().header();

    try{
      final response = await Dio().get(ConstentApi.getCountryUrl,
          options: Options(
            headers: headers,
          ));
      return List<CountryModel>.from((response.data as List).map(
            (e) => CountryModel.fromJson(e),
      ));
    }on DioError catch(e){
      throw DioHelper.handleDioError(dioError: e,endpointName:'getAllCountry');
    }

  }



  @override
  Future<List<CarouselsModel>> getCarousel() async {
    Map<String, String> headers = await DioHelper().header();
   
    try {
      final response = await Dio().get(ConstentApi.getCarousel,
          options: Options(
            headers: headers,
          ));

      final result = response.data;
      List<CarouselsModel> carouselList = [];
      for (int i = 0; i < result['data'].length; i++) {
        carouselList.add(CarouselsModel.fromJson(result['data'][i]));
      }
      return carouselList;
    }on DioError catch (e) {

      throw DioHelper.handleDioError(dioError: e,endpointName:'getCarousel');
    }
  }

 @override
  Future<RankingModel> getTop(TopPramiter topPramiter) async {
    Map<String, String> headers = await DioHelper().header();
 
    final body = {
      'class': topPramiter.sendOrReceiver,
      'type': topPramiter.date,
      'is_home': topPramiter.isHome,

    };
    try {
      final response = await Dio().post(ConstentApi.getTopUrl,
          options: Options(
            headers: headers,
          ),
          data: body);

        Map<String, dynamic> jsonData = response.data;
        log(jsonData.toString());
        RankingModel data = RankingModel.fromJson(jsonData);
                log(data.toString());

        return data;

    } on DioError  catch (e) {
      throw DioHelper.handleDioError(dioError: e,endpointName:'getTop');
    }
  }

  @override
  Future<ConfigModel> getConfigApp(ConfigModelBody configModelBody)async {
    Map<String, String> headers = await DioHelper().header();

    final body = {
      'version': configModelBody.appVersion,
      'OS': configModelBody.devicePlatform,
      'gift_time' :await Methods.instance.getsLastTimeCache(TypesCache.gift),
      'intro_time':await Methods.instance.getsLastTimeCache(TypesCache.intro),
      'frame_time':await Methods.instance.getsLastTimeCache(TypesCache.frame),
      'emoji_time':await Methods.instance.getsLastTimeCache(TypesCache.emojie),
      'extra_time':await Methods.instance.getsLastTimeCache(TypesCache.extra)
    };
    try {
      final response = await Dio().post(ConstentApi.getConfigApp,
          options: Options(
            headers: headers,
          ),
          data: body);

      Map<String, dynamic> jsonData = response.data;
      log(jsonData.toString());
      ConfigModel data = ConfigModel.fromJson(jsonData);
      log(data.toString());
      return data;

    } on DioError  catch (e) {
      throw DioHelper.handleDioError(dioError: e,endpointName:'getConfigApp');
    }
  }

  @override
  Future<String> createRoom(
      {required CreateRoomPramiter creatRoomPramiter}) async {
    Map<String, String> headers = await DioHelper().header();
    FormData formData;
    if (creatRoomPramiter.roomCover == null) {
      formData = FormData.fromMap({
        'room_name': creatRoomPramiter.roomName,
        'room_intro': creatRoomPramiter.roomIntero,
        'room_type': creatRoomPramiter.roomType,
        'room_pass': creatRoomPramiter.roomPassword,
      });
    }
    else {
      File file = creatRoomPramiter.roomCover!;
      String fileName = file.path.split('/').last;
      formData = FormData.fromMap({
        "room_cover":
        await MultipartFile.fromFile(file.path, filename: fileName),
        'room_intro': creatRoomPramiter.roomIntero,
        'room_type': creatRoomPramiter.roomType,
        'room_pass': creatRoomPramiter.roomPassword,
        'room_name': creatRoomPramiter.roomName,

      });
    }
    try{
      final response = await Dio().post(ConstentApi.createRoom,
          options: Options(
            headers: headers,
          ),
          data: formData);
      final result = response.data;


      return result['message'];
    } on DioError catch(e){
      throw DioHelper.handleDioError(dioError: e,endpointName:'createRoom');
    }


  }

  @override
  Future<List<AllMainClassesModel>> getAllRoomTypes() async {
    Map<String, String> headers = await DioHelper().header();

    try{
      final response = await Dio().get(ConstentApi.getAllRoomTypes,
          options: Options(
            headers: headers,
          ));
      Map<String, dynamic> jsonData = response.data;
      List<AllMainClassesModel> dataList = [];
      for (int i = 0; i < jsonData['data'].length; i++) {
        dataList.add(AllMainClassesModel.fromjson(jsonData['data'][i]));
      }

      return dataList;
    } on DioError catch(e){
      throw DioHelper.handleDioError(dioError: e,endpointName:'getAllRoomTypes');
    }

  }

  @override
  Future<AllRoomsDataModel> getAllRoomsVideo(
      {int? countryId, int? classId, int? typeId, String? search,int? page,
        TypeGetRooms? typeGetRooms  }) async {
    Map<String, String> headers = await DioHelper().header();
    String? filterType;
    switch(typeGetRooms??''){
      case TypeGetRooms.festival:
        filterType = 'boss';
        break;
      case TypeGetRooms.popular:
        filterType = 'popular';
        break;
      case TypeGetRooms.trend:
        filterType = 'trend';
        break;
    }


    //TODO chnage base url
    try {

      final response = await Dio().get(
          ConstentApi().getDataRooms(
              page: page,
              classId: classId,
              countryId: countryId,
              typeId: typeId,
              filter: filterType,
              search: search),
          options: Options(
            headers: headers,
          ));
      final rooms = AllRoomsDataModel.fromMap(response.data);

      return Future.value(rooms);
    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e,endpointName:'getAllRooms' );
    }
  }


}