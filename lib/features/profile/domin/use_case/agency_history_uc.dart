import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/data/model/agency_history_model.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';

class AgencyHistoryUsecase {
  BaseRepositoryProfile baseRepositoryProfile;
  AgencyHistoryUsecase({required this.baseRepositoryProfile});
  Future<Either<AgencyHistoryModle, Failure>> agencyHistory({required String month ,required String year ,String? page}) async {
    final result = await baseRepositoryProfile.agencyHistory(month: month , year:year , page:page);
    return result;
  }
}