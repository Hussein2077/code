import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';

import '../../../../core/error/failures.dart';

class PayUsecase {
  BaseRepositoryProfile baseRepositoryProfile;
  PayUsecase({required this.baseRepositoryProfile});

  Future<Either<String, Failure>> googlePay({required String data}) async {
    final result = await baseRepositoryProfile.googlePay(data: data);
    return result;
  }
}
