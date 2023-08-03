import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';

class AgencyRequestsActionUsecase {
  BaseRepositoryProfile baseRepositoryProfile;
  AgencyRequestsActionUsecase({required this.baseRepositoryProfile});
  Future<Either<String, Failure>> agencyRequsetsAction({required String userId, required bool accept}) async {
    final result = await baseRepositoryProfile.agencyRequestsAction(accept: accept , userId: userId);
    return result;
  }
}