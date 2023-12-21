import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/data/model/user_badges_model.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';

class GetUserBadgeUc {
  BaseRepositoryProfile baseRepositoryProfile;
  GetUserBadgeUc({required this.baseRepositoryProfile});
  Future<Either< UserBadgesModel, Failure>> getBadgeUser(String id) async {
    final result = await baseRepositoryProfile.getUserBadge(id);
    return result ;
  }
}