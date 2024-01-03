import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';

import '../../../../core/error/failures.dart';

class PayUsecase {
  BaseRepositoryProfile baseRepositoryProfile;
  PayUsecase({required this.baseRepositoryProfile});

  Future<Either<String, Failure>> pay({required String product_id, required String order_id}) async {
    final result = await baseRepositoryProfile.pay(product_id: product_id, order_id: order_id);
    return result;
  }
}