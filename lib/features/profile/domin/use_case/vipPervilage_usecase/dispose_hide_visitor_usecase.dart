import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';


class DisposeHideVisitorUseCase {
  BaseRepositoryProfile baseRepositoryProfile;
  DisposeHideVisitorUseCase({required this.baseRepositoryProfile});
  Future<Either<String, Failure>> disposeHideVisitorUseCase(String type) async {
    return await baseRepositoryProfile.disposeHideVisitor(type);
  }
}