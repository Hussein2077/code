import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';

class AgencyRequestsUsecase {
  BaseRepositoryProfile baseRepositoryProfile;
  AgencyRequestsUsecase({required this.baseRepositoryProfile});
  Future<Either<List<OwnerDataModel>, Failure>> agencyRequsets() async {
    final result = await baseRepositoryProfile.agencyRequests();
    return result;
  }
}