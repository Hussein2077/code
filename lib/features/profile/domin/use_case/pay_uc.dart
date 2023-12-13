import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';

import '../../../../core/error/failures.dart';

class PayUsecase {
  BaseRepositoryProfile baseRepositoryProfile;
  PayUsecase({required this.baseRepositoryProfile});

  Future<Either<String, Failure>> pay({required String message, required String type}) async {
    final result = await baseRepositoryProfile.pay(message: message, type: type);
    return result;
  }
}