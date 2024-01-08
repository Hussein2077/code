import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';

import '../../../../core/error/failures.dart';

class ApplePayUsecase {
  BaseRepositoryProfile baseRepositoryProfile;
  ApplePayUsecase({required this.baseRepositoryProfile});

  Future<Either<String, Failure>> applePay({required String data}) async {
    final result = await baseRepositoryProfile.applePay(
      data: data,
    );
    return result;
  }
}
