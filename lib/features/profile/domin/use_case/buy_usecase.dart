
import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';


class BuyUseCase {
  BaseRepositoryProfile baseRepositoryProfile;
  BuyUseCase({required this.baseRepositoryProfile});
  Future<Either<String, Failure>> buy(String idItem, String quantity) async {
    final result = await baseRepositoryProfile.buy(idItem, quantity);
    return result;
  }
}
