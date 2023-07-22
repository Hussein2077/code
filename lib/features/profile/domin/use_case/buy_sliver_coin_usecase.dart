

import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';


class BuySilverCoinUseCase {
  BaseRepositoryProfile baseRepositoryProfile;
  BuySilverCoinUseCase({required this.baseRepositoryProfile});
  Future<Either<String, Failure>> buySilverCoin(String silverId ) async {
    final result = await baseRepositoryProfile.buySilverCoin(silverId);
    return result;
  }
}