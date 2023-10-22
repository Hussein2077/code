import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/reels/data/data_source/remotly_data_source_reel.dart';
import 'package:tik_chat_v2/features/reels/data/models/reel_comment_model.dart';
import 'package:tik_chat_v2/features/reels/data/models/reel_model.dart';
import 'package:tik_chat_v2/features/reels/domin/repository/base_repository_reels.dart';
import 'package:tik_chat_v2/features/reels/domin/use_case/report_reals_use_case.dart';
import 'package:tik_chat_v2/features/reels/domin/use_case/upload_reel_use_case.dart';

class RepositoryReels extends BaseRepositoryReels {
   final BaseRemotlyDataSourceReels baseRemotlyDataSourceReels;
  RepositoryReels({required this.baseRemotlyDataSourceReels});

  @override
  Future<Either<String, Failure>> uploadReel(UploadReelParamiter uploadReelParamiter)async {
     try {
      final result = await baseRemotlyDataSourceReels.uploadReel(uploadReelParamiter);
      return Left(result);
    } on Exception catch (e) {
     return Right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<List<ReelModel>, Failure>> getReels(String? page,String? reelId)async {
    try {
      final result = await baseRemotlyDataSourceReels.getReels(page,reelId);
      return Left(result);
    } on Exception catch (e) {
     return Right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<List<ReelCommentModel>, Failure>> getReelComments(String? page, String reelId) async{
     try {
      final result = await baseRemotlyDataSourceReels.getComments(page , reelId);
      return Left(result);
    } on Exception catch (e) {
     return Right(DioHelper.buildFailure(e));
    }
  }
  
  @override
  Future<Either<String, Failure>> makeReelComment(String reelId, String comment)async {
   try {
      final result = await baseRemotlyDataSourceReels.makeComments(  reelId , comment);
      return Left(result);
    } on Exception catch (e) {
     return Right(DioHelper.buildFailure(e));
    }
  }
  
  @override
  Future<Either<String, Failure>> makeReelLike(String reelId)async {
  try {
      final result = await baseRemotlyDataSourceReels.makeLike(  reelId );
      return Left(result);
    } on Exception catch (e) {
     return Right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<String, Failure>> reportReals(ReportRealsParameter reportRealsParameter)async {
    try {
      final result = await baseRemotlyDataSourceReels.reportReals(reportRealsParameter);
      return Left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }

   @override
   Future<Either<List<ReelModel>, Failure>> getFollowingReels(String? page )async {
     try {
       final result = await baseRemotlyDataSourceReels.getFollowingReels( page);
       return Left(result);
     } on Exception catch (e) {
       return Right(DioHelper.buildFailure(e));
     }
   }

}