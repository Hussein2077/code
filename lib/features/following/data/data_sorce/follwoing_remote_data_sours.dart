


import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:tik_chat_v2/core/model/all_rooms_model.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';


abstract class FollwoingRemoteDataSours {

    Future<List<UserDataModel>> getFriendsOpenRoom(int type);

 Future<AllRoomsDataModel> getFollowersRooms(
      {required String type });

}



class FollwingRemoteDataSoursImp implements FollwoingRemoteDataSours {


  

    @override
  Future<List<UserDataModel>> getFriendsOpenRoom(int type) async {
    Map<String, String> headers = await DioHelper().header();

    try {
      final response = await Dio().get('${ConstentApi.relations}?type=$type',
          options: Options(
            headers: headers,
          ));
          log(response.toString());
          

      List<UserDataModel> relation = List<UserDataModel>.from((response
              .data["data"] as List)
          .map((e) => UserDataModel.fromMap(e)));
          log(relation.toString());
      return Future.value(relation);
    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e,endpointName: 'getFriendsOpenRoom');
    }
  
  }
  
  @override
  Future<AllRoomsDataModel> getFollowersRooms({required String type}) async{
    Map<String, String> headers = await DioHelper().header();

    try {
     
        final response=   await Dio().get(
              '${ConstentApi.relations}?type=$type',
              options: Options(
                headers: headers,
              ),
            );
         

      AllRoomsDataModel rooms = AllRoomsDataModel.fromMap(response.data);
      return rooms ; 
    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e,endpointName: 'FollwingRemoteDataSoursImp');
    }
  }


}