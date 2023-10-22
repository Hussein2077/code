import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';

class InAppPurchaseUsecase {
  
  BaseRepositoryProfile baseRepositoryProfile;
  InAppPurchaseUsecase({required this.baseRepositoryProfile});

  Future<Either<String, Failure>> inAppPurchase({required String user_id, required String product_id}) async {
    final result = await baseRepositoryProfile.inAppPurchase(user_id: user_id, product_id: product_id);
    return result;
  }

}