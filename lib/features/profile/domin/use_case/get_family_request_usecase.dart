

import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/data/model/family_requests_model.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';


class GetFamilyRequestUsecase {
  BaseRepositoryProfile baseRepositoryProfile;
  GetFamilyRequestUsecase({required this.baseRepositoryProfile});
  Future<Either<FamilyRequestsModel, Failure>> getFamilyRequest() async {
    final result = await baseRepositoryProfile.getFamilyRequest();
    return result;
  }
}
