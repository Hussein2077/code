import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/moment/data/model/moment_comment_model.dart';
import 'package:tik_chat_v2/features/moment/data/model/moment_like_model.dart';
import 'package:tik_chat_v2/features/moment/domain/use_case/add_moment_comment_use_case.dart';
import 'package:tik_chat_v2/features/moment/domain/use_case/add_moment_use_case.dart';
import 'package:tik_chat_v2/features/moment/domain/use_case/delete_moment_comment_use_case.dart';
import 'package:tik_chat_v2/features/moment/domain/use_case/get_moment_comment_usecase.dart';
import 'package:tik_chat_v2/features/moment/domain/use_case/get_moment_likes_uc.dart';
import 'package:tik_chat_v2/features/moment/domain/use_case/get_moment_use_case.dart';
import 'package:tik_chat_v2/features/moment/domain/use_case/moment_send_gift.dart';
import 'package:tik_chat_v2/features/moment/data/model/moment_model.dart';

abstract class BaseRemotlyDataSourceMoment {


  Future<String> addMomnet(AddMomentPrameter prameter);

  Future<String> deleteMoment(String momentId);

  Future<List<MomentModel>> getMoments(GetMomentPrameter pram);

  Future<String> addMomentCooment(AddMomentCommentPrameter momentId);

  Future<String> deleteMomentComment(
      DeleteMomentCommentPrameter deleteMomentCommentPrameter);

  Future<List<MomentCommentModel>> getMomentComment(
      GetMomentCommentPrameter getMomentCommentPrameter);

  Future<String> makeMomentLike(String userId);

  Future<String> momentSendGift(MomentSendGiftPrameter momentSEndGiftPrameter);
  Future<List<MomentLikeModel>> getMomentLike(
      GetMomentLikePrameter getMomentLikePrameter);
}

class RemotlyDataSourceMoment extends BaseRemotlyDataSourceMoment{


  @override
  Future<String> addMomnet(AddMomentPrameter prameter) async{
    Map<String, String> headers = await DioHelper().header();
    Map body = {
      "contacts" : prameter.moment ,
      "user_id" : prameter.userId ,
    } ;

    try {
      final response = await Dio().post(
        ConstentApi.addMoment,
        data: body,
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


      return List<MomentModel>.from(
          resultData['data'].map((x) => MomentModel.fromJson(x)));

    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e,endpointName:'getMoment');
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
  Future<String> makeMomentLike(String userId) async {
    try {
      final response = await Dio().get(
        ConstentApi.makeMomentLikes,
      );

      return response.data;
    } on DioError catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: 'makeMomentLike');
    }
  }

  @override
  Future<String> momentSendGift(MomentSendGiftPrameter momentSEndGiftPrameter) async{
    try{
      final response = await Dio().get(
        ConstentApi.makeMomentLikes,
      );

      return response.data;
    }on DioError catch (e) {
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
      log(response.data.toString());

      return List<MomentLikeModel>.from(
          response.data['data'].map((x) => MomentLikeModel.fromjson(x)));
    } on DioError catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: 'getMomentLike');
    }
  }
}