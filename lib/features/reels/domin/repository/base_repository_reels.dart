import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/reels/data/models/reel_comment_model.dart';
import 'package:tik_chat_v2/features/reels/data/models/reel_model.dart';
import 'package:tik_chat_v2/features/reels/domin/use_case/upload_reel_use_case.dart';

abstract class BaseRepositoryReels {
  Future<Either<String, Failure>> uploadReel(UploadReelParamiter uploadReelParamiter);
  Future<Either<List<ReelModel>, Failure>> getReels(String? page);
  Future<Either<List<ReelCommentModel>, Failure>> getReelComments(String? page , String reelId);
  Future<Either<String, Failure>> makeReelComment( String reelId ,  String comment);

  Future<Either<String, Failure>> makeReelLike( String reelId ,  );

}