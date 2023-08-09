import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/data/model/intrested_model.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';

class GetAllIntrestedUseCase {
  BaseRepositoryProfile baseRepositoryProfile;
  GetAllIntrestedUseCase({required this.baseRepositoryProfile});
  Future<Either<List<InterstedMode>, Failure>> getAllIntersted() async {
    final result = await baseRepositoryProfile.getAllIntersted();
    return result;
  }
}