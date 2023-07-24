import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';

import '../../../../core/error/failures.dart';

class JoinToAgencieUsecase {
  BaseRepositoryProfile baseRepositoryProfile;
  JoinToAgencieUsecase({required this.baseRepositoryProfile});
  Future<Either<bool, Failure>> joinToAgence(
      String agencieId, String wahtsAppNum) async {
    final result =
        await baseRepositoryProfile.joinToAgencie(agencieId, wahtsAppNum);
    return result;
  }
}