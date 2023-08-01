import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';


class DeleteFamilyUseCse {
  BaseRepositoryProfile baseRepositoryProfile;
  DeleteFamilyUseCse({required this.baseRepositoryProfile});
  Future<Either<String, Failure>> deleteFamily(String id) async {
    final result = await baseRepositoryProfile.deletFamily(id);
    return result;
  }
}
