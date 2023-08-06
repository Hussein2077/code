import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';

class ChargeDolarsForUserUsecase {
  BaseRepositoryProfile baseRepositoryProfile;
  ChargeDolarsForUserUsecase({required this.baseRepositoryProfile});
  Future<Either<String, Failure>> chargeDolarsForUsers({required String id ,required String amount}) async {
    final result = await baseRepositoryProfile.chargeDolarsForUsers(id: id , amount:amount);
    return result;
  }
}