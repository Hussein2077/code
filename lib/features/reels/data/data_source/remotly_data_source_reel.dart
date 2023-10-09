import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/features/reels/data/models/reel_comment_model.dart';
import 'package:tik_chat_v2/features/reels/data/models/reel_model.dart';
import 'package:tik_chat_v2/features/reels/domin/use_case/report_reals_use_case.dart';
import 'package:tik_chat_v2/features/reels/domin/use_case/upload_reel_use_case.dart';

abstract class BaseRemotlyDataSourceReels {

    Future<String> uploadReel(UploadReelParamiter uploadReelParamiter);
    Future<List<ReelModel>> getReels(String? page,String? reelId);
    Future<List<ReelCommentModel>> getComments(String? page , String reelId);
    Future<String> makeComments( String reelId , String comment);
    Future<String> makeLike( String reelId , );
    Future<String> reportReals(ReportRealsParameter reportRealsParameter);


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
        for(int i = 0 ; i < uploadReelParamiter.categories.length ; i++)
        "categories[$i]": uploadReelParamiter.categories[i],
      
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
  Future<List<ReelModel>> getReels(String? page,String? reelId) async{
     Map<String, String> headers = await DioHelper().header();
    try {

      List<ReelModel> reels = [];
      if(reelId != null){
        final responseSpasficReel = await Dio().get(
          ConstentApi.getReel(reelId: reelId , ),
          options: Options(
            headers: headers,
          ),
        );
        ReelModel   spasficReel =ReelModel.fromJson(responseSpasficReel.data["data"]) ;
        reels.add(spasficReel);
       await Methods().cachingReels(reels,responseSpasficReel.data);
      }
      final response = await Dio().get(
        ConstentApi.getReel(page: page),
        options: Options(
          headers: headers,
        ),
      );
          List<ReelModel> normalReels = List<ReelModel>.from(
          (response.data["data"] as List)
              .map((e) => ReelModel.fromJson(e)));
      reels.addAll(normalReels);
      if(page == '1'){
       await Methods().removeCachReels();
      }
      Methods().cachingReels(reels,response.data);
      log(response.data.toString());
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

  @override
  Future<String> reportReals(ReportRealsParameter reportRealsParameter) async {

    Map<String, String> headers = await DioHelper().header();

    Map body = {
      'Reported_id':reportRealsParameter.reportedId,
      'description':reportRealsParameter.description,
      'real_id':reportRealsParameter.realId,
    };



    try {
      final response = await Dio().post(
        ConstentApi.reportReals,
        data: body,
        options: Options(
          headers: headers,
        ),
      );

      return response.data[ConstentApi.message];
    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e ,endpointName: 'Report Reals');
    }

  }



}