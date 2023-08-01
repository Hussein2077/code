

import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';


class RemoveUserFromFamilyUsecase {
  BaseRepositoryProfile baseRepositoryProfile;
  RemoveUserFromFamilyUsecase({required this.baseRepositoryProfile});
  Future<Either<String, Failure>> removeUser(String uId, String famiyId) async {
    final result = await baseRepositoryProfile.familyRemovUser(uId, famiyId);
    return result;
  }
}
