import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/data/model/get_badges_model.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';

class GetBadgesUseCase {
  BaseRepositoryProfile baseRepositoryProfile;
  GetBadgesUseCase({required this.baseRepositoryProfile});
  Future<Either<List<GetBadgesModel>, Failure>> getBadges(String type) async {
    final result = await baseRepositoryProfile.getBadges(type);
    return result;
  }
}
