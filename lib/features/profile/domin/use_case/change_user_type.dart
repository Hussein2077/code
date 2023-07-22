

import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';


class ChangeUserTypeUsecase {
  BaseRepositoryProfile baseRepositoryProfile;
  ChangeUserTypeUsecase({required this.baseRepositoryProfile});
  Future<Either<String, Failure>> changeUserType(
      String userId, String familyId, String type) async {
    final result =
        await baseRepositoryProfile.changeUserType(userId, familyId, type);
    return result;
  }
}
