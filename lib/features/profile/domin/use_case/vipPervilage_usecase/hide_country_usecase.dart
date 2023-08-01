import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';



class HideCountryUseCase {
  BaseRepositoryProfile baseRepositoryProfile;
  HideCountryUseCase({required this.baseRepositoryProfile});
  Future<Either<String, Failure>> hideCountryUseCase(String type) async {
    return await baseRepositoryProfile.hideCountry(type);
  }
}