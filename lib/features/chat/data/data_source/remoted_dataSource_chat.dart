


import 'package:dio/dio.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/features/chat/data/models/official_msgs_model.dart';


import '../models/group_chat_model.dart';

abstract class BaseDataSourceChat {
  Future<OfficialSystemModel> getOfficailMsgs();
    Future<String> postGroupMassage(String massage);
        Future<List<GroupChatModel>> getGroupMassage(String?page);
  Future<bool> blockUnblock(String userId);


}




class RemotedDataSourceChat extends BaseDataSourceChat {
    static String massagePrice = "";

  @override
  Future <OfficialSystemModel> getOfficailMsgs() async {
    Map<String, String> headers = await DioHelper().header();
    final timeZone=await Methods.instance.getCurrentTimeZone();
    headers.addAll({'tz':timeZone});

    try {
     final response = await Dio().get(
      ConstentApi.getOfficialMsgs,
      options: Options(
        headers: headers,
      ),
    );
    
    Map<String, dynamic> jsonData = response.data;
    
    
    return  OfficialSystemModel.fromJson(jsonData['data']) ;
      
    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e,endpointName: 'getOfficailMsgs');
    }
   


  }
  
  @override
  Future<String> postGroupMassage(String massage) async{
      Map<String, String> headers = await DioHelper().header();
 
 //change api end point ?????????????????????????
    try {
     final response = await Dio().post(
      ConstentApi.senGroupChat,
      options: Options(
        headers: headers,


      ),
      data: {"text" : massage}
    );
    
    Map<String, dynamic> jsonData = response.data;
    
    return (jsonData['message']) ;
      
    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e,endpointName: 'postGroupMassage');
    }
  }
  
  @override
  Future<List<GroupChatModel>> getGroupMassage(String?page)async {
     Map<String, String> headers = await DioHelper().header();
 
 //change api end point ?????????????????????????
    try {
     final response =
     page == null?
      await Dio().get(
      ConstentApi.getGroupChat,
      options: Options(
        headers: headers,


      ),
   
    ): await Dio().get(
      "${ConstentApi.getGroupChat}?page=$page",
      options: Options(
        headers: headers,


      ),
   
    );
    
    Map<String, dynamic> jsonData = response.data;
        RemotedDataSourceChat.massagePrice = jsonData['price_message'];



    
          List<GroupChatModel> relation = List<GroupChatModel>.from(
          (jsonData["data"] as List)
              .map((e) => GroupChatModel.fromJson(e)));

      return Future.value(relation);
      
    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e,endpointName:'getGroupMassage' );
    }
  }
    @override
    Future<bool> blockUnblock(String userId) async{
      Map<String, String> headers = await DioHelper().header();
      try {
        final response = await Dio().get(
          ConstentApi.checkBlockUnblock(userId),
          options: Options(
            headers: headers,
          ),
        );

        bool jsonData = response.data['data']['is_blocked'];

        return jsonData;
      } on DioError catch (e) {
        throw DioHelper.handleDioError(
            dioError: e, endpointName: 'checkBlockUnblock');
      }

    }
}
