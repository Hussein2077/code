import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';

class AddInterstedUsecase {
  BaseRepositoryProfile baseRepositoryProfile;
  AddInterstedUsecase({required this.baseRepositoryProfile});
  Future<Either<String, Failure>> addIntrested(List<int> ids) async {
    final result = await baseRepositoryProfile.addIntersted(ids);
    return result;
  }
}