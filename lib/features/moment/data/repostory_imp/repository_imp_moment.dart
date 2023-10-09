




import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/moment/data/data_source/remotly_data_source_moment.dart';
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
import 'package:tik_chat_v2/features/moment/domain/repository/base_repository_moment.dart';


class RepositoryImpMoment extends BaseRepositoryMoment{
 final BaseRemotlyDataSourceMoment baseRemotlyDataSourceMoment;
 RepositoryImpMoment({required this.baseRemotlyDataSourceMoment});

  @override
  Future<Either<String, Failure>> addMoment(AddMomentPrameter addMomentPrameter)async {
    try {
      final result = await baseRemotlyDataSourceMoment.addMomnet(addMomentPrameter ) ;

      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<String, Failure>> deleteMoment(String momentId)async {
    try {
      final result = await baseRemotlyDataSourceMoment.deleteMoment(momentId ) ;
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<List<MomentModel>, Failure>> getMoment(GetMomentPrameter userId)async {
    try {
      final result = await baseRemotlyDataSourceMoment.getMoments(userId ) ;
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<String, Failure>> addMomentComment(AddMomentCommentPrameter addMomentCommentPrameter) async{
    try {
      final result = await baseRemotlyDataSourceMoment.addMomentCooment( addMomentCommentPrameter) ;
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<String, Failure>> deleteMomentComment(DeleteMomentCommentPrameter deleteMomentCommentPrameter)async {
    try {
      final result = await baseRemotlyDataSourceMoment.deleteMomentComment(deleteMomentCommentPrameter) ;
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<List<MomentCommentModel>, Failure>> getMomentComment(GetMomentCommentPrameter getMomentCommentPrameter) async{
    try {
      final result = await baseRemotlyDataSourceMoment.getMomentComment(getMomentCommentPrameter) ;
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<String, Failure>> makeMomentLike(String momentId)async {
    try {
      final result = await baseRemotlyDataSourceMoment.makeMomentLike(momentId) ;
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<String, Failure>> momentSendGift(MomentSendGiftPrameter momentSEndGiftPrameter)async {
    try {
      final result = await baseRemotlyDataSourceMoment.momentSendGifts(momentSEndGiftPrameter) ;
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
    
  }



  @override
  Future<Either<List<MomentLikeModel>, Failure>> getMomentLike(GetMomentLikePrameter getMomentLikePrameter) async{
    try {
      final result = await baseRemotlyDataSourceMoment.getMomentLike(getMomentLikePrameter) ;
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }

 @override
 Future<Either<List<MomentGiftsModel>, Failure>> getMomentGifts(GetMomentGiftsPrameter getMomentGiftsPrameter)async {
   try{

     final result = await baseRemotlyDataSourceMoment.getMomentGifts(getMomentGiftsPrameter);
     return left(result);


   }on Exception catch(e){
     return right(DioHelper.buildFailure(e));
   }
 }

}