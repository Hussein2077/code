import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';


class DisposeLastCommunicationTimeUseCases {
  BaseRepositoryProfile baseRepositoryProfile;
  DisposeLastCommunicationTimeUseCases({required this.baseRepositoryProfile});
  Future<Either<String, Failure>> disposeLastCommunicationTimeUseCases(String type) async {
    return await baseRepositoryProfile.dipsoseLastCommunicationTime(type);
  }
}