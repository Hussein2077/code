import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';

import '../../../../core/error/failures.dart';

class HuaweiPayUsecase {
  BaseRepositoryProfile baseRepositoryProfile;
  HuaweiPayUsecase({required this.baseRepositoryProfile});

  Future<Either<String, Failure>> huaweiPay({required String product_id, required String token}) async {
    final result = await baseRepositoryProfile.huaweiPay(product_id: product_id, token: token);
    return result;
  }
}