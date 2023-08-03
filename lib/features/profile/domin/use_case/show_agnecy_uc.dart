import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/data/model/show_agency_model.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';

class ShowAgencymUsecase {
  BaseRepositoryProfile baseRepositoryProfile;
  ShowAgencymUsecase({required this.baseRepositoryProfile});
  Future<Either<ShowAgencyModel, Failure>> showAgency() async {
    final result = await baseRepositoryProfile.showAgency();
    return result;
  }
}