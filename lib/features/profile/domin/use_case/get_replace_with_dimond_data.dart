

import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/data/model/replace_with_gold_model.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';



class GetReplaceWithGoldUseCase {
  BaseRepositoryProfile baseRepositoryProfile;
  GetReplaceWithGoldUseCase({required this.baseRepositoryProfile});
  Future<Either<ReplaceWithGoldModel, Failure>> getReplaceWithGold() async {
    final result = await baseRepositoryProfile.replaceWithGold();
    return result ;
  }
}