

import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';


class UnusedItemUsecase {
  BaseRepositoryProfile baseRepositoryProfile;
  UnusedItemUsecase({required this.baseRepositoryProfile});
  Future<Either<String, Failure>> unUsedItem(String id) async {
    final result = await baseRepositoryProfile.unusedItem(id);
    return result;
  }
}
