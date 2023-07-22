

import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';


class ExchangeDimondsUseCase {
  BaseRepositoryProfile baseRepositoryProfile;
  ExchangeDimondsUseCase({required this.baseRepositoryProfile});
  Future<Either<String, Failure>> exchangeDimonds(String itemId) async {
    final result = await baseRepositoryProfile.exchangeDimond(itemId);
    return result ;
  }
}