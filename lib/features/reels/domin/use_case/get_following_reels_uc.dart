import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/reels/data/models/reel_model.dart';
import 'package:tik_chat_v2/features/reels/domin/repository/base_repository_reels.dart';

class GetFollowingReelUseCase {
  BaseRepositoryReels baseRepositoryReel;

  GetFollowingReelUseCase({required this.baseRepositoryReel});

  Future<Either<List<ReelModel>, Failure>> getFollowingReel(String? page) async {
    final result = await baseRepositoryReel.getFollowingReels(page);
    return result;
  }
}