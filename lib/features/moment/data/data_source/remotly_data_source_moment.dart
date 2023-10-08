

import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/moment/data/model/moment_comment_model.dart';
import 'package:tik_chat_v2/features/moment/data/model/moment_gift_model.dart';
import 'package:tik_chat_v2/features/moment/data/model/moment_like_model.dart';
import 'package:tik_chat_v2/features/moment/data/model/moment_model.dart';
import 'package:tik_chat_v2/features/moment/domain/moment_usecse/add_moment_comment_use_case.dart';
import 'package:tik_chat_v2/features/moment/domain/moment_usecse/add_moment_use_case.dart';
import 'package:tik_chat_v2/features/moment/domain/moment_usecse/delete_moment_comment_use_case.dart';
import 'package:tik_chat_v2/features/moment/domain/moment_usecse/get_moment_comment_usecase.dart';
import 'package:tik_chat_v2/features/moment/domain/moment_usecse/get_moment_gifts_uc.dart';
import 'package:tik_chat_v2/features/moment/domain/moment_usecse/get_moment_likes_uc.dart';
import 'package:tik_chat_v2/features/moment/domain/moment_usecse/get_moment_use_case.dart';
import 'package:tik_chat_v2/features/moment/domain/moment_usecse/moment_send_gift.dart';


abstract class BaseRemotlyDataSourceMoment {
  Future<List<MomentLikeModel>> getMomentLike(
      GetMomentLikePrameter getMomentLikePrameter);


  Future<String> addMomnet(AddMomentPrameter prameter);

  Future<String> deleteMoment(String momentId);

  Future<List<MomentModel>> getMoments(GetMomentPrameter pram);

  Future<String> addMomentCooment(AddMomentCommentPrameter momentId);

  Future<String> deleteMomentComment(
      DeleteMomentCommentPrameter deleteMomentCommentPrameter);

  Future<List<MomentCommentModel>> getMomentComment(
      GetMomentCommentPrameter getMomentCommentPrameter);

  Future<String> makeMomentLike(String momentId);
  Future<String> momentSendGifts(MomentSendGiftPrameter momentSendGiftPrameter);
  Future<List<MomentGiftsModel>> getMomentGifts(
      GetMomentGiftsPrameter getMomentGiftsPrameter);
}


class RemotlyDataSourceMoment extends BaseRemotlyDataSourceMoment{

