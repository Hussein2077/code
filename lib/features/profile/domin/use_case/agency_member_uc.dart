import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';

class AgencyMembermUsecase {
  BaseRepositoryProfile baseRepositoryProfile;
  AgencyMembermUsecase({required this.baseRepositoryProfile});
  Future<Either<List<OwnerDataModel>, Failure>> agencyMember(int page) async {
    final result = await baseRepositoryProfile.agencyMember(page);
    return result;
  }
}