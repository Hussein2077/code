import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/Base_Use_Case/Base_Use_Case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';

class MomentSendGiftUseCase extends BaseUseCase<String, MomentSendGiftPrameter> {
  BaseRepositoryProfile baseRepositoryProfile;
  MomentSendGiftUseCase({required this.baseRepositoryProfile});
  @override
  Future<Either<String, Failure>> call(MomentSendGiftPrameter parameter) async {
    final result = await baseRepositoryProfile.momentSendGift(parameter);
    return result;
  }
}

class MomentSendGiftPrameter {
  final String userId;

  final String giftId;

  final String giftNum;

  const MomentSendGiftPrameter(
      {required this.giftNum, required this.userId, required this.giftId});
}
