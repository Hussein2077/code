import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';


class PrevActiveUseCases {
  BaseRepositoryProfile baseRepositoryProfile;

  PrevActiveUseCases({required this.baseRepositoryProfile});

  Future<Either<String, Failure>> prevActive(String type) async {
    return await baseRepositoryProfile.prevActive(type);
  }
}
