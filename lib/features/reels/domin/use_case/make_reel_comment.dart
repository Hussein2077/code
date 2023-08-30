import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/reels/domin/repository/base_repository_reels.dart';

class MakeReelCommentUseCase {
  BaseRepositoryReels baseRepositoryReel;

  MakeReelCommentUseCase({required this.baseRepositoryReel});

  Future<Either<String, Failure>> makeReelComment(String reelId , String comment) async {
    final result = await baseRepositoryReel.makeReelComment(reelId , comment);
    return result;
  }
}