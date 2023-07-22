


import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/data/model/fanily_rank_model.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';


class FamilyRankingUsecase {
  BaseRepositoryProfile baseRepositoryProfile;
  FamilyRankingUsecase({required this.baseRepositoryProfile});
  Future<Either<FamilyRankModel, Failure>> familyRanking(String time) async {
    final result = await baseRepositoryProfile.familyRanking(time);
    return result;
  }
}
