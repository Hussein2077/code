
import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';

class DeleteReelUseCse {
  BaseRepositoryProfile baseRepositoryProfile;
  DeleteReelUseCse({required this.baseRepositoryProfile});
  Future<Either<String, Failure>> deleteReel(String id) async {
    final result = await baseRepositoryProfile.deleteReel(id);
    return result;
  }
}