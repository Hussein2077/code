import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/data/model/agency_member_model.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';

class AgencyMembermUsecase {
  BaseRepositoryProfile baseRepositoryProfile;
  AgencyMembermUsecase({required this.baseRepositoryProfile});
  Future<Either<List<AgencyMemberModel>, Failure>> agencyMember(int page) async {
    final result = await baseRepositoryProfile.agencyMember(page);
    return result;
  }
}