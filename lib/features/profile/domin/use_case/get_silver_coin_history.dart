

import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/data/model/silver_history.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';



class GetSilverCoinHistoryUseCase {
  BaseRepositoryProfile baseRepositoryProfile;
  GetSilverCoinHistoryUseCase({required this.baseRepositoryProfile});
  Future<Either<List<SilverCoinHistory>, Failure>> getSilverCoinHistory() async {
    final result = await baseRepositoryProfile.getSilverHistory();
    return result ;
  }
}