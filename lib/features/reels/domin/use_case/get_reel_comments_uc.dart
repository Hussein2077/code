import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/reels/data/models/reel_comment_model.dart';
import 'package:tik_chat_v2/features/reels/domin/repository/base_repository_reels.dart';

class GetReelCommentUseCase {
  BaseRepositoryReels baseRepositoryReel;

  GetReelCommentUseCase({required this.baseRepositoryReel});

  Future<Either<List<ReelCommentModel>, Failure>> getReelComment(String? page , String reelId ) async {
    final result = await baseRepositoryReel.getReelComments(page , reelId );
    return result;
  }
}