import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';


class DisposeHideCountryUseCase {
  BaseRepositoryProfile baseRepositoryProfile;
  DisposeHideCountryUseCase({required this.baseRepositoryProfile});
  Future<Either<String, Failure>> disposeHideCountryUseCase(String type) async {
    return await baseRepositoryProfile.disposeHideCountry(type);
  }
}