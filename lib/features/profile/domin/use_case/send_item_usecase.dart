
import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';



class SendItemUsecase {
  BaseRepositoryProfile baseRepositoryProfile;
  SendItemUsecase({required this.baseRepositoryProfile});
  Future<Either<String, Failure>> sendItem(String packId, String touid) async {
    final result = await baseRepositoryProfile.sendItem(packId, touid);
    return result;
  }
}
