

import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/data/model/family_member_model.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';



class GetFamilyMemberUseCase {
  BaseRepositoryProfile baseRepositoryProfile;
  GetFamilyMemberUseCase({required this.baseRepositoryProfile});
  Future<Either<FamilyMemberModel, Failure>> getFamilyMember(
      String familyId , String? page) async {
    final result = await baseRepositoryProfile.getFamilyMember(familyId , page);
    return result;
  }
}
