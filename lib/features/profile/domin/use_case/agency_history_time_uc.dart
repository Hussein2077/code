import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/data/model/agency_time_history_model.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';

class AgencyHistoryTimemUsecase {
  BaseRepositoryProfile baseRepositoryProfile;
  AgencyHistoryTimemUsecase({required this.baseRepositoryProfile});
  Future<Either<List<AgencyHistoryTime>, Failure>> agencyHistoryTime() async {
    final result = await baseRepositoryProfile.agencyTimeHistory();
    return result;
  }
}