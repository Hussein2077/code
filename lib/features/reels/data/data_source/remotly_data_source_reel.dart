import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/reels/data/models/reel_comment_model.dart';
import 'package:tik_chat_v2/features/reels/data/models/reel_model.dart';
import 'package:tik_chat_v2/features/reels/domin/use_case/upload_reel_use_case.dart';

abstract class BaseRemotlyDataSourceReels {

    Future<String> uploadReel(UploadReelParamiter uploadReelParamiter);
        Future<List<ReelModel>> getReels(String? page);
                Future<List<ReelCommentModel>> getComments(String? page , String reelId);

                Future<String> makeComments( String reelId , String comment);
                Future<String> makeLike( String reelId , );


}

class RemotlyDataSourceReels extends BaseRemotlyDataSourceReels {
  @override
  Future<String> uploadReel(UploadReelParamiter uploadReelParamiter) async{
   Map<String, String> headers = await DioHelper().header();
      FormData formData;
   
      File file = uploadReelParamiter.reel;
      String fileName = file.path.split('/').last;

      formData = FormData.fromMap({
                'description' : uploadReelParamiter.description,

        "video": await MultipartFile.fromFile(file.path, filename: fileName),
        "categories": uploadReelParamiter.categories,
      
      });
    

    try {
      final response = await Dio().post(
        ConstentApi.uploadReel,
        data:formData,
        options: Options(
          headers: headers,
        ),
      );

      return response.data[ConstentApi.message];
    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e ,endpointName: 'uploadReel');
    }
  }
  
  @override
  Future<List<ReelModel>> getReels(String? page) async{
     Map<String, String> headers = await DioHelper().header();

    try {
      final response = await Dio().get(
        ConstentApi.getReels,
   
        options: Options(
          headers: headers,
        ),
      );
          List<ReelModel> reels = List<ReelModel>.from(
          (response.data["data"] as List)
              .map((e) => ReelModel.fromJson(e)));

      return reels;
    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e,endpointName:'getReels' );
    }
  }
  
  @override
  Future<List<ReelCommentModel>> getComments(String? page, String reelId)async {
    Map<String, String> headers = await DioHelper().header();

    try {
      final response = await Dio().get(
       ConstentApi.getReelComments(reelId,page),
   
        options: Options(
          headers: headers,
        ),
      );
          List<ReelCommentModel> comments = List<ReelCommentModel>.from(
          (response.data["data"] as List)
              .map((e) => ReelCommentModel.fromJson(e)));

      return comments;
    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e,endpointName:'getReelComents' );
    }
  }
  
  @override
  Future<String> makeComments(String reelId, String comment)async {
         Map<String, String> headers = await DioHelper().header();
         Map body = {
          'comment':comment
         };

    try {
      final response = await Dio().post(
        ConstentApi.makeReelComments(reelId),
        data:body,
        options: Options(
          headers: headers,
        ),
      );

      return response.data[ConstentApi.message];
    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e ,endpointName: 'makeReelComment');
    }
  }
  
  @override
  Future<String> makeLike(String reelId) async{
      Map<String, String> headers = await DioHelper().header();
     

    try {
      final response = await Dio().post(
        ConstentApi.makeReelLike(reelId),
        options: Options(
          headers: headers,
        ),
      );

      return response.data[ConstentApi.message];
    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e ,endpointName: 'makeReelLike');
    }
  }



}