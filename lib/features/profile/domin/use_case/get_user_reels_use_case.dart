import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';
import 'package:tik_chat_v2/features/reels/data/models/reel_model.dart';

class GetUserReelsUsecase {
  BaseRepositoryProfile baseRepositoryProfile;
  GetUserReelsUsecase({required this.baseRepositoryProfile});
  Future<Either<List<ReelModel>, Failure>> getUserReels( String? id , String page ) async {
    final result = await baseRepositoryProfile.getUserReels(id , page);
    return result;
  }
}