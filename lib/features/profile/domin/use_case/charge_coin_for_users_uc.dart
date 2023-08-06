import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';

class ChargeCoinForUserUsecase {
  BaseRepositoryProfile baseRepositoryProfile;
  ChargeCoinForUserUsecase({required this.baseRepositoryProfile});
  Future<Either<String, Failure>> chargeCoinForUsers({required String id ,required String amount}) async {
    final result = await baseRepositoryProfile.chargeCoinForUsers(id: id , amount:amount);
    return result;
  }
}