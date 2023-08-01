

import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/data/model/gift_history_model.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';


class GiftHistorykUseCase {
  BaseRepositoryProfile baseRepositoryProfile;
  GiftHistorykUseCase({required this.baseRepositoryProfile});
  Future<Either<List<GiftHistoryModel>, Failure>> getGiftHistory(String id) async {
    final result = await baseRepositoryProfile.getGiftHistory(id);
    return result ;
  }
}