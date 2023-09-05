import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/reels/data/models/reel_model.dart';
import 'package:tik_chat_v2/features/reels/domin/repository/base_repository_reels.dart';

class GetReelUseCase {
  BaseRepositoryReels baseRepositoryReel;

  GetReelUseCase({required this.baseRepositoryReel});

  Future<Either<List<ReelModel>, Failure>> getReel(
      {String? page, String? reelId}) async {
    final result = await baseRepositoryReel.getReels(page,reelId);
    return result;
  }
}