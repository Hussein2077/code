

import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';


class DisposeMyseteriousManUseCase {
  BaseRepositoryProfile baseRepositoryProfile;
  DisposeMyseteriousManUseCase({required this.baseRepositoryProfile});
  Future<Either<String, Failure>> disposeMyseteriousManUseCase(String type) async {
    return await baseRepositoryProfile.disposeMyseteriousMan(type);
  }
}