import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/reels/domin/repository/base_repository_reels.dart';

class MakeReelLikeUseCase {
  BaseRepositoryReels baseRepositoryReel;

  MakeReelLikeUseCase({required this.baseRepositoryReel});

  Future<Either<String, Failure>> makeReelLike(String reelId ,) async {
    final result = await baseRepositoryReel.makeReelLike(reelId );
    return result;
  }
}