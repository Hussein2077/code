

import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/data/model/silver_coins_model.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';



class GetSilverCoinDataUseCase {
  BaseRepositoryProfile baseRepositoryProfile;
  GetSilverCoinDataUseCase({required this.baseRepositoryProfile});
  Future<Either<SilverCoinsModel, Failure>> getSilverCoinData() async {
    final result = await baseRepositoryProfile.getSilverData();
    return result ;
  }
}