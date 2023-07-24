

import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';


class ExitFamilyUsecase {
  BaseRepositoryProfile baseRepositoryProfile;
  ExitFamilyUsecase({required this.baseRepositoryProfile});
  Future<Either<String, Failure>> exitFamily() async {
    final result = await baseRepositoryProfile.exitFamily();
    return result;
  }
}
