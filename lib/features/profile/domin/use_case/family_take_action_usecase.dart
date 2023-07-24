



import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';


class FamilyTakeActionUsecase {
  BaseRepositoryProfile baseRepositoryProfile;
  FamilyTakeActionUsecase({required this.baseRepositoryProfile});
  Future<Either<String, Failure>> familyTakeAction(
      String reqId, String status) async {
    final result = await baseRepositoryProfile.familyTakeAction(reqId, status);
    return result;
  }
}