  @override
  Future<String> addMomnet(AddMomentPrameter prameter) async{
    Map<String, String> headers = await DioHelper().header();

    File? imageFile ;
    String? imageName;
    FormData formData;

    if (prameter.momentImage != null) {
      imageFile = prameter.momentImage;
      imageName = imageFile!.path.split('/').last;
      Map<String, dynamic> body = {
        "contacts": prameter.moment,
        // "user_id": prameter.userId,
        'img':
        await MultipartFile.fromFile(imageFile.path, filename: imageName),
      };
      formData = FormData.fromMap(body);


    }else
    {

      Map<String, dynamic>body = {
        "contacts" : prameter.moment ,
        // "user_id" : prameter.userId ,
      } ;
      formData = FormData.fromMap(body);
    }

    try {
      final response = await Dio().post(
        ConstentApi.addMoment,
        data: formData,
        options: Options(
          headers: headers,
        ),
      );

      log(response.data.toString());

      return response.data['message'];
    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e,endpointName: 'addMoment');
    }
  }

  @override
  Future<String> addMomentCooment(AddMomentCommentPrameter prameter) async{
    Map<String, String> headers = await DioHelper().header();
    Map body = {
      "comment" : prameter.comment ,

    } ;

    try {
      final response = await Dio().post(
        ConstentApi.addMomentComment(prameter.momentId),
        data: body,
        options: Options(
          headers: headers,
        ),
      );
      log(response.data.toString());

      return response.data['message'];
    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e,endpointName: 'addMomentComment');
    }
  }

  @override
  Future<String> deleteMomentComment(DeleteMomentCommentPrameter deleteMomentCommentPrameter)async {
    Map<String, String> headers = await DioHelper().header();

    try {
      final response = await Dio().delete(
        ConstentApi.deleteMomentComment(deleteMomentCommentPrameter.momentId , deleteMomentCommentPrameter.commentId),
        options: Options(
          headers: headers,
        ),
      );
      log(response.data.toString());

      return response.data['message'];
    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e,endpointName: 'deleteMomentComment');
    }
  }

  @override
  Future<List<MomentCommentModel>> getMomentComment(GetMomentCommentPrameter getMomentCommentPrameter)async {
    Map<String, String> headers = await DioHelper().header();


    try {
      final response = await Dio().get(
        ConstentApi.getMomentComment(
            getMomentCommentPrameter.momentId, getMomentCommentPrameter.page),
        options: Options(
          headers: headers,
        ),
      );
      log(response.data.toString());

      return List<MomentCommentModel>.from(
          response.data['data'].map((x) => MomentCommentModel.fromJson(x)));
    } on DioError catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: 'getMomentComment');
    }
  }

  @override
  Future<String> makeMomentLike(String momentId) async {
    Map<String, String> headers = await DioHelper().header();

    try {
      final response = await Dio().post(
        ConstentApi.makeMomentLikes(momentId),
        options: Options(
          headers: headers,
        ),
      );


      return response.data['message'];
    } on DioError catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: 'makeMomentLike');
    }
  }





  @override
  Future<List<MomentLikeModel>> getMomentLike(GetMomentLikePrameter getMomentLikePrameter)async {
    Map<String, String> headers = await DioHelper().header();


    try {
      final response = await Dio().get(
        ConstentApi.getMomentLike(
            getMomentLikePrameter.momentId, getMomentLikePrameter.page),
        options: Options(
          headers: headers,
        ),
      );
      return List<MomentLikeModel>.from(
          response.data['data'].map((x) => MomentLikeModel.fromjson(x)));
    } on DioError catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: 'getMomentLike');
    }
  }



  @override
  Future<String> deleteMoment(String momentId)async {
    Map<String, String> headers = await DioHelper().header();

    try {
      final response = await Dio().delete(
        ConstentApi.deleteMoment(momentId),
        options: Options(
          headers: headers,
        ),
      );
      Map<String, dynamic> resultData = response.data;

      return resultData['message'];

    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e,endpointName:'deleteMoment' );
    }
  }

  @override
  Future<List<MomentModel>> getMoments(GetMomentPrameter pram)async {
    Map<String, String> headers = await DioHelper().header();

    try {
      final response = await Dio().get(
        ConstentApi.getMoments(pram.userId??'',pram.type,pram.page,),
        options: Options(
          headers: headers,
        ),
      );
      Map<String, dynamic> resultData = response.data;
log('here${resultData.toString()}');
      return List<MomentModel>.from(
          resultData['data'].map((x) => MomentModel.fromJson(x)));

    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e,endpointName:'getMoment');
    }
  }

  @override
  Future<String> momentSendGifts(MomentSendGiftPrameter momentSendGiftPrameter)async {
    Map<String, String> headers = await DioHelper().header();
    final body = {
      'num': momentSendGiftPrameter.giftNum.toString(),
      'gift_id': momentSendGiftPrameter.giftId.toString(),
    };
    try {
    
      final response = await Dio().post(ConstentApi.momentSendGift(momentID: momentSendGiftPrameter.momentId),
          options: Options(
            headers: headers,
          ),
          data: body);
      log(response.data.toString());
      return response.data['message'];
    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e, endpointName: 'sendGifts');
    }
    
  }


  @override
  Future<List<MomentGiftsModel>> getMomentGifts(
      GetMomentGiftsPrameter getMomentGiftsPrameter) async {
    Map<String, String> headers = await DioHelper().header();

    try {
      final response = await Dio().get(

        ConstentApi.getMomentLike(
            getMomentGiftsPrameter.momentId, getMomentGiftsPrameter.page),
        options: Options(
            headers: headers
        ),
      );
      return List<MomentGiftsModel>.from(
          response.data['data'].map((x) => MomentGiftsModel.fromjson(x)));
    } on DioError catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: 'getMomentGifts');
    }
  }




}