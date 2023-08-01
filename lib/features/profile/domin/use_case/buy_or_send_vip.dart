

import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';


class BuyOrSendVipUseCase {
  BaseRepositoryProfile baseRepositoryProfile;
  BuyOrSendVipUseCase({required this.baseRepositoryProfile});
  Future<Either<String, Failure>> buyOrSendVip(String type , String vipId , String toUID ) async {
    final result = await baseRepositoryProfile.buyOrSendVip(type , vipId , toUID);
    return result;
  }
}