

import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';



class UseItemUseCase {
  BaseRepositoryProfile baseRepositoryProfile;
  UseItemUseCase({required this.baseRepositoryProfile});
  Future<Either<String, Failure>> useItem(String id) async {
    final result = await baseRepositoryProfile.useItem(id);
    return result;
  }
}
