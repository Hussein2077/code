

import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/data/model/gold_coin_model.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';




class GetGoldCoinDataUseCase {
  BaseRepositoryProfile baseRepositoryProfile;
  GetGoldCoinDataUseCase({required this.baseRepositoryProfile});
  Future<Either<List<GoldCoinsModel>, Failure>> getGoldCoinData() async {
    final result = await baseRepositoryProfile.getGoldCoinData();
    return result ;
  }
}