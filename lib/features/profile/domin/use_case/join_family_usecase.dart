

import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';


class JoinFamilymUsecase {
  BaseRepositoryProfile baseRepositoryProfile;
  JoinFamilymUsecase({required this.baseRepositoryProfile});
  Future<Either<String, Failure>> joinFamily(String familyId) async {
    final result = await baseRepositoryProfile.joinFamily(familyId);
    return result;
  }
}
