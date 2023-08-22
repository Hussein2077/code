import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/reels/data/data_source/remotly_data_source_reel.dart';
import 'package:tik_chat_v2/features/reels/data/models/reel_model.dart';
import 'package:tik_chat_v2/features/reels/domin/repository/base_repository_reels.dart';
import 'package:tik_chat_v2/features/reels/domin/use_case/upload_reel_use_case.dart';

class RepositoryReels extends BaseRepositoryReels {
   final BaseRemotlyDataSourceReels baseRemotlyDataSourceReels;


  RepositoryReels(
      {required this.baseRemotlyDataSourceReels});
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
  Future<Either<List<ReelModel>, Failure>> getReels(String? page)async {
    try {
      final result = await baseRemotlyDataSourceReels.getReels(page);
      return Left(result);
    } on Exception catch (e) {
     return Right(DioHelper.buildFailure(e));
    }
  }

}