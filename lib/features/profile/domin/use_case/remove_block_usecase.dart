

import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';



class RemoveBlockUseCase {
  BaseRepositoryProfile baseRepositoryProfile;
  RemoveBlockUseCase({required this.baseRepositoryProfile});
  Future<Either<String, Failure>> removeBlock(String userId) async {
    final result = await baseRepositoryProfile.removeBlock(userId);
    return result;
  }
}
