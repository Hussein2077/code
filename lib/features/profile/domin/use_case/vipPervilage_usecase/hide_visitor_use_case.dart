import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';



class HideVisitorUseCase {
  BaseRepositoryProfile baseRepositoryProfile;
  HideVisitorUseCase({required this.baseRepositoryProfile});
  Future<Either<String, Failure>> hideVisitorUseCase(String type) async {
    return await baseRepositoryProfile.hideVisitor(type);
  }
}