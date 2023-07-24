import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';


class AddBlockUseCase {
  BaseRepositoryProfile baseRepositoryProfile;
  AddBlockUseCase({required this.baseRepositoryProfile});
  Future<Either<String, Failure>> addBlock(String userId) async {
    final result = await baseRepositoryProfile.addBlock(userId);
    return result;
  }
}
